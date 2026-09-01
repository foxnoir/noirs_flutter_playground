/// Exact GoRouter calls shown in the lab UI (not localized — they are Dart).
abstract final class AppRouterCalls {
  static const go = "context.go('/user-list')";
  static const goNamed = "context.goNamed('userList')";
  static const push = "context.push('/user-list')";
  static const pushNamed = "context.pushNamed('userList')";
  static const goViaRouter = "ref.read(goRouterProvider).go('/user-list')";
  static const pushNamedViaRouter =
      "ref.read(goRouterProvider).pushNamed('userList')";
  static const pop = 'context.pop()';
  static const popBlocked = 'context.pop()  // canPop() is false';
  static const replaceNamed = "context.replaceNamed('userList')";

  static String userDetails(int id) {
    return "context.pushNamed('userDetails', pathParameters: {'userId': '$id'})";
  }
}
