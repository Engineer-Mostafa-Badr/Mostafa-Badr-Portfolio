import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_assets.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/data/projects_data.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/contact_links.dart';
import 'package:mostafa_badr_portfolio/widgets/common/app_button.dart';
import 'package:mostafa_badr_portfolio/widgets/common/gradient_text.dart';
import 'package:mostafa_badr_portfolio/widgets/cv_preview_modal.dart';
import 'package:mostafa_badr_portfolio/widgets/stat_counter.dart';

const _platformBadgeKeys = [
  'hero.badge.android',
  'hero.badge.ios',
  'hero.badge.web',
  'hero.badge.desktop',
];

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusXxl),
      // Size from the slot, not the window: this section sits inside the
      // page's horizontal padding, so the window width would over-report how
      // much room the hero actually has.
      child: ResponsiveBuilder(
        builder: (context, constraints, device) {
          final isMobile = device == DeviceType.mobile;
          return Stack(
            children: [
              const Positioned.fill(child: _HeroBackdrop()),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? AppSizes.xl : 48,
                  vertical: isMobile ? AppSizes.xxxl : 44,
                ),
                child: isMobile
                    ? const _MobileHero()
                    : _DesktopHero(device: device),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Backdrop image plus its legibility overlay.
///
/// Isolated into its own widget behind a [RepaintBoundary] so the orbiting
/// logos and typewriter animation above it never force the 2.3 MB backdrop to
/// re-rasterise.
class _HeroBackdrop extends StatelessWidget {
  const _HeroBackdrop();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.heroBackdrop),
                fit: BoxFit.cover,
                opacity: 0.35,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  for (var i = 0; i < AppColors.heroOverlay.length; i++)
                    AppColors.heroOverlay[i].withValues(
                      alpha: AppColors.heroOverlayOpacity[i],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  final DeviceType device;
  const _DesktopHero({required this.device});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(flex: 3, child: _HeroTextBlock()),
        const SizedBox(width: AppSizes.xxxl),
        Expanded(flex: 2, child: _HeroPortrait(device: device)),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  const _MobileHero();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _HeroPortrait(device: DeviceType.mobile, mobileCompact: true),
        SizedBox(height: 22),
        _HeroTextBlock(center: true),
      ],
    );
  }
}

class _HeroTextBlock extends StatelessWidget {
  final bool center;

  const _HeroTextBlock({this.center = false});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final align =
        center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = center ? TextAlign.center : TextAlign.start;
    final wrapAlign = center ? WrapAlignment.center : WrapAlignment.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        _AvailableForHireBanner(center: center),
        const SizedBox(height: AppSizes.lg),
        _AnimatedGreeting(isMobile: isMobile),
        const SizedBox(height: AppSizes.md - 2),
        GradientText(
          Tr.k(context, 'hero.role'),
          colors: const [AppColors.cyan, AppColors.purple],
          textAlign: textAlign,
          style: TextStyle(
            fontSize: isMobile ? 18 : 24,
            fontWeight: FontWeight.w700,
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 400.ms)
            .slideX(begin: center ? 0 : -0.15, end: 0),
        const SizedBox(height: AppSizes.headerGap),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSizes.heroCopyMaxWidth,
          ),
          child: Text(
            Tr.k(context, 'hero.tagline'),
            textAlign: textAlign,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: isMobile ? 14 : 16,
              height: 1.55,
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 700.ms, delay: 600.ms)
            .slideY(begin: 0.1, end: 0),
        const SizedBox(height: 22),
        _PlatformBadges(alignment: wrapAlign),
        const SizedBox(height: 22),
        _HeroStats(alignment: wrapAlign),
        const SizedBox(height: AppSizes.xxl),
        _HeroCtaButtons(alignment: wrapAlign),
      ],
    );
  }
}

