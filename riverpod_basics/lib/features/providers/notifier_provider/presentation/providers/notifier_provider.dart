import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifier<int> owns the mutable value. Widgets call methods; they do not
// write `state` themselves. That is the difference from StateProvider.
class CounterNotifier extends Notifier<int> {
  // First read of the provider. Return value becomes `state`.
  @override
  int build() => 0;

  // `state` is the current int. Assigning it notifies every `ref.watch`.
  void increment() => state++;

  void decrement() => state--;
}

// Tells Riverpod how to create the notifier. UI watches this for the int
// and reads `.notifier` for increment() / decrement().
final counterNotifierProvider = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);
