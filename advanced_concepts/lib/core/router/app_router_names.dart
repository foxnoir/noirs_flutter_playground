abstract final class AppRouteNames {
  static const landing = 'landing';
  static const routing = 'routing';
  static const lists = 'lists';
  static const layout = 'layout';
  static const apiHandling = 'apiHandling';
  static const apiGeneral = 'apiGeneral';
  static const apiHttp = 'apiHttp';
  static const apiDio = 'apiDio';
  static const bookDetails = 'bookDetails';
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
  static const apiHandling = 'api-handling';
  static const apiGeneral = 'general';
  static const apiHttp = 'http';
  static const apiDio = 'dio';
  static const bookDetails = 'books/:bookId';
  static const userList = '/user-list';
  static const userDetails = ':userId';
}
