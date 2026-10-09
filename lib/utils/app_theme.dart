import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';

class AppThemeController {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.dark);

  static void toggle() {
    mode.value =
        mode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

bool isLightMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light;

/// Theme-dependent surface, border, and text colours.
///
/// Raw colour values live in [AppColors]; this class decides which of them
/// applies for the active brightness. Widgets ask the palette, never the hex.
class AppPalette {
  final bool isLight;
  const AppPalette(this.isLight);

  factory AppPalette.of(BuildContext context) =>
      AppPalette(isLightMode(context));

  // Surfaces — in light mode cards stay dark-translucent so the white/grey
  // text inside sections remains readable without a full colour rewrite.
  Color get cardSurface => isLight
      ? AppColors.slate900.withValues(alpha: 0.82)
      : Colors.black.withValues(alpha: 0.30);
  Color get cardBorder => isLight
      ? Colors.black.withValues(alpha: 0.18)
      : Colors.white.withValues(alpha: 0.08);
  Color get cardBorderStrong => isLight
      ? Colors.black.withValues(alpha: 0.28)
      : Colors.white.withValues(alpha: 0.18);

  // Glass gradients overlay on top of cardSurface.
  List<Color> get cardGradient => isLight
      ? [
          Colors.white.withValues(alpha: 0.08),
          Colors.white.withValues(alpha: 0.02),
        ]
      : [
          Colors.white.withValues(alpha: 0.06),
          Colors.white.withValues(alpha: 0.02),
        ];

  // Shadows — heavier in light mode for stronger contrast against the bg.
  Color get shadow => isLight
      ? Colors.black.withValues(alpha: 0.22)
      : Colors.black.withValues(alpha: 0.35);

  // Text
  Color get textPrimary =>
      isLight ? AppColors.textOnLightPrimary : Colors.white;
  Color get textSecondary =>
      isLight ? AppColors.textOnLightSecondary : Colors.grey.shade300;
  Color get textMuted =>
      isLight ? AppColors.textOnLightMuted : Colors.grey.shade400;
  Color get textFaint =>
      isLight ? AppColors.textOnLightFaint : Colors.grey.shade500;

  // Chips / inline pills
  Color get pillBackground => isLight
      ? Colors.black.withValues(alpha: 0.04)
      : Colors.white.withValues(alpha: 0.05);
  Color get pillBorder => isLight
      ? Colors.black.withValues(alpha: 0.10)
      : Colors.white.withValues(alpha: 0.10);

  /// Section-title gradient, dark on light backgrounds and light on dark.
  List<Color> get titleGradient => isLight
      ? const [AppColors.textOnLightPrimary, AppColors.titleGradientLightEnd]
      : AppColors.titleSheen;

  /// Page backdrop gradient.
  List<Color> get backdrop =>
      isLight ? AppColors.backdropLight : AppColors.backdropDark;

  // Brand accents are theme-independent; re-exported here so widgets need only
  // one import for colour decisions.
  static const Color accentCyan = AppColors.cyan;
  static const Color accentGold = AppColors.gold;
  static const Color accentPurple = AppColors.purple;
  static const Color accentMint = AppColors.mint;
  static const Color accentTeal = AppColors.teal;
  static const Color accentAmber = AppColors.amber;
  static const Color accentCoral = AppColors.coral;
  static const Color statusOnline = AppColors.success;
}
