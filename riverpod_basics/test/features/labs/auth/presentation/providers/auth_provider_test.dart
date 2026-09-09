import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('starts signed out', () {
    expect(container.read(authProvider), isFalse);
  });

  test('signIn then signOut', () {
    container.read(authProvider.notifier).signIn();
    expect(container.read(authProvider), isTrue);

    container.read(authProvider.notifier).signOut();
    expect(container.read(authProvider), isFalse);
  });

  test('signUp then signOut', () {
    container.read(authProvider.notifier).signUp();
    expect(container.read(authProvider), isTrue);

    container.read(authProvider.notifier).signOut();
    expect(container.read(authProvider), isFalse);
  });
}
