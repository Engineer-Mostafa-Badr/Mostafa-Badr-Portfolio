import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';

/// Visual weight of an [AppButton].
enum AppButtonVariant {
  /// Gold, filled. One per view — the action you actually want taken.
  primary,

  /// Outlined, neutral. Supporting actions.
  secondary,

  /// Outlined, cyan. Supporting action that still wants a little pull.
  accent,
}

/// Physical size of an [AppButton].
enum AppButtonSize { small, medium, large }

/// The portfolio's single button.
///
/// Before this existed the same twenty-line `ElevatedButton.styleFrom(...)`
/// block was pasted into eight files, each drifting a little in padding and
/// radius. One widget, three variants, three sizes — and the buttons are
/// finally identical because they are literally the same code.
///
/// Labels are always [Flexible] with ellipsis: a long Arabic label on a narrow
/// phone shrinks instead of overflowing its row.
class AppButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;

  /// Stretches to the parent's width. Used on mobile where a full-bleed
  /// button reads as the obvious next step.
  final bool expand;

  /// Swaps the icon for a spinner and blocks input.
  final bool busy;

  const AppButton({
    required this.label,
    this.icon,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.expand = false,
    this.busy = false,
    super.key,
  });

  EdgeInsets get _padding {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 10);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 18, vertical: 14);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 28, vertical: 16);
    }
  }

  double get _fontSize {
    switch (size) {
      case AppButtonSize.small:
        return 12;
      case AppButtonSize.medium:
        return 13;
      case AppButtonSize.large:
        return 15;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppButtonSize.small:
        return 14;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 18;
    }
  }

  Color get _foreground {
    switch (variant) {
      case AppButtonVariant.primary:
        return Colors.black;
      case AppButtonVariant.secondary:
        return Colors.white;
      case AppButtonVariant.accent:
        return AppColors.cyan;
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = _ButtonContent(
      label: label,
      icon: icon,
      busy: busy,
      iconSize: _iconSize,
      fontSize: _fontSize,
      spinnerColor: _foreground,
    );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
    );
    final effectiveOnPressed = busy ? null : onPressed;

    final Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: effectiveOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gold,
            foregroundColor: Colors.black,
            disabledBackgroundColor: AppColors.gold.withValues(alpha: 0.4),
            disabledForegroundColor: Colors.black.withValues(alpha: 0.6),
            padding: _padding,
            shape: shape,
            elevation: 0,
          ),
          child: child,
        );
      case AppButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
            padding: _padding,
            shape: shape,
          ),
          child: child,
        );
      case AppButtonVariant.accent:
        button = OutlinedButton(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.cyan,
            side: BorderSide(color: AppColors.cyan.withValues(alpha: 0.6)),
            padding: _padding,
            shape: shape,
          ),
          child: child,
        );
    }

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class _ButtonContent extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool busy;
  final double iconSize;
  final double fontSize;
  final Color spinnerColor;

  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.busy,
    required this.iconSize,
    required this.fontSize,
    required this.spinnerColor,
  });

  @override
  Widget build(BuildContext context) {
    final leading = busy
        ? SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: spinnerColor,
            ),
          )
        : (icon == null ? null : Icon(icon, size: iconSize));

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          leading,
          const SizedBox(width: AppSizes.sm),
        ],
        // Flexible, not Expanded: the row still hugs its content when there is
        // room, but a long label degrades to an ellipsis instead of overflowing.
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
