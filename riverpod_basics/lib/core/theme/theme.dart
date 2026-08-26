import 'package:flutter/material.dart';
import 'package:riverpod_basics/core/theme/app_color.dart';

export 'package:riverpod_basics/core/theme/app_color.dart';

ThemeData getLightTheme() {
  return _buildTheme(_getColorScheme());
}

ThemeData _buildTheme(ColorScheme colorScheme) {
  const textTheme = TextTheme(
    /// Landing section titles (Providers, Labs) and lab headings.
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
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColor.tertiary,
      contentTextStyle: TextStyle(
        color: AppColor.teal,
        fontWeight: FontWeight.w600,
      ),
      behavior: SnackBarBehavior.floating,
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
  ).copyWith(
    tertiary: AppColor.tertiary,
    onTertiary: AppColor.teal,
    tertiaryContainer: AppColor.teal,
    onTertiaryContainer: AppColor.tertiary,
    error: AppColor.error,
    onError: AppColor.onError,
    errorContainer: AppColor.errorContainer,
    onErrorContainer: AppColor.onErrorContainer,
  );
}
