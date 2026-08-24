import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/core/theme/theme.dart';

void main() {
  test('getLightTheme uses AppColor and titleLarge teal', () {
    final theme = getLightTheme();

    expect(theme.colorScheme.primary, AppColor.primary);
    expect(theme.appBarTheme.elevation, 0);
    expect(
      theme.appBarTheme.backgroundColor,
      theme.colorScheme.primaryContainer,
    );
    expect(theme.textTheme.titleLarge?.color, AppColor.teal);
    expect(theme.textTheme.titleLarge?.fontSize, 22);
    expect(AppColor.teal, const Color(0xFF0E6971));
  });
}
