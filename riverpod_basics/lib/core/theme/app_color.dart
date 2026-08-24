import 'package:flutter/material.dart';

/// Playground palette. Widgets read these through [ThemeData], not raw hex.
abstract final class AppColor {
  static const primary = Color(0xFFB385DC);
  static const primaryContainer = Color(0xFFD0B6EB);
  static const secondary = Color(0xFF9CD1D0);
  static const secondaryContainer = Color(0xFFA8E2DC);
  static const tertiary = Color(0xFFC7EFFB);

  /// Web-badge teal. Landing section titles (`titleLarge`).
  static const teal = Color(0xFF0E6971);
}
