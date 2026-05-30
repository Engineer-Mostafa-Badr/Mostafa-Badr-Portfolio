import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';

/// Inline contact form that submits to Formspree.
///
/// Configure your Formspree endpoint by editing [_formspreeEndpoint].
/// Steps:
///   1. Go to https://formspree.io and sign up (free tier: 50 submissions/month).
///   2. Create a new form — set the email destination.
///   3. Copy the form endpoint URL (looks like https://formspree.io/f/xyzabcd).
///   4. Replace the [_formspreeEndpoint] constant below.
///
/// The form gracefully handles loading, success, and error states.
class InlineContactForm extends StatefulWidget {
  const InlineContactForm({super.key});

  /// Formspree endpoint — receives submissions for engineermostafabadr@gmail.
  static const String _formspreeEndpoint =
      'https://formspree.io/f/xnjrrlqw';

  static bool get _isConfigured =>
      !_formspreeEndpoint.contains('YOUR_FORM_ID');

  @override
  State<InlineContactForm> createState() => _InlineContactFormState();
}

enum _FormStatus { idle, sending, success, error }

class _InlineContactFormState extends State<InlineContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  _FormStatus _status = _FormStatus.idle;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String fieldLabel) {
    if (value == null || value.trim().isEmpty) {
      return isArabic(context)
          ? '$fieldLabel مطلوب'
          : '$fieldLabel is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final ar = isArabic(context);
    if (value == null || value.trim().isEmpty) {
      return ar ? 'الإيميل مطلوب' : 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w.\-]+@[\w\-]+\.[\w.\-]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return ar ? 'إيميل غير صالح' : 'Invalid email';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!InlineContactForm._isConfigured) {
      setState(() {
        _status = _FormStatus.error;
        _errorMessage = isArabic(context)
            ? 'الـ form مش متظبط — حدّث Formspree endpoint في الكود'
            : 'Form not configured — set Formspree endpoint in code';
      });
      return;
    }

    setState(() {
      _status = _FormStatus.sending;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse(InlineContactForm._formspreeEndpoint),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'message': _messageController.text.trim(),
          '_replyto': _emailController.text.trim(),
          '_subject':
              'Portfolio contact from ${_nameController.text.trim()}',
        }),
      );

      if (!mounted) return;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        setState(() => _status = _FormStatus.success);
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        // Auto-reset after 6 seconds so the user can send another message
        Timer(const Duration(seconds: 6), () {
          if (mounted) setState(() => _status = _FormStatus.idle);
        });
      } else {
        setState(() {
          _status = _FormStatus.error;
          _errorMessage = isArabic(context)
              ? 'فشل الإرسال — حاول تاني أو استخدم الواتساب'
              : 'Submission failed — please try WhatsApp instead';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _status = _FormStatus.error;
        _errorMessage = isArabic(context)
            ? 'مشكلة في الشبكة — حاول تاني'
            : 'Network error — please try again';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ar = isArabic(context);
    final isMobile = MediaQuery.of(context).size.width < 700;

    if (_status == _FormStatus.success) {
      return _SuccessState(arabic: ar);
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ar
                ? 'أو ابعتلي رسالة مباشرة'
                : 'Or drop me a quick message',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          // Name + Email row (stacked on mobile)
          if (isMobile) ...[
            _buildField(
              controller: _nameController,
              label: ar ? 'اسمك' : 'Your name',
              icon: Icons.person_outline,
              validator: (v) => _validateRequired(v, ar ? 'الاسم' : 'Name'),
            ),
            const SizedBox(height: 10),
            _buildField(
              controller: _emailController,
              label: ar ? 'الإيميل' : 'Your email',
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: _buildField(
                    controller: _nameController,
                    label: ar ? 'اسمك' : 'Your name',
                    icon: Icons.person_outline,
                    validator: (v) =>
                        _validateRequired(v, ar ? 'الاسم' : 'Name'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildField(
                    controller: _emailController,
                    label: ar ? 'الإيميل' : 'Your email',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 10),
          _buildField(
            controller: _messageController,
            label: ar ? 'الرسالة' : 'Your message',
            icon: Icons.chat_outlined,
            maxLines: 4,
            validator: (v) =>
                _validateRequired(v, ar ? 'الرسالة' : 'Message'),
          ),
          const SizedBox(height: 14),
          if (_status == _FormStatus.error && _errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.withValues(alpha: 0.35)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.redAccent, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          SizedBox(
            width: isMobile ? double.infinity : null,
            child: ElevatedButton.icon(
              onPressed: _status == _FormStatus.sending ? null : _submit,
              icon: _status == _FormStatus.sending
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Icon(Icons.send_rounded, size: 16),
              label: Text(
                _status == _FormStatus.sending
                    ? (ar ? 'جاري الإرسال…' : 'Sending…')
                    : (ar ? 'إرسال الرسالة' : 'Send message'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                foregroundColor: Colors.black,
                disabledBackgroundColor:
                    const Color(0xFFFFD700).withValues(alpha: 0.4),
                disabledForegroundColor: Colors.black.withValues(alpha: 0.6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(icon, size: 18, color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.04),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: AppPalette.accentCyan, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.6)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        ),
        errorStyle: const TextStyle(fontSize: 11, height: 1.2),
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  final bool arabic;
  const _SuccessState({required this.arabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF34D399).withValues(alpha: 0.18),
            const Color(0xFF10B981).withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF34D399).withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF34D399).withValues(alpha: 0.20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: Color(0xFF34D399),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  arabic ? 'تمام، وصلتني رسالتك!' : 'Got it — message received!',
                  style: const TextStyle(
                    color: Color(0xFF34D399),
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  arabic
                      ? 'هرد عليك في أقل من 24 ساعة.'
                      : "I'll get back to you in under 24 hours.",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .scaleXY(begin: 0.95, end: 1.0, curve: Curves.easeOut);
  }
}
