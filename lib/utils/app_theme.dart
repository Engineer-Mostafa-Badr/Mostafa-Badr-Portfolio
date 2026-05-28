import 'package:flutter/material.dart';

class AppThemeController {
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.dark);

  static void toggle() {
    mode.value =
        mode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

bool isLightMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light;

class AppPalette {
  final bool isLight;
  const AppPalette(this.isLight);

  factory AppPalette.of(BuildContext context) =>
      AppPalette(isLightMode(context));

  // Surfaces — in light mode we keep cards dark-translucent so existing
  // white/grey text inside sections remains readable without a full rewrite.
  Color get cardSurface => isLight
      ? const Color(0xFF0F172A).withValues(alpha: 0.82)
      : Colors.black.withValues(alpha: 0.30);
  Color get cardBorder => isLight
      ? Colors.black.withValues(alpha: 0.18)
      : Colors.white.withValues(alpha: 0.08);
  Color get cardBorderStrong => isLight
      ? Colors.black.withValues(alpha: 0.28)
      : Colors.white.withValues(alpha: 0.18);

  // Glass gradients overlay on top of cardSurface
  List<Color> get cardGradient => isLight
      ? [
          Colors.white.withValues(alpha: 0.08),
          Colors.white.withValues(alpha: 0.02),
        ]
      : [
          Colors.white.withValues(alpha: 0.06),
          Colors.white.withValues(alpha: 0.02),
        ];

  // Shadows — heavier in light mode for stronger contrast against the bg
  Color get shadow => isLight
      ? Colors.black.withValues(alpha: 0.22)
      : Colors.black.withValues(alpha: 0.35);

  // Text
  Color get textPrimary => isLight ? const Color(0xFF0F172A) : Colors.white;
  Color get textSecondary =>
      isLight ? const Color(0xFF475569) : Colors.grey.shade300;
  Color get textMuted =>
      isLight ? const Color(0xFF64748B) : Colors.grey.shade400;
  Color get textFaint =>
      isLight ? const Color(0xFF94A3B8) : Colors.grey.shade500;

  // Chips / inline pills
  Color get pillBackground => isLight
      ? Colors.black.withValues(alpha: 0.04)
      : Colors.white.withValues(alpha: 0.05);
  Color get pillBorder => isLight
      ? Colors.black.withValues(alpha: 0.10)
      : Colors.white.withValues(alpha: 0.10);

  // Brand accents — canonical palette, identical in both themes.
  // Use these from app-chrome widgets (top bar, badges, hero, section headers).
  // Per-project brand colors (inside project_cover, projects_data, skill icons)
  // intentionally use their own hex codes — they are the project's identity,
  // not the portfolio's chrome.
  static const Color accentCyan = Color(0xFF40C4FF);
  static const Color accentGold = Color(0xFFFFD700);
  static const Color accentPurple = Color(0xFF9C7BFF);
  static const Color accentMint = Color(0xFF69F0AE);
  static const Color accentTeal = Color(0xFF22D3EE);
  static const Color accentAmber = Color(0xFFFBBF24);
  static const Color accentCoral = Color(0xFFFF8A65);
  static const Color statusOnline = Color(0xFF34D399);
}
