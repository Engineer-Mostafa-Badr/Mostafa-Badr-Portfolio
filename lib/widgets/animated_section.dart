import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedSection extends StatelessWidget {
  final Widget child;
  const AnimatedSection({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: 600.ms),
        SlideEffect(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
          curve: Curves.easeOut,
        ),
      ],
      child: child,
    );
  }
}
