import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';

/// A glowing-dot bulleted list.
///
/// The experience cards and the project lightbox each had their own copy of
/// this markup, differing only in font size. One widget now serves both.
class BulletList extends StatelessWidget {
  final List<String> items;
  final Color accent;
  final double fontSize;

  /// Staggers each row in as it appears. Off inside dialogs, where the content
  /// is already revealed by the dialog's own transition.
  final bool animate;

  const BulletList({
    required this.items,
    required this.accent,
    this.fontSize = 13.5,
    this.animate = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(items.length, (index) {
        final row = Padding(
          padding: EdgeInsets.only(
            bottom: index == items.length - 1 ? 0 : AppSizes.sm + 1,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // Nudged down to sit on the first line's baseline rather than
                // its ascender.
                margin: const EdgeInsets.only(top: 6),
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent,
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.5),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.md - 1),
              Expanded(
                child: Text(
                  items[index],
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: fontSize,
                    height: 1.55,
                  ),
                ),
              ),
            ],
          ),
        );

        if (!animate) return row;
        return row
            .animate()
            .fadeIn(
              duration: 400.ms,
              delay: Duration(milliseconds: 100 * index),
            )
            .slideX(begin: -0.05, end: 0);
      }),
    );
  }
}
