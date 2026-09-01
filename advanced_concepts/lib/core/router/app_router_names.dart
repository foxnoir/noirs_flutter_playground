abstract final class AppRouteNames {
  static const landing = 'landing';
  static const routing = 'routing';
  static const lists = 'lists';
  static const layout = 'layout';
  static const userList = 'userList';
  static const userDetails = 'userDetails';
}

/// URL slugs stay stable across locales.
/// User List is a sibling of Landing (not a child) so `go` can replace the stack.
abstract final class AppRoutePaths {
  static const landing = '/';
  static const routing = 'routing';
  static const lists = 'lists';
  static const layout = 'layout';
  static const userList = '/user-list';
  static const userDetails = ':userId';
}
