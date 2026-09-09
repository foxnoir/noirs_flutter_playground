import 'package:flutter/material.dart';

/// Playground palette. Widgets read these through [ThemeData], not raw hex.
abstract final class AppColor {
  /// Light purple. Seed color.
  static const primary = Color(0xFFB385DC);

  /// Lighter purple. Advanced Course Lab tab.
  static const primaryContainer = Color(0xFFD0B6EB);

  /// Pale turquoise. Course book fills, Beginner Course Lab tab, '
  /// auth gradient end.
  static const secondary = Color(0xFF9CD1D0);
  static const secondaryContainer = Color(0xFFA8E2DC);
  static const tertiary = Color(0xFFC7EFFB);

  /// Near-white turquoise. Auth button gradient start.
  static const secondarySoft = Color(0xFFEAF8F7);

  /// Readable turquoise. Text on secondary fills and light auth buttons.
  static const teal = Color(0xFF0E6971);

  /// Dark purple. Section titles (`titleLarge`) and Expert Course Lab tab.
  static const purple = Color(0xFF4C3469);

  /// Dusty rose. [ColorScheme.error].
  static const error = Color(0xFFC18388);

  /// Pastel rose. Listen Manual card and dialog.
  static const errorContainer = Color(0xFFE3C7C9);
  static const onError = Color(0xFF6A484B);
  static const onErrorContainer = Color(0xFF6A484B);
}
