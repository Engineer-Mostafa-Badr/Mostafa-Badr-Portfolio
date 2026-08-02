import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isMobile = device == DeviceType.mobile;
    final iconSize = isMobile ? 20.0 : 22.0;
    final ar = isArabic(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ─── Social icons row ───
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 18,
          runSpacing: 10,
          children: [
            _SocialIcon(
              icon: FontAwesomeIcons.linkedin,
              color: const Color(0xFF0A66C2),
              url: 'https://www.linkedin.com/in/engineer-mostafa-badr/',
              tooltip: 'LinkedIn',
              size: iconSize,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.github,
              color: Colors.white,
              url: 'https://github.com/Engineer-Mostafa-Badr',
              tooltip: 'GitHub',
              size: iconSize,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.facebook,
              color: const Color(0xFF1877F2),
              url: 'https://web.facebook.com/Engineer.Mostafa.Badr/',
              tooltip: 'Facebook',
              size: iconSize,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.instagram,
              color: const Color(0xFFE4405F),
              url: 'https://www.instagram.com/engineer_mostafa_badr/',
              tooltip: 'Instagram',
              size: iconSize,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.tiktok,
              color: Colors.white,
              url: 'https://www.tiktok.com/@engineer_mostafa_badr',
              tooltip: 'TikTok',
              size: iconSize,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.youtube,
              color: const Color(0xFFFF0000),
              url: 'https://www.youtube.com/@Engineer_Mostafa_Badr',
              tooltip: 'YouTube',
              size: iconSize,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.xTwitter,
              color: Colors.white,
              url: 'https://x.com/EngMostafa_Badr',
              tooltip: 'X',
              size: iconSize,
            ),
            _SocialIcon(
              icon: FontAwesomeIcons.solidEnvelope,
              color: const Color(0xFFFFA000),
              url: _mailtoUrl(),
              tooltip: 'Email',
              size: iconSize,
            ),
          ],
        ),
        const SizedBox(height: 22),
        // ─── Quick attribution row ───
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14,
          runSpacing: 8,
          children: [
            _FooterChip(
              icon: FontAwesomeIcons.flutter,
              iconColor: const Color(0xFF42A5F5),
              label: ar ? 'مبني بـ Flutter' : 'Built with Flutter',
              url: 'https://flutter.dev',
            ),
            _FooterChip(
              icon: FontAwesomeIcons.cloud,
              iconColor: const Color(0xFFF6821F),
              label: ar ? 'مستضاف على Cloudflare' : 'Hosted on Cloudflare',
              url: 'https://cloudflare.com',
            ),
            _FooterChip(
              icon: FontAwesomeIcons.github,
              iconColor: Colors.white,
              label: ar ? 'الكود مفتوح' : 'View source',
              url: 'https://github.com/Engineer-Mostafa-Badr/Mostafa-Badr-Portfolio',
            ),
            const _LighthouseBadge(),
          ],
        ),
      ],
    );
  }

  String _mailtoUrl() {
    const email = 'mostafamostafabadrbadr@gmail.com';
    final subject = Uri.encodeComponent('Hello Mostafa');
    final body = Uri.encodeComponent(
      'Hi Mostafa,\n\nI would like to get in touch with you regarding...',
    );
    return 'mailto:$email?subject=$subject&body=$body';
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String url;
  final String tooltip;
  final double size;

  const _SocialIcon({
    required this.icon,
    required this.color,
    required this.url,
    required this.tooltip,
    required this.size,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: () => openUrl(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovering
                  ? widget.color.withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.04),
              border: Border.all(
                color: _hovering
                    ? widget.color.withValues(alpha: 0.45)
                    : Colors.white.withValues(alpha: 0.08),
              ),
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.30),
                        blurRadius: 14,
                      ),
                    ]
                  : null,
            ),
            transform: Matrix4.translationValues(0, _hovering ? -2 : 0, 0),
            child: FaIcon(widget.icon, color: widget.color, size: widget.size),
          ),
        ),
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String url;

  const _FooterChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => openUrl(url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, color: iconColor, size: 12),
              const SizedBox(width: 7),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w600,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Lighthouse score badge — opens PageSpeed Insights for the site.
class _LighthouseBadge extends StatelessWidget {
  const _LighthouseBadge();

  @override
  Widget build(BuildContext context) {
    const targetUrl = 'https://pagespeed.web.dev/analysis?url='
        'https%3A%2F%2Fmostafabadr.com%2F';
    return Tooltip(
      message: isArabic(context)
          ? 'افتح تقرير Lighthouse على PageSpeed Insights'
          : 'Open Lighthouse report on PageSpeed Insights',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => openUrl(targetUrl),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  AppPalette.statusOnline.withValues(alpha: 0.18),
                  AppPalette.statusOnline.withValues(alpha: 0.06),
                ],
              ),
              border: Border.all(
                color: AppPalette.statusOnline.withValues(alpha: 0.45),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🚀', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 6),
                Text(
                  'Lighthouse 95+',
                  style: TextStyle(
                    color: AppPalette.statusOnline,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
