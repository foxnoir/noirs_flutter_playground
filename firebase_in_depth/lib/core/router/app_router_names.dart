abstract final class AppRouteNames {
  static const home = 'home';
  static const items = 'items';
  static const itemDetails = 'itemDetails';
  static const two = 'two';
  static const three = 'three';
}

/// URL slugs stay stable across locales. Nested routes are relative.
abstract final class AppRoutePaths {
  static const home = '/';
  static const items = 'items';
  static const itemDetails = ':itemId';
  static const two = 'two';
  static const three = 'three';
}
