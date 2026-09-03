import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ApiCompareLabScenario {
  get,
  delete,
  unstable,
  timeout,
  offline,
  serverError,
}

class ApiCompareLabState {
  const ApiCompareLabState({this.scenario, this.step = 0});

  final ApiCompareLabScenario? scenario;
  final int step;
}

final apiCompareLabProvider =
    NotifierProvider<ApiCompareLabNotifier, ApiCompareLabState>(
      ApiCompareLabNotifier.new,
    );

class ApiCompareLabNotifier extends Notifier<ApiCompareLabState> {
  @override
  ApiCompareLabState build() => const ApiCompareLabState();

  void select(ApiCompareLabScenario scenario) {
    state = ApiCompareLabState(scenario: scenario);
  }

  void next(int lastStep) {
    if (state.scenario == null || state.step >= lastStep) return;
    state = ApiCompareLabState(scenario: state.scenario, step: state.step + 1);
  }

  void reset() {
    state = const ApiCompareLabState();
  }
}
