import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_links.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/contact_links.dart';

/// A social profile: brand icon, brand colour, destination.
typedef _SocialLink = ({IconData icon, Color color, String url, String name});

const _socialLinks = <_SocialLink>[
  (
    icon: FontAwesomeIcons.linkedin,
    color: AppColors.linkedIn,
    url: AppLinks.linkedIn,
    name: 'LinkedIn',
  ),
  (
    icon: FontAwesomeIcons.github,
    color: Colors.white,
    url: AppLinks.github,
    name: 'GitHub',
  ),
  (
    icon: FontAwesomeIcons.facebook,
    color: AppColors.facebook,
    url: AppLinks.facebook,
    name: 'Facebook',
  ),
  (
    icon: FontAwesomeIcons.instagram,
    color: AppColors.instagram,
    url: AppLinks.instagram,
    name: 'Instagram',
  ),
  (
    icon: FontAwesomeIcons.tiktok,
    color: Colors.white,
    url: AppLinks.tiktok,
    name: 'TikTok',
  ),
  (
    icon: FontAwesomeIcons.youtube,
    color: AppColors.youTube,
    url: AppLinks.youtube,
    name: 'YouTube',
  ),
  (
    icon: FontAwesomeIcons.xTwitter,
    color: Colors.white,
    url: AppLinks.x,
    name: 'X',
  ),
];

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final iconSize = isMobile ? 20.0 : 22.0;
    final ar = isArabic(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSizes.headerGap,
          runSpacing: AppSizes.md - 2,
          children: [
            for (final link in _socialLinks)
              _SocialIcon(
                icon: link.icon,
                color: link.color,
                url: link.url,
                tooltip: link.name,
                size: iconSize,
              ),
            _SocialIcon(
              icon: FontAwesomeIcons.solidEnvelope,
              color: AppColors.emailAmber,
              url: emailLink(arabic: ar),
              tooltip: Tr.k(context, 'contact.email'),
              size: iconSize,
            ),
          ],
        ),
        const SizedBox(height: 22),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 14,
          runSpacing: AppSizes.sm,
          children: [
            _FooterChip(
              icon: FontAwesomeIcons.flutter,
              iconColor: AppColors.flutterBlue,
              label: Tr.k(context, 'footer.builtWith'),
              url: AppLinks.flutterHome,
            ),
            _FooterChip(
              icon: FontAwesomeIcons.cloud,
              iconColor: AppColors.cloudflare,
              label: Tr.k(context, 'footer.hostedOn'),
              url: AppLinks.cloudflareHome,
            ),
            _FooterChip(
              icon: FontAwesomeIcons.github,
              iconColor: Colors.white,
              label: Tr.k(context, 'footer.viewSource'),
              url: AppLinks.repository,
            ),
            const _LighthouseBadge(),
          ],
        ),
      ],
    );
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
      child: Semantics(
        button: true,
        label: widget.tooltip,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovering = true),
          onExit: (_) => setState(() => _hovering = false),
          child: GestureDetector(
            onTap: () => openUrl(widget.url, context: context),
            child: AnimatedContainer(
              duration: AppDurations.quick,
              curve: Curves.easeOut,
              padding: const EdgeInsets.all(AppSizes.md - 2),
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
              child: FaIcon(
                widget.icon,
                color: widget.color,
                size: widget.size,
              ),
            ),
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
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        onTap: () => openUrl(url, context: context),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, color: iconColor, size: 12),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Lighthouse score badge — opens PageSpeed Insights for the live site.
class _LighthouseBadge extends StatelessWidget {
  const _LighthouseBadge();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: Tr.k(context, 'footer.lighthouse'),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          onTap: () => openUrl(AppLinks.pageSpeedReport, context: context),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusPill),
              gradient: LinearGradient(
                colors: [
                  AppColors.success.withValues(alpha: 0.18),
                  AppColors.success.withValues(alpha: 0.06),
                ],
              ),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.45),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🚀', style: TextStyle(fontSize: 12)),
                SizedBox(width: AppSizes.xs + 2),
                Text(
                  'Lighthouse 95+',
                  style: TextStyle(
                    color: AppColors.success,
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
