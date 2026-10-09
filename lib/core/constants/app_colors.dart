import 'package:flutter/material.dart';

/// Every colour literal used by the portfolio chrome lives here.
///
/// Widgets must not spell out `Color(0xFF...)` inline — pull the named constant
/// instead so a palette change is a single edit and the same blue is genuinely
/// the same blue everywhere.
///
/// Per-project brand colours (a client's own identity) live in
/// [ProjectPalette] so they are clearly separated from the portfolio's own
/// chrome and can drift independently.
class AppColors {
  const AppColors._();

  // ── Brand accents ──────────────────────────────────────────────────────
  static const Color gold = Color(0xFFFFD700);
  static const Color goldDeep = Color(0xFFFFB800);
  static const Color cyan = Color(0xFF40C4FF);
  static const Color purple = Color(0xFF9C7BFF);
  static const Color teal = Color(0xFF22D3EE);
  static const Color mint = Color(0xFF69F0AE);
  static const Color amber = Color(0xFFFBBF24);
  static const Color coral = Color(0xFFFF8A65);
  static const Color skyTint = Color(0xFFB3E5FC);

  // ── Status ─────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF34D399);
  static const Color successDeep = Color(0xFF10B981);
  static const Color danger = Color(0xFFF87171);
  static const Color warning = amber;

  // ── Dark surfaces ──────────────────────────────────────────────────────
  static const Color surfaceDark = Color(0xFF0E152B);
  static const Color surfaceDarkAlt = Color(0xFF1A1130);
  static const Color surfaceDeep = Color(0xFF0B1430);
  static const Color slate900 = Color(0xFF0F172A);

  // ── Page background gradients ──────────────────────────────────────────
  static const List<Color> backdropDark = [
    Color(0xFF050A1A),
    Color(0xFF0A1230),
    Color(0xFF0E0B26),
  ];
  static const List<Color> backdropLight = [
    Color(0xFFF8FAFC),
    Color(0xFFE2E8F0),
    Color(0xFFEDE9FE),
  ];

  // ── Text (light theme) ─────────────────────────────────────────────────
  static const Color textOnLightPrimary = slate900;
  static const Color textOnLightSecondary = Color(0xFF475569);
  static const Color textOnLightMuted = Color(0xFF64748B);
  static const Color textOnLightFaint = Color(0xFF94A3B8);
  static const Color titleGradientLightEnd = Color(0xFF1E40AF);

  // ── Hero overlay ───────────────────────────────────────────────────────
  static const List<Color> heroOverlay = [
    Color(0xFF071029),
    Color(0xFF0F1D3A),
    Color(0xFF1B0F2E),
  ];
  static const List<double> heroOverlayOpacity = [0.92, 0.85, 0.88];

  // ── Pre-footer CTA banner ──────────────────────────────────────────────
  static const List<Color> ctaBanner = [
    slate900,
    Color(0xFF1E3A8A),
    Color(0xFF06B6D4),
  ];

  // ── Reusable gradients ─────────────────────────────────────────────────
  static const List<Color> brandSweep = [gold, cyan];
  static const List<Color> brandSweepWide = [gold, cyan, purple];
  static const List<Color> titleSheen = [Colors.white, skyTint];
  static const List<Color> cardSheen = [Color(0xFF1B2A4E), Color(0xFF2C1B4E)];
  static const List<Color> modalSurface = [surfaceDark, surfaceDarkAlt];

  // ── Social brand colours ───────────────────────────────────────────────
  static const Color linkedIn = Color(0xFF0A66C2);
  static const Color facebook = Color(0xFF1877F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color youTube = Color(0xFFFF0000);
  static const Color emailAmber = Color(0xFFFFA000);
  static const Color flutterBlue = Color(0xFF42A5F5);
  static const Color cloudflare = Color(0xFFF6821F);

  // ── Tooling brand colours (tools section) ──────────────────────────────
  static const Color vsCode = Color(0xFF007ACC);
  static const Color androidGreen = Color(0xFF3DDC84);
  static const Color figma = Color(0xFFF24E1E);
  static const Color git = Color(0xFFF05032);
  static const Color postman = Color(0xFFFF6C37);
  static const Color sentry = Color(0xFF8C5898);
  static const Color playStore = Color(0xFF34A853);
  static const Color slack = Color(0xFF4A154B);
  static const Color swagger = Color(0xFF85EA2D);

  // ── Stack / skill icon colours ─────────────────────────────────────────
  static const Color dartBlue = Color(0xFF0175C2);
  static const Color flutterDeep = Color(0xFF02569B);
  static const Color firebase = emailAmber;
  static const Color supabase = Color(0xFF3ECF8E);
  static const Color odoo = Color(0xFF714B67);
  static const Color laravel = Color(0xFFFF2D20);
  static const Color node = Color(0xFF68A063);

  // ── Confetti (easter egg) ──────────────────────────────────────────────
  static const List<Color> confetti = [gold, cyan, purple, success, coral];
}

/// Cover-art palettes owned by the individual client projects. Kept apart from
/// [AppColors] because these belong to the client's brand, not the portfolio.
class ProjectPalette {
  const ProjectPalette._();

  static const List<Color> hajj = [
    Color(0xFF0F172A),
    Color(0xFF1E3A5F),
    Color(0xFF1E40AF),
  ];
  static const Color hajjAccent = Color(0xFFFBBF24);

  static const List<Color> alawaly = [
    Color(0xFF064E3B),
    Color(0xFF0F766E),
    Color(0xFF10B981),
  ];
  static const Color alawalyAccent = Color(0xFF34D399);

  static const List<Color> fortyNine = [
    Color(0xFF7F1D1D),
    Color(0xFFB91C1C),
    Color(0xFFEF4444),
  ];
  static const Color fortyNineAccent = Color(0xFFFCA5A5);

  static const List<Color> saqqar = [
    Color(0xFF1F3C88),
    Color(0xFF06B6D4),
    Color(0xFF8B5CF6),
  ];
  static const Color saqqarAccent = Color(0xFF22D3EE);

  static const List<Color> visits = [
    Color(0xFF1E2A6E),
    Color(0xFF1E40AF),
    Color(0xFF3FBFD9),
  ];
  static const Color visitsAccent = Color(0xFF3FBFD9);

  static const List<Color> hr = [
    Color(0xFF0F172A),
    Color(0xFF1E3A8A),
    Color(0xFF22D3EE),
  ];
  static const Color hrAccent = Color(0xFF60A5FA);

  static const List<Color> ecommerce = [
    Color(0xFF4C1D95),
    Color(0xFF6D28D9),
    Color(0xFFA855F7),
  ];
  static const Color ecommerceAccent = Color(0xFFC4B5FD);

  static const List<Color> captainDrive = [
    Color(0xFF1E3A8A),
    Color(0xFF2563EB),
    Color(0xFF3B82F6),
  ];
  static const Color captainDriveAccent = Color(0xFF93C5FD);
}

/// Status-pill colours for the project cards.
class ProjectStatusColors {
  const ProjectStatusColors._();

  static const Color live = Colors.green;
  static const Color inReview = AppColors.amber;
  static const Color demo = Colors.purple;
  static const Color completed = Colors.blueGrey;
}
