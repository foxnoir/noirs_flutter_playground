abstract final class AppRouteNames {
  static const landing = 'landing';
  static const noProvider = 'noProvider';
  static const stateProvider = 'stateProvider';
  static const notifierProvider = 'notifierProvider';
  static const asyncNotifierPersistentState = 'asyncNotifierPersistentState';
  static const asyncNotifierNonPersistentState =
      'asyncNotifierNonPersistentState';
  static const currentUser = 'currentUser';
  static const scenario2 = 'scenario2';
  static const scenario3 = 'scenario3';
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
  static const currentUser = 'current-user';
  static const scenario2 = 'scenario-2';
  static const scenario3 = 'scenario-3';
}
