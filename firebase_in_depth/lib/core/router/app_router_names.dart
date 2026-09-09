abstract final class AppRouteNames {
  static const landing = 'landing';
  static const home = 'home';
  static const fundamentals = 'fundamentals';
  static const login = 'login';
}

/// URL slugs stay stable across locales. Nested routes are relative.
abstract final class AppRoutePaths {
  static const landing = '/';
  static const home = 'home';
  static const fundamentals = 'fundamentals';
  static const login = 'login';
  static const loginMode = 'mode';
  static const signUpMode = 'signup';
}
