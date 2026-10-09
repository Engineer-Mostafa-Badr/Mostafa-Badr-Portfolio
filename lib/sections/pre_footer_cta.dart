import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_assets.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/contact_links.dart';
import 'package:mostafa_badr_portfolio/widgets/common/app_button.dart';
import 'package:mostafa_badr_portfolio/widgets/common/gradient_text.dart';

/// Last-chance call-to-action before the footer.
///
/// The pattern Stripe, Vercel, and Linear all use — when a visitor reaches the
/// bottom, give them one clear, large next step instead of a dead end.
class PreFooterCta extends StatelessWidget {
  const PreFooterCta({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final ar = isArabic(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 22 : 48,
        vertical: isMobile ? 36 : 56,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.ctaBanner,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: 0.20),
            blurRadius: 40,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRect(
        // The decorative orbs are positioned outside the content box; clipping
        // keeps them from bleeding past the banner's rounded corners.
        child: Stack(
          children: [
            const Positioned(
              top: -40,
              right: -40,
              child: _GlowOrb(size: 200, color: AppColors.gold),
            ),
            const Positioned(
              bottom: -60,
              left: -60,
              child: _GlowOrb(size: 240, color: AppColors.purple),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _AvailabilityEyebrow(),
                const SizedBox(height: AppSizes.xl),
                GradientText.titleSheen(
                  Tr.k(context, 'cta.headline'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 26 : 38,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: AppSizes.md),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSizes.ctaCopyMaxWidth,
                  ),
                  child: Text(
                    Tr.k(context, 'cta.body'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppSizes.md,
                  runSpacing: AppSizes.md,
                  children: [
                    AppButton(
                      label: Tr.k(context, 'hero.ctaScheduleCall'),
                      icon: Icons.event_available_outlined,
                      size: isMobile
                          ? AppButtonSize.medium
                          : AppButtonSize.large,
                      onPressed: () => openUrl(
                        scheduleCallLink(arabic: ar),
                        context: context,
                      ),
                    ),
                    AppButton(
                      label: Tr.k(context, 'hero.ctaCV'),
                      icon: Icons.download_rounded,
                      variant: AppButtonVariant.secondary,
                      size: isMobile
                          ? AppButtonSize.medium
                          : AppButtonSize.large,
                      onPressed: () =>
                          openUrl(AppAssets.cvPdf, context: context),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.lg),
                const _TrustLine(),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms)
        .slideY(begin: 0.10, end: 0, curve: Curves.easeOutCubic);
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: 0.18), Colors.transparent],
          ),
        ),
      ),
    );
  }
}

class _AvailabilityEyebrow extends StatelessWidget {
  const _AvailabilityEyebrow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.xs + 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppSizes.radiusPill),
        border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.flash_on_rounded,
            size: 14,
            color: AppColors.gold,
          ),
          const SizedBox(width: AppSizes.xs + 2),
          Flexible(
            child: Text(
              Tr.k(context, 'cta.available'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustLine extends StatelessWidget {
  const _TrustLine();

  @override
  Widget build(BuildContext context) {
    final muted = Colors.white.withValues(alpha: 0.7);

    // A Row here clipped the sentence on narrow phones; wrapping lets the
    // icon and text move to separate lines instead of overflowing.
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSizes.xs + 2,
      children: [
        Icon(Icons.schedule_outlined, size: 14, color: muted),
        Text(
          Tr.k(context, 'cta.trust'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: muted,
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
