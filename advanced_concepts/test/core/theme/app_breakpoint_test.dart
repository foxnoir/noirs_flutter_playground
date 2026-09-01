import 'package:advanced_concepts/core/theme/app_breakpoint.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromWidth matches Material 3 breakpoint ranges', () {
    expect(AppBreakpoint.fromWidth(599), AppBreakpoint.compact);
    expect(AppBreakpoint.fromWidth(600), AppBreakpoint.medium);
    expect(AppBreakpoint.fromWidth(839), AppBreakpoint.medium);
    expect(AppBreakpoint.fromWidth(840), AppBreakpoint.expanded);
    expect(AppBreakpoint.fromWidth(1199), AppBreakpoint.expanded);
    expect(AppBreakpoint.fromWidth(1200), AppBreakpoint.large);
    expect(AppBreakpoint.fromWidth(1599), AppBreakpoint.large);
    expect(AppBreakpoint.fromWidth(1600), AppBreakpoint.extraLarge);
    expect(AppBreakpoint.contentMax, AppBreakpoint.expandedMin);
    expect(AppBreakpoint.jumps, [
      AppBreakpoint.mediumMin,
      AppBreakpoint.expandedMin,
      AppBreakpoint.largeMin,
      AppBreakpoint.extraLargeMin,
    ]);
  });
}
