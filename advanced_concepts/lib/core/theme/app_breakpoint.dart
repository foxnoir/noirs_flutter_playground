/// Material 3 layout breakpoints.
///
/// Not AdaptiveScaffold — just these cuts. Compact is the default
/// (mobile first, every layout). Measure width with LayoutBuilder
/// (parent) or MediaQuery.sizeOf (window). Do not branch on `kIsWeb`
/// or device type.
///
/// Ranges: compact below 600, medium 600–839, expanded 840–1199,
/// large 1200–1599, extra-large 1600 and up.
///
/// See https://m3.material.io/foundations/layout/breakpoints/overview
enum AppBreakpoint {
  compact,
  medium,
  expanded,
  large,
  extraLarge;

  /// Start of medium (end of compact).
  static const double mediumMin = 600;

  /// Start of expanded (end of medium).
  static const double expandedMin = 840;

  /// Start of large (end of expanded).
  static const double largeMin = 1200;

  /// Start of extra-large (end of large).
  static const double extraLargeMin = 1600;

  /// Lab copy cap. Not a breakpoint — expanded starts at [expandedMin];
  /// we stop stretching body copy there.
  static const double contentMax = expandedMin;

  /// Widths where [fromWidth] changes. Nothing listens;
  /// a widget must compare a measured width to these cuts.
  static const List<double> jumps = [
    mediumMin,
    expandedMin,
    largeMin,
    extraLargeMin,
  ];

  static AppBreakpoint fromWidth(double width) {
    if (width >= extraLargeMin) {
      return extraLarge;
    }
    if (width >= largeMin) {
      return large;
    }
    if (width >= expandedMin) {
      return expanded;
    }
    if (width >= mediumMin) {
      return medium;
    }
    return compact;
  }

  bool get isCompact => this == compact;
}
