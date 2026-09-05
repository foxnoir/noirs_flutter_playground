import 'package:advanced_concepts/features/generics_example_lab/presentation/generics_example_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genericsExampleSelectionProvider =
    NotifierProvider<GenericsExampleSelectionNotifier, GenericsExampleEnum>(
      GenericsExampleSelectionNotifier.new,
    );

class GenericsExampleSelectionNotifier extends Notifier<GenericsExampleEnum> {
  @override
  GenericsExampleEnum build() => GenericsExampleEnum.user;

  void select(GenericsExampleEnum value) {
    if (state == value) return;
    state = value;
  }
}
