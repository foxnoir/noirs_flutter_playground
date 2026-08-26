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
    expect(theme.colorScheme.tertiary, AppColor.tertiary);
    expect(theme.colorScheme.tertiary, const Color(0xFFC7EFFB));
    expect(theme.snackBarTheme.backgroundColor, AppColor.tertiary);
    expect(theme.colorScheme.tertiaryContainer, AppColor.teal);
    expect(theme.colorScheme.onTertiaryContainer, AppColor.tertiary);
    expect(theme.colorScheme.error, AppColor.error);
    expect(theme.colorScheme.onError, AppColor.onError);
    expect(theme.colorScheme.errorContainer, AppColor.errorContainer);
    expect(theme.colorScheme.onErrorContainer, AppColor.onErrorContainer);
    expect(AppColor.teal, const Color(0xFF0E6971));
    expect(AppColor.error, const Color(0xFFC18388));
    expect(AppColor.errorContainer, const Color(0xFFE3C7C9));
  });
}