/// The typewriter greeting.
///
/// Boxed at a fixed height because [AnimatedTextKit] reports its intrinsic
/// height mid-animation; letting it size itself makes the whole column jitter
/// on every character.
class _AnimatedGreeting extends StatelessWidget {
  final bool isMobile;
  const _AnimatedGreeting({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isMobile ? 36 : 48,
      child: RepaintBoundary(
        child: AnimatedTextKit(
          // Rebuilt from scratch on locale change — the animation caches its
          // glyph run, so without this the previous language stays on screen.
          key: ValueKey(isArabic(context)),
          animatedTexts: [
            TypewriterAnimatedText(
              Tr.k(context, 'hero.greeting'),
              textStyle: TextStyle(
                color: AppColors.gold,
                fontSize: isMobile ? 26 : 42,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                shadows: [
                  Shadow(
                    blurRadius: 16,
                    color: Colors.amberAccent.withValues(alpha: 0.7),
                  ),
                ],
              ),
              speed: const Duration(milliseconds: 90),
              cursor: '|',
            ),
          ],
          repeatForever: true,
          pause: const Duration(milliseconds: 1800),
        ),
      ),
    );
  }
}

class _PlatformBadges extends StatelessWidget {
  final WrapAlignment alignment;
  const _PlatformBadges({required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      spacing: AppSizes.sm,
      runSpacing: AppSizes.sm,
      children: List.generate(_platformBadgeKeys.length, (index) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.xs + 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Text(
            Tr.k(context, _platformBadgeKeys[index]),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        )
            .animate()
            .fadeIn(
              duration: 500.ms,
              delay: Duration(milliseconds: 800 + index * 100),
            )
            .slideY(begin: 0.4, end: 0, curve: Curves.easeOut);
      }),
    );
  }
}

class _HeroStats extends StatelessWidget {
  final WrapAlignment alignment;
  const _HeroStats({required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.md,
      runSpacing: AppSizes.md,
      alignment: alignment,
      children: [
        StatCounter(
          targetValue: liveProjectsCount,
          label: Tr.k(context, 'hero.stat.liveApps'),
          icon: Icons.rocket_launch,
          accent: AppColors.cyan,
        ),
        StatCounter(
          targetValue: odooProjectsCount,
          label: Tr.k(context, 'hero.stat.odoo'),
          icon: Icons.hub_outlined,
          accent: AppColors.teal,
        ),
        StatCounter(
          targetValue: 2,
          label: Tr.k(context, 'hero.stat.years'),
          icon: Icons.workspace_premium,
          accent: AppColors.gold,
        ),
      ],
    );
  }
}

class _HeroCtaButtons extends StatelessWidget {
  final WrapAlignment alignment;
  const _HeroCtaButtons({required this.alignment});

