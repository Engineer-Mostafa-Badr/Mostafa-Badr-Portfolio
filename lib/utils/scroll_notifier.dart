import 'package:flutter/foundation.dart';

/// Global scroll offset (current pixels) the [PortfolioHome] keeps in sync
/// with its [ScrollController]. Other widgets — like [AnimatedBackground] —
/// can subscribe to it for parallax effects without prop-drilling.
class AppScroll {
  static final ValueNotifier<double> offset = ValueNotifier(0.0);
}
