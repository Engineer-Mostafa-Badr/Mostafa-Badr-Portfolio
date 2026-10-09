import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';

/// Density preset for a [TagChip].
enum TagChipSize {
  /// Inside project cards, where space is tight.
  tiny,

  /// Default — tech-stack lists, meta pills.
  small,

  /// Lightbox tech stack, about-page pills.
  medium,
}

/// A bordered, tinted label. The single most duplicated shape in this codebase:
/// tech chips, meta pills, platform badges, and about-page pills were four
/// near-identical containers in four files. They are one widget now.
class TagChip extends StatelessWidget {
  final String label;
  final Color accent;
  final IconData? icon;
  final TagChipSize size;

  /// Filled and brighter — used for the emphasised first meta pill.
  final bool emphasized;

  /// Neutral grey instead of tinted [accent]. For secondary metadata.
  final bool muted;

  const TagChip({
    required this.label,
    required this.accent,
    this.icon,
    this.size = TagChipSize.small,
    this.emphasized = false,
    this.muted = false,
    super.key,
  });

  EdgeInsets get _padding {
    switch (size) {
      case TagChipSize.tiny:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case TagChipSize.small:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 5);
      case TagChipSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    }
  }

  double get _fontSize {
    switch (size) {
      case TagChipSize.tiny:
        return 10;
      case TagChipSize.small:
        return 11.5;
      case TagChipSize.medium:
        return 12;
    }
  }

  double get _radius {
    switch (size) {
      case TagChipSize.tiny:
        return AppSizes.radiusXs;
      case TagChipSize.small:
        return AppSizes.radiusSm;
      case TagChipSize.medium:
        return AppSizes.radiusSm;
    }
  }

  @override
  Widget build(BuildContext context) {
    final background = muted
        ? Colors.white.withValues(alpha: 0.04)
        : accent.withValues(alpha: emphasized ? 0.12 : 0.10);
    final border = muted
        ? Colors.white.withValues(alpha: 0.08)
        : accent.withValues(alpha: emphasized ? 0.30 : 0.30);
    final foreground = muted ? Colors.grey.shade300 : accent;

    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: _fontSize + 0.5, color: foreground),
            const SizedBox(width: AppSizes.xs + 1),
          ],
          // Flexible + ellipsis so a long label inside a Wrap degrades
          // gracefully instead of pushing past the available width.
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontSize: _fontSize,
                fontWeight: emphasized ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
