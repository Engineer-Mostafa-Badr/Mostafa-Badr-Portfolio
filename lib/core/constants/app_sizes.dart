/// Layout scale — spacing, radii, breakpoints and animation timings.
///
/// Every magic number that affects layout belongs here. Sections read from
/// these instead of inventing their own `18`s and `220ms`s, so the rhythm of
/// the page stays consistent and a density change is one edit.
class AppSizes {
  const AppSizes._();

  // ── Spacing scale (4pt grid) ───────────────────────────────────────────
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Vertical gap between top-level page sections.
  static const double sectionGap = 56;

  /// Gap between a section header and its content.
  static const double headerGap = 18;

  // ── Corner radii ───────────────────────────────────────────────────────
  static const double radiusXs = 6;
  static const double radiusSm = 8;
  static const double radiusMd = 10;
  static const double radiusLg = 12;
  static const double radiusXl = 18;
  static const double radiusXxl = 24;

  /// Fully rounded pills / chips.
  static const double radiusPill = 20;

  // ── Page gutters per device ────────────────────────────────────────────
  static const double gutterMobile = 16;
  static const double gutterTablet = 60;
  static const double gutterDesktop = 220;

  // ── Reading-width caps ─────────────────────────────────────────────────
  static const double heroCopyMaxWidth = 620;
  static const double ctaCopyMaxWidth = 580;
  static const double dialogMaxWidthDesktop = 1100;
  static const double dialogMaxWidthTablet = 760;
  static const double commandPaletteMaxWidth = 620;
  static const double cvModalMaxWidth = 900;

  // ── Common control metrics ─────────────────────────────────────────────
  static const double buttonHeight = 48;
  static const double iconButtonSize = 44;
  static const double minTapTarget = 44;
}

/// Width thresholds that drive the responsive layout.
///
/// Kept as named constants so a breakpoint tweak does not require hunting for
/// `700` and `1100` scattered across a dozen widgets.
class AppBreakpoints {
  const AppBreakpoints._();

  /// At or above this width the desktop layout applies.
  static const double desktop = 1100;

  /// At or above this width (and below [desktop]) the tablet layout applies.
  static const double tablet = 700;

  /// Below this width the UI drops optional labels and tightens gaps —
  /// small Androids and iPhone SE class devices.
  static const double compact = 420;

  /// The top bar can only fit the full inline nav above this width.
  static const double topBarFullNav = 1050;

  /// Below this the top bar tightens its own horizontal padding.
  static const double topBarTightPadding = 520;
}

/// Animation timings. Named so intent is visible at the call site and the
/// whole app can be slowed down or sped up coherently.
class AppDurations {
  const AppDurations._();

  static const Duration instant = Duration(milliseconds: 120);
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration quick = Duration(milliseconds: 220);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration reveal = Duration(milliseconds: 650);
  static const Duration scrollTo = Duration(milliseconds: 700);

  /// How long the contact form's success state stays before resetting.
  static const Duration formSuccessReset = Duration(seconds: 6);

  /// Network calls are aborted after this so the UI never hangs on a dead
  /// connection.
  static const Duration networkTimeout = Duration(seconds: 20);

  /// How long a feedback snackbar stays on screen.
  static const Duration snackBar = Duration(seconds: 5);
}