  @override
  Widget build(BuildContext context) {
    final ar = isArabic(context);

    return Wrap(
      alignment: alignment,
      spacing: AppSizes.md,
      runSpacing: AppSizes.md - 2,
      children: [
        AppButton(
          label: Tr.k(context, 'hero.ctaScheduleCall'),
          icon: Icons.event_available_outlined,
          onPressed: () =>
              openUrl(scheduleCallLink(arabic: ar), context: context),
        ),
        AppButton(
          label: Tr.k(context, 'hero.ctaResume'),
          icon: Icons.download_rounded,
          variant: AppButtonVariant.secondary,
          onPressed: () => CvPreviewModal.show(context),
        ),
        AppButton(
          label: Tr.k(context, 'hero.ctaTalk'),
          icon: Icons.chat_bubble_outline_rounded,
          variant: AppButtonVariant.accent,
          onPressed: () => openUrl(hireMeLink(arabic: ar), context: context),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 700.ms, delay: 900.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

class _HeroPortrait extends StatelessWidget {
  final DeviceType device;
  final bool mobileCompact;

  const _HeroPortrait({
    required this.device,
    this.mobileCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final baseSize = mobileCompact
            ? 140.0
            : (device == DeviceType.tablet ? 200.0 : 290.0);

        // The orbit ring extends 36px past its radius on every side. Derive
        // the portrait from whatever width the slot actually offers so the
        // rings never paint outside the hero — on a 320px phone the nominal
        // 140px portrait would need 526px of canvas.
        final available = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : context.screenWidth;
        final maxPortrait = ((available / 2) - 36) / 0.75;
        final size =
            baseSize.clamp(96.0, math.max(96.0, maxPortrait)).toDouble();

        // A square's corners reach further than a circle's edge, so the photo
        // is inset to keep the corners and spinning halo inside the inner orbit.
        final photoSize = size * 0.8;
        final photoRadius = photoSize * 0.14;
        final orbitRadius = size * 0.75;
        final overallSize = (orbitRadius + 36) * 2;

        return Center(
          child: SizedBox(
            width: overallSize,
            height: overallSize,
            child: RepaintBoundary(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  _OrbitRing(diameter: orbitRadius * 2, opacity: 0.06),
                  _OrbitRing(diameter: (orbitRadius - 22) * 2, opacity: 0.04),
                  _SweepHalo(size: photoSize + 24, radius: photoRadius + 12),
                  Container(
                    width: photoSize + 16,
                    height: photoSize + 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(photoRadius + 8),
                      color: AppColors.surfaceDeep,
                    ),
                  ),
                  _OrbitingLogos(radius: orbitRadius, clockwise: true),
                  _OrbitingLogos(
                    radius: orbitRadius - 22,
                    clockwise: false,
                    icons: _innerOrbitIcons,
                  ),
                  _PortraitPhoto(size: photoSize, radius: photoRadius),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OrbitRing extends StatelessWidget {
  final double diameter;
  final double opacity;
  const _OrbitRing({required this.diameter, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: opacity),
        ),
      ),
    );
  }
}

class _SweepHalo extends StatelessWidget {
  final double size;
  final double radius;
  const _SweepHalo({required this.size, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: SweepGradient(
          colors: [
            AppColors.gold.withValues(alpha: 0.7),
            AppColors.cyan.withValues(alpha: 0.6),
            AppColors.purple.withValues(alpha: 0.6),
            AppColors.gold.withValues(alpha: 0.7),
          ],
        ),
      ),
    ).animate(onPlay: (c) => c.repeat()).rotate(duration: 12.seconds);
  }
}

class _PortraitPhoto extends StatelessWidget {
  final double size;
  final double radius;
  const _PortraitPhoto({required this.size, required this.radius});

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.devicePixelRatioOf(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: 0.35),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
        image: DecorationImage(
          // Decode at 2x the physical display width so the GPU downsamples a
          // sharp image instead of showing a pre-shrunk, soft one.
          image: ResizeImage(
            const AssetImage(AppAssets.portrait),
            width: math.min(2172, (size * ratio * 2).round()),
            policy: ResizeImagePolicy.fit,
          ),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms)
        .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1));
  }
}

class _OrbitIconSpec {
  final IconData icon;
  final Color color;
  const _OrbitIconSpec(this.icon, this.color);
}

const _outerOrbitIcons = <_OrbitIconSpec>[
  _OrbitIconSpec(FontAwesomeIcons.flutter, AppColors.flutterBlue),
  _OrbitIconSpec(FontAwesomeIcons.fire, AppColors.firebase),
  _OrbitIconSpec(FontAwesomeIcons.boxesStacked, AppColors.teal),
  _OrbitIconSpec(FontAwesomeIcons.database, AppColors.supabase),
  _OrbitIconSpec(FontAwesomeIcons.laravel, AppColors.laravel),
];

const _innerOrbitIcons = <_OrbitIconSpec>[
  _OrbitIconSpec(FontAwesomeIcons.code, AppColors.dartBlue),
  _OrbitIconSpec(FontAwesomeIcons.cubes, AppColors.flutterDeep),
  _OrbitIconSpec(FontAwesomeIcons.bolt, AppColors.gold),
];

class _OrbitingLogos extends StatefulWidget {
  final double radius;
  final bool clockwise;
  final List<_OrbitIconSpec> icons;

  const _OrbitingLogos({
    required this.radius,
    this.clockwise = true,
    this.icons = _outerOrbitIcons,
  });

  @override
  State<_OrbitingLogos> createState() => _OrbitingLogosState();
}

class _OrbitingLogosState extends State<_OrbitingLogos>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.clockwise ? 28 : 36),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The chips are built once and positioned by the animation, rather than
    // rebuilt every frame — 60 fps of Container construction for a rotation is
    // pure waste.
    final chips = [
      for (final spec in widget.icons) _OrbitingChip(spec: spec),
    ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t =
            _controller.value * 2 * math.pi * (widget.clockwise ? 1 : -1);
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: List.generate(chips.length, (i) {
            final angle = t + (i * 2 * math.pi / chips.length);
            return Transform.translate(
              offset: Offset(
                math.cos(angle) * widget.radius,
                math.sin(angle) * widget.radius,
              ),
              child: chips[i],
            );
          }),
        );
      },
    );
  }
}

