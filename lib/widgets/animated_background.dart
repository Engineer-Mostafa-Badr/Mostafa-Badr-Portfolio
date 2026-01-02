import 'package:mostafa_badr_portfolio/utils/device_type.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceTypeFromWidth(width);
    final circle1Size = device == DeviceType.desktop
        ? 300.0
        : device == DeviceType.tablet
        ? 220.0
        : 160.0;
    final circle2Size = device == DeviceType.desktop
        ? 340.0
        : device == DeviceType.tablet
        ? 260.0
        : 180.0;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final beginOffset = Offset(-0.8 + 0.6 * t, -1);
        final endOffset = Offset(1, 0.8 - 0.6 * t);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(beginOffset.dx, beginOffset.dy),
              end: Alignment(endOffset.dx, endOffset.dy),
              colors: const [
                Color(0xFF071029),
                Color(0xFF0F1724),
                Color(0xFF081026),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 40 + 80 * t,
                top: 20 + 20 * (1 - t),
                child: Container(
                  width: circle1Size,
                  height: circle1Size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        // ignore: deprecated_member_use
                        Colors.blue.withOpacity(0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 20 + 60 * (1 - t),
                bottom: 20 + 90 * t,
                child: Container(
                  width: circle2Size,
                  height: circle2Size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        // ignore: deprecated_member_use
                        Colors.purple.withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
