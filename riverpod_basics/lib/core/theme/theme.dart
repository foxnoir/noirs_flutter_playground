import 'package:flutter/material.dart';

const _primary = Color(0xFFB385DC);
const _primaryContainer = Color(0xFFD0B6EB);
const _tertiary = Color(0xFFC7EFFB);
const _secondaryContainer = Color(0xFFA8E2DC);
const _secondary = Color(0xFF9CD1D0);

ThemeData getLightTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: _primary,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    primary: _primary,
    primaryContainer: _primaryContainer,
    secondary: _secondary,
    secondaryContainer: _secondaryContainer,
    tertiary: _tertiary,
  );

  return ThemeData(
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      elevation: 0,
    ),
  );
}
