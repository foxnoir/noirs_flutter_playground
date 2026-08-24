import 'package:flutter_riverpod/legacy.dart';

// Riverpod 3: StateProvider is legacy. Do not use it for new code.
// Prefer NotifierProvider. This file exists so the shortcut is recognizable.
final counterStateProvider = StateProvider<int>((ref) => 0);
