import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';

/// A coloured dot plus a label — "Live · iOS & Android", "CURRENT",
/// "In review". Was hand-rolled in four places with four slightly different
/// dot sizes; now one widget with a size preset.
class StatusPill extends StatelessWidget {
  final String label;
  final Color color;

  /// Softly pulses the dot. Reserved for genuinely live states so the motion
  /// still means something.
  final bool pulse;

  /// Solid dark backdrop instead of a tint — for pills sitting on top of
  /// photography, where a tint alone would not carry enough contrast.
  final bool onImage;

  final double fontSize;
  final double dotSize;

  const StatusPill({
    required this.label,
    required this.color,
    this.pulse = false,
    this.onImage = false,
    this.fontSize = 11,
    this.dotSize = 7,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (label.trim().isEmpty) return const SizedBox.shrink();

    final dot = Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 6),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: onImage ? 9 : 10,
        vertical: onImage ? 4 : 5,
      ),
      decoration: BoxDecoration(
        color: onImage
            ? Colors.black.withValues(alpha: 0.45)
            : color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(
          onImage ? AppSizes.radiusPill : AppSizes.radiusSm,
        ),
        border: Border.all(
          color: color.withValues(alpha: onImage ? 0.7 : 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          pulse
              ? dot
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .fade(begin: 0.4, end: 1, duration: 900.ms)
              : dot,
          const SizedBox(width: AppSizes.xs + 2),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
