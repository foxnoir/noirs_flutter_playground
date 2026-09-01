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

    /// Subsection titles.
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),

    /// Body copy.
    bodyMedium: TextStyle(fontSize: 14),

    /// Captions and hints.
    bodySmall: TextStyle(fontSize: 12, height: 1.35),

    /// Buttons, chips, list labels.
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),

    /// Compact labels.
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),

    /// Tiny labels.
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
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
