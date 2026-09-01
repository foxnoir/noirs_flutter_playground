import 'package:advanced_concepts/core/router/app_router_calls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum UserListArrival { go, goNamed, push, pushNamed, replaceNamed }

enum NavStackBelow { none, routing, landing }

class RoutingLabState {
  RoutingLabState({
    required this.call,
    required this.listCall,
    required this.stackBelow,
  });

  /// Last GoRouter call (banner).
  final String call;

  /// Call that opened User List. Unchanged when opening details.
  final String listCall;

  final NavStackBelow stackBelow;
}

final routingLabProvider =
    NotifierProvider<RoutingLabNotifier, RoutingLabState?>(
      RoutingLabNotifier.new,
    );

class RoutingLabNotifier extends Notifier<RoutingLabState?> {
  @override
  RoutingLabState? build() => null;

  void logged(String call) {
    state = RoutingLabState(
      call: call,
      listCall: state?.listCall ?? call,
      stackBelow: state?.stackBelow ?? NavStackBelow.none,
    );
  }

  void listOpened(UserListArrival arrival, {required String call}) {
    final stackBelow = switch (arrival) {
      UserListArrival.push ||
      UserListArrival.pushNamed => NavStackBelow.routing,
      UserListArrival.replaceNamed => NavStackBelow.landing,
      UserListArrival.go || UserListArrival.goNamed => NavStackBelow.none,
    };
    state = RoutingLabState(call: call, listCall: call, stackBelow: stackBelow);
  }

  void detailsOpened(int id) {
    state = RoutingLabState(
      call: AppRouterCalls.userDetails(id),
      listCall: state?.listCall ?? AppRouterCalls.pushNamed,
      stackBelow: state?.stackBelow ?? NavStackBelow.none,
    );
  }

  /// Logs pop, then pops. Pass the router — notifiers have no BuildContext.
  void tryPop(GoRouter router) {
    if (router.canPop()) {
      logged(AppRouterCalls.pop);
      router.pop();
      return;
    }
    logged(AppRouterCalls.popBlocked);
  }
}
