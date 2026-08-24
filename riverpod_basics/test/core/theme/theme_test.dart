import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';

void main() {
  test('getLightTheme uses the playground seed colors', () {
    final theme = getLightTheme();

    expect(theme.colorScheme.primary, const Color(0xFFB385DC));
    expect(theme.appBarTheme.elevation, 0);
    expect(
      theme.appBarTheme.backgroundColor,
      theme.colorScheme.primaryContainer,
    );
  });
}
