/// Material 3 width cuts. Compact is the default; two-column lab
/// layouts start at 600. Measure with LayoutBuilder, not `kIsWeb`.
abstract final class AppBreakpoint {
  static const double mediumMin = 600;

  /// Cap for page copy. Not a breakpoint.
  static const double contentMax = 960;
}