class _OrbitingChip extends StatelessWidget {
  final _OrbitIconSpec spec;
  const _OrbitingChip({required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.10),
            Colors.white.withValues(alpha: 0.03),
          ],
        ),
        border: Border.all(color: spec.color.withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(
            color: spec.color.withValues(alpha: 0.30),
            blurRadius: 12,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: FaIcon(spec.icon, size: 15, color: spec.color),
    );
  }
}

/// "Available for hire" banner. Click-through opens WhatsApp pre-filled with a
/// scheduling request, so the signal converts rather than just decorating.
///
/// The detail line is the widest fixed-width text in the hero. On a narrow
/// phone the row it used to live in overflowed by roughly 60px; it now wraps
/// to a second line and the whole banner is width-capped to its parent.
class _AvailableForHireBanner extends StatelessWidget {
  final bool center;
  const _AvailableForHireBanner({required this.center});

  @override
  Widget build(BuildContext context) {
    final ar = isArabic(context);
    final isCompact = context.isCompact;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => openUrl(scheduleCallLink(arabic: ar), context: context),
        borderRadius: BorderRadius.circular(26),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.lg,
            vertical: 11,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.success.withValues(alpha: 0.22),
                AppColors.successDeep.withValues(alpha: 0.10),
              ],
            ),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.55),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.success.withValues(alpha: 0.30),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            // Hugs its content when there is room; the Flexible below lets it
            // shrink instead of overflowing when there is not.
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _PulsingDot(),
              const SizedBox(width: AppSizes.md),
              Flexible(
                child: Column(
                  crossAxisAlignment: center
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Tr.k(context, 'hero.openToWork'),
                      textAlign: center ? TextAlign.center : TextAlign.start,
                      style: const TextStyle(
                        color: AppColors.success,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: AppSizes.xxs),
                    Text(
                      Tr.k(context, 'hero.openToWorkDetail'),
                      textAlign: center ? TextAlign.center : TextAlign.start,
                      // Two lines on a narrow phone beats one clipped line.
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              // The trailing chevron is decorative; on the narrowest phones
              // its 26px buys a readable line of copy instead.
              if (!isCompact) ...[
                const SizedBox(width: AppSizes.md - 2),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: AppColors.success,
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0);
  }
}

class _PulsingDot extends StatelessWidget {
  const _PulsingDot();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.30),
              shape: BoxShape.circle,
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .scaleXY(
                begin: 0.6,
                end: 1.5,
                duration: 1500.ms,
                curve: Curves.easeOut,
              )
              .fade(begin: 0.7, end: 0.0, duration: 1500.ms),
          Container(
            width: 11,
            height: 11,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.success, blurRadius: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
