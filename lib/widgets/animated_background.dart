import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:mostafa_badr_portfolio/utils/scroll_notifier.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late final AnimationController _slowController;
  late final AnimationController _mediumController;

  @override
  void initState() {
    super.initState();
    _slowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
    _mediumController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _slowController.dispose();
    _mediumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final isLight = isLightMode(context);
    final orbScale = device == DeviceType.desktop
        ? 1.0
        : device == DeviceType.tablet
            ? 0.75
            : 0.55;

    final baseGradient = isLight
        ? const [
            Color(0xFFF8FAFC),
            Color(0xFFE2E8F0),
            Color(0xFFEDE9FE),
          ]
        : const [
            Color(0xFF050A1A),
            Color(0xFF0A1230),
            Color(0xFF0E0B26),
          ];
    final orbOpacity = isLight ? 0.18 : 0.10;
    final vignetteColor = isLight
        ? Colors.white.withValues(alpha: 0.20)
        : Colors.black.withValues(alpha: 0.35);

    return AnimatedBuilder(
      animation: Listenable.merge([_slowController, _mediumController]),
      builder: (context, _) {
        final slow = _slowController.value;
        final medium = _mediumController.value;

        return ValueListenableBuilder<double>(
          valueListenable: AppScroll.offset,
          builder: (context, scroll, _) {
            // Parallax: orbs drift up slower than scroll. Each orb moves at
            // a slightly different rate so they decouple visually.
            final p1 = -scroll * 0.12;
            final p2 = -scroll * 0.08;
            final p3 = -scroll * 0.18;

            return Stack(
              children: [
                // Base gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: baseGradient,
                    ),
                  ),
                ),
                // Orb 1 — gold (top)
                _Orb(
                  left: 40 + 120 * slow,
                  top: 60 + 40 * (1 - medium) + p1,
                  size: 320 * orbScale,
                  color: const Color(0xFFFFD700),
                  opacity: orbOpacity,
                ),
                // Orb 2 — blue (mid-right)
                _Orb(
                  right: 30 + 90 * (1 - slow),
                  top: 250 + 100 * medium + p2,
                  size: 360 * orbScale,
                  color: const Color(0xFF40C4FF),
                  opacity: orbOpacity,
                ),
                // Orb 3 — purple (bottom-left)
                _Orb(
                  left: 100 + 60 * medium,
                  bottom: 80 + 80 * (1 - slow) - p3,
                  size: 300 * orbScale,
                  color: const Color(0xFF9C7BFF),
                  opacity: orbOpacity - 0.01,
                ),
                // Vignette
                Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.3,
                      colors: [
                        Colors.transparent,
                        vignetteColor,
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _Orb extends StatelessWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double size;
  final Color color;
  final double opacity;

  const _Orb({
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.size,
    required this.color,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: opacity),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
