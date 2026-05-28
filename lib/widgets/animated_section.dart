import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double slideOffset;

  const AnimatedSection({
    required this.child,
    this.delay = Duration.zero,
    this.slideOffset = 0.12,
    super.key,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection> {
  bool _shown = false;
  late final String _detectorKey =
      'animated-section-${identityHashCode(this)}';

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(_detectorKey),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.12 && !_shown && mounted) {
          setState(() => _shown = true);
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: !_shown
            ? Opacity(
                key: ValueKey('placeholder-$_detectorKey'),
                opacity: 0,
                child: widget.child,
              )
            : Animate(
                key: ValueKey('reveal-$_detectorKey'),
                effects: [
                  FadeEffect(duration: 650.ms, delay: widget.delay),
                  SlideEffect(
                    begin: Offset(0, widget.slideOffset),
                    end: Offset.zero,
                    duration: 700.ms,
                    delay: widget.delay,
                    curve: Curves.easeOutCubic,
                  ),
                ],
                child: widget.child,
              ),
      ),
    );
  }
}
