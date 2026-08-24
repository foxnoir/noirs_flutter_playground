import 'package:flutter/material.dart';
import 'package:riverpod_basic_starter/core/theme/app_color.dart';

export 'package:riverpod_basic_starter/core/theme/app_color.dart';

ThemeData getLightTheme() {
  return _buildTheme(_getColorScheme());
}

ThemeData _buildTheme(ColorScheme colorScheme) {
  const textTheme = TextTheme(
    /// Section titles.
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColor.teal,
    ),
  );

  return ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      elevation: 0,
    ),
  );
}

ColorScheme _getColorScheme() {
  return ColorScheme.fromSeed(
    seedColor: AppColor.primary,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    primary: AppColor.primary,
    primaryContainer: AppColor.primaryContainer,
    secondary: AppColor.secondary,
    secondaryContainer: AppColor.secondaryContainer,
    tertiary: AppColor.tertiary,
  );
}
