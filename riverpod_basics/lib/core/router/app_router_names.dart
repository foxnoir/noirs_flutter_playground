abstract final class AppRouteNames {
  static const landing = 'landing';
  static const noProvider = 'noProvider';
  static const stateProvider = 'stateProvider';
  static const notifierProvider = 'notifierProvider';
  static const asyncNotifierPersistentState = 'asyncNotifierPersistentState';
  static const asyncNotifierNonPersistentState =
      'asyncNotifierNonPersistentState';
  static const providerLifetimes = 'providerLifetimes';
  static const addUser = 'addUser';
  static const userList = 'userList';
  static const userSearch = 'userSearch';
  static const listenManual = 'listenManual';
  static const consumerWidget = 'consumerWidget';
  static const quote = 'quote';
  static const tick = 'tick';
  static const refresh = 'refresh';
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
  static const providerLifetimes = 'provider-lifetimes';
  static const addUser = 'add-user';
  static const userList = 'user-list';
  static const userSearch = 'user-search';
  static const listenManual = 'listen-manual';
  static const consumerWidget = 'consumer-widget';
  static const quote = 'quote';
  static const tick = 'tick';
  static const refresh = 'refresh';
}
