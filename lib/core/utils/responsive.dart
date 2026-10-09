import 'package:flutter/widgets.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';

enum DeviceType { mobile, tablet, desktop }

DeviceType deviceTypeFromWidth(double width) {
  if (width >= AppBreakpoints.desktop) return DeviceType.desktop;
  if (width >= AppBreakpoints.tablet) return DeviceType.tablet;
  return DeviceType.mobile;
}

/// Responsive helpers hung off [BuildContext].
///
/// Two rules this codebase follows:
///
/// 1. Read the *device class* (`context.isMobile`) for coarse decisions —
///    which layout to build, how many grid columns.
/// 2. Read the *available width* from a [LayoutBuilder] for anything that has
///    to fit inside a box. `MediaQuery.size.width` is the window, not the slot
///    a widget was given, so sizing a child from it is how overflow happens.
///
/// Only [maxWidth]/[maxHeight] here touch MediaQuery, and they exist to *cap*
/// a dimension, never to derive one.
extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  DeviceType get deviceType => deviceTypeFromWidth(screenWidth);

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;

  /// True on genuinely small phones, where optional labels have to go.
  bool get isCompact => screenWidth < AppBreakpoints.compact;

  /// Picks the value matching the current device class. [tablet] falls back to
  /// [mobile] when omitted, so the common "phone vs. everything else" case
  /// stays a two-argument call.
  T responsive<T>({required T mobile, T? tablet, required T desktop}) {
    switch (deviceType) {
      case DeviceType.desktop:
        return desktop;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.mobile:
        return mobile;
    }
  }

  /// Horizontal page gutter for the current device class.
  double get pageGutter => responsive(
        mobile: AppSizes.gutterMobile,
        tablet: AppSizes.gutterTablet,
        desktop: AppSizes.gutterDesktop,
      );

  /// A fraction of the viewport height, clamped so the result is usable on
  /// both a short laptop and a tall phone. Use this instead of a bare
  /// `screenHeight * factor`, which produces unusable extremes at the ends of
  /// the range.
  double heightFraction(double factor, {double min = 240, double max = 900}) =>
      (screenHeight * factor).clamp(min, max);
}

/// Rebuilds against the constraints of the *slot* a widget occupies rather
/// than the window. Reach for this whenever a child's size has to fit its
/// parent — a grid cell, a dialog pane, a card body.
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    DeviceType device,
  ) builder;

  const ResponsiveBuilder({required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Prefer the real slot width; fall back to the window only when the
        // parent hands down an unbounded width (e.g. inside a scroll view).
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        return builder(context, constraints, deviceTypeFromWidth(width));
      },
    );
  }
}
