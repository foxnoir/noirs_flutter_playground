import 'package:advanced_concepts/features/generics_general_lab/presentation/generics_lab_selection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genericsLabSelectionProvider =
    NotifierProvider<GenericsLabSelectionNotifier, GenericsLabSelection>(
      GenericsLabSelectionNotifier.new,
    );

class GenericsLabSelectionNotifier extends Notifier<GenericsLabSelection> {
  @override
  GenericsLabSelection build() => GenericsLabSelection.user;

  void select(GenericsLabSelection value) {
    if (state == value) return;
    state = value;
  }
}
