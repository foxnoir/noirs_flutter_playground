abstract final class AppRouteNames {
  static const landing = 'landing';
  static const noProvider = 'noProvider';
  static const stateProvider = 'stateProvider';
  static const notifierProvider = 'notifierProvider';
  static const asyncNotifierPersistentState = 'asyncNotifierPersistentState';
  static const asyncNotifierNonPersistentState =
      'asyncNotifierNonPersistentState';
}

/// URL slugs stay stable across locales. Nested routes are relative.
abstract final class AppRoutePaths {
  static const landing = '/';
  static const noProvider = 'no-provider';
  static const stateProvider = 'state-provider';
  static const notifierProvider = 'notifier-provider';
  static const asyncNotifierPersistentState = 'async-notifier-persistent-state';
  static const asyncNotifierNonPersistentState =
      'async-notifier-non-persistent-state';
}
