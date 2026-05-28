import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StatCounter extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final String label;
  final IconData icon;
  final Color accent;
  final Duration duration;

  const StatCounter({
    required this.targetValue,
    required this.label,
    required this.icon,
    this.suffix = '+',
    this.accent = const Color(0xFFFFD700),
    this.duration = const Duration(milliseconds: 1400),
    super.key,
  });

  @override
  State<StatCounter> createState() => _StatCounterState();
}

class _StatCounterState extends State<StatCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  bool _started = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('stat-${widget.label}-${identityHashCode(this)}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.4 && !_started && mounted) {
          _started = true;
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final value = (_animation.value * widget.targetValue).floor();
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.05),
              border: Border.all(
                // ignore: deprecated_member_use
                color: widget.accent.withOpacity(0.30),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, color: widget.accent, size: 22),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$value${widget.suffix}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
