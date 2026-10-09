import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_links.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/errors/app_failure.dart';
import 'package:mostafa_badr_portfolio/core/services/contact_service.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/contact_links.dart';
import 'package:mostafa_badr_portfolio/widgets/common/app_button.dart';

/// Inline contact form.
///
/// Every outcome of the submission is represented on screen: sending, sent, or
/// a specific failure with a specific next step. When the failure means the
/// form itself cannot deliver — misconfigured endpoint, server down, rate
/// limit — the error panel also offers WhatsApp, so the visitor is never left
/// at a dead end holding a message they wanted to send.
class InlineContactForm extends StatefulWidget {
  const InlineContactForm({super.key});

  @override
  State<InlineContactForm> createState() => _InlineContactFormState();
}

enum _FormStatus { idle, sending, success, error }

class _InlineContactFormState extends State<InlineContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _contactService = ContactService();

  _FormStatus _status = _FormStatus.idle;
  AppFailure? _failure;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _contactService.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String fieldKey) {
    if (value == null || value.trim().isEmpty) {
      return Tr.k(context, 'form.required')
          .withArgs({'field': Tr.k(context, fieldKey)});
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Tr.k(context, 'form.required')
          .withArgs({'field': Tr.k(context, 'form.emailField')});
    }
    final emailRegex = RegExp(r'^[\w.\-+]+@[\w\-]+\.[\w.\-]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return Tr.k(context, 'form.invalidEmail');
    }
    return null;
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _status = _FormStatus.sending;
      _failure = null;
    });

    final result = await _contactService.send(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      message: _messageController.text.trim(),
    );

    if (!mounted) return;

    switch (result) {
      case ContactSuccess():
        setState(() => _status = _FormStatus.success);
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        // Return to the form after a beat so a second message is possible
        // without a page reload.
        _resetTimer?.cancel();
        _resetTimer = Timer(AppDurations.formSuccessReset, () {
          if (mounted) setState(() => _status = _FormStatus.idle);
        });
      case ContactFailed(:final failure):
        setState(() {
          _status = _FormStatus.error;
          _failure = failure;
        });
    }
  }

  /// Hands the visitor's typed message straight to WhatsApp so a failed
  /// submission does not mean retyping it.
  void _sendViaWhatsApp() {
    final message = _messageController.text.trim();
    final name = _nameController.text.trim();
    final fallback = message.isEmpty
        ? scheduleCallLink(arabic: isArabic(context))
        : _whatsappWithDraft(name: name, body: message);
    openUrl(fallback, context: context);
  }

  String _whatsappWithDraft({required String name, required String body}) {
    final greeting = isArabic(context) ? 'مرحباً مصطفى،' : 'Hi Mostafa,';
    final signature = name.isEmpty ? '' : '\n\n— $name';
    return AppLinks.whatsappWith('$greeting\n\n$body$signature');
  }

  @override
  Widget build(BuildContext context) {
    if (_status == _FormStatus.success) {
      return const _SuccessState();
    }

    final isMobile = context.isMobile;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Tr.k(context, 'form.prompt'),
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSizes.md),
          // Name and email share a row only where two fields still leave a
          // usable input width.
          if (isMobile) ...[
            _nameField(),
            const SizedBox(height: AppSizes.md - 2),
            _emailField(),
          ] else
            Row(
              children: [
                Expanded(child: _nameField()),
                const SizedBox(width: AppSizes.md),
                Expanded(child: _emailField()),
              ],
            ),
          const SizedBox(height: AppSizes.md - 2),
          _FormField(
            controller: _messageController,
            label: Tr.k(context, 'form.message'),
            icon: Icons.chat_outlined,
            maxLines: 4,
            validator: (v) => _validateRequired(v, 'form.messageField'),
          ),
          const SizedBox(height: 14),
          if (_status == _FormStatus.error && _failure != null) ...[
            _ErrorPanel(
              failure: _failure!,
              onUseWhatsApp: _sendViaWhatsApp,
            ),
            const SizedBox(height: AppSizes.md),
          ],
          AppButton(
            label: Tr.k(
              context,
              _status == _FormStatus.sending ? 'form.sending' : 'form.send',
            ),
            icon: Icons.send_rounded,
            busy: _status == _FormStatus.sending,
            expand: isMobile,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  Widget _nameField() => _FormField(
        controller: _nameController,
        label: Tr.k(context, 'form.name'),
        icon: Icons.person_outline,
        textInputAction: TextInputAction.next,
        validator: (v) => _validateRequired(v, 'form.nameField'),
      );

  Widget _emailField() => _FormField(
        controller: _emailController,
        label: Tr.k(context, 'form.email'),
        icon: Icons.mail_outline,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: _validateEmail,
      );
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const _FormField({
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
  });

  OutlineInputBorder _border(Color color, {double width = 1}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    final idle = Colors.white.withValues(alpha: 0.10);

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      // Validate as the visitor corrects a flagged field, so the error clears
      // the moment it is fixed rather than on the next submit.
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
          vertical: AppSizes.md,
        ),
        border: _border(idle),
        enabledBorder: _border(idle),
        focusedBorder: _border(AppColors.cyan, width: 1.4),
        errorBorder: _border(AppColors.danger.withValues(alpha: 0.6)),
        focusedErrorBorder: _border(AppColors.danger, width: 1.4),
        errorStyle: const TextStyle(fontSize: 11, height: 1.35),
        errorMaxLines: 3,
      ),
    );
  }
}

/// Failure panel: what went wrong, what to do about it, and — when the form
/// itself is the broken part — a one-tap route that still works.
class _ErrorPanel extends StatelessWidget {
  final AppFailure failure;
  final VoidCallback onUseWhatsApp;

  const _ErrorPanel({required this.failure, required this.onUseWhatsApp});

  /// Failures where retrying the form is unlikely to help soon, so WhatsApp is
  /// offered as the real way forward rather than a consolation.
  bool get _offersFallback => const {
        FailureKind.endpointUnavailable,
        FailureKind.serverError,
        FailureKind.rateLimited,
        FailureKind.offline,
        FailureKind.timeout,
        FailureKind.unexpectedResponse,
        FailureKind.unknown,
      }.contains(failure.kind);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.danger,
                size: 18,
              ),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      failure.title(context),
                      style: const TextStyle(
                        color: AppColors.danger,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Text(
                      failure.action(context),
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 12.5,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_offersFallback) ...[
            const SizedBox(height: AppSizes.md),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: AppButton(
                label: Tr.k(context, 'form.fallbackWhatsapp'),
                icon: Icons.chat_bubble_outline_rounded,
                size: AppButtonSize.small,
                variant: AppButtonVariant.accent,
                onPressed: onUseWhatsApp,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 250.ms).slideY(begin: -0.1, end: 0);
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.success.withValues(alpha: 0.18),
            AppColors.successDeep.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.md - 2),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.success,
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
                  Tr.k(context, 'form.successTitle'),
                  style: const TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: AppSizes.xs),
                Text(
                  Tr.k(context, 'form.successBody'),
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
