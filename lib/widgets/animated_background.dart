import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/utils/app_theme.dart';
import 'package:mostafa_badr_portfolio/utils/scroll_notifier.dart';

/// Drifting gradient orbs behind the whole page.
///
/// Rewritten as a single [CustomPainter] driven by a merged [Listenable].
/// The previous version rebuilt a `Stack` of four `Container`s inside an
/// `AnimatedBuilder` nested in a `ValueListenableBuilder` — that is a full
/// widget-tree rebuild plus layout on every animation frame *and* every scroll
/// pixel, for something that is purely decorative. Painting it directly skips
/// build and layout entirely: same visuals, a fraction of the cost, and the
/// [RepaintBoundary] keeps the repaint off the rest of the page.
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late final AnimationController _slow = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 18),
  )..repeat();

  late final AnimationController _medium = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..repeat(reverse: true);

  late final Listenable _repaint =
      Listenable.merge([_slow, _medium, AppScroll.offset]);

  @override
  void dispose() {
    _slow.dispose();
    _medium.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = isLightMode(context);
    final orbScale = context.responsive(
      mobile: 0.55,
      tablet: 0.75,
      desktop: 1.0,
    );

    return RepaintBoundary(
      child: CustomPaint(
        painter: _BackdropPainter(
          repaint: _repaint,
          slow: _slow,
          medium: _medium,
          scroll: AppScroll.offset,
          orbScale: orbScale,
          isLight: isLight,
        ),
        // Expands to fill the Stack it sits in without needing a child.
        size: Size.infinite,
      ),
    );
  }
}

class _BackdropPainter extends CustomPainter {
  final Animation<double> slow;
  final Animation<double> medium;
  final ValueListenable<double> scroll;
  final double orbScale;
  final bool isLight;

  _BackdropPainter({
    required Listenable repaint,
    required this.slow,
    required this.medium,
    required this.scroll,
    required this.orbScale,
    required this.isLight,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final s = slow.value;
    final m = medium.value;
    final offset = scroll.value;

    _paintBaseGradient(canvas, rect);

    final orbOpacity = isLight ? 0.18 : 0.10;

    // Each orb drifts at its own fraction of the scroll offset so they
    // decouple visually instead of moving as one sheet.
    _paintOrb(
      canvas,
      center: Offset(40 + 120 * s, 60 + 40 * (1 - m) - offset * 0.12),
      diameter: 320 * orbScale,
      color: AppColors.gold,
      opacity: orbOpacity,
    );
    _paintOrb(
      canvas,
      center: Offset(
        size.width - (30 + 90 * (1 - s)),
        250 + 100 * m - offset * 0.08,
      ),
      diameter: 360 * orbScale,
      color: AppColors.cyan,
      opacity: orbOpacity,
    );
    _paintOrb(
      canvas,
      center: Offset(
        100 + 60 * m,
        size.height - (80 + 80 * (1 - s)) + offset * 0.18,
      ),
      diameter: 300 * orbScale,
      color: AppColors.purple,
      opacity: orbOpacity - 0.01,
    );

    _paintVignette(canvas, rect);
  }

  void _paintBaseGradient(Canvas canvas, Rect rect) {
    final colors = isLight ? AppColors.backdropLight : AppColors.backdropDark;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.transparent, Colors.transparent],
        ).createShader(rect)
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ).createShader(rect),
    );
  }

  void _paintOrb(
    Canvas canvas, {
    required Offset center,
    required double diameter,
    required Color color,
    required double opacity,
  }) {
    final radius = diameter / 2;
    // Top-left anchored like the original Positioned boxes, so the drift
    // geometry matches the previous design exactly.
    final orbCenter = center + Offset(radius, radius);
    final bounds = Rect.fromCircle(center: orbCenter, radius: radius);

    canvas.drawCircle(
      orbCenter,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [color.withValues(alpha: opacity), Colors.transparent],
        ).createShader(bounds),
    );
  }

  void _paintVignette(Canvas canvas, Rect rect) {
    final color = isLight
        ? Colors.white.withValues(alpha: 0.20)
        : Colors.black.withValues(alpha: 0.35);

    canvas.drawRect(
      rect,
      Paint()
        ..shader = RadialGradient(
          radius: 1.3,
          colors: [Colors.transparent, color],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant _BackdropPainter old) =>
      old.orbScale != orbScale || old.isLight != isLight;
}
