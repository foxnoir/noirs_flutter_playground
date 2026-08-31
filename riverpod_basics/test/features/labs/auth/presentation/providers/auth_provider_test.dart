import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/auth/presentation/providers/auth_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('starts logged out', () {
    expect(container.read(authProvider), isFalse);
  });

  test('login then logout', () {
    container.read(authProvider.notifier).login();
    expect(container.read(authProvider), isTrue);

    container.read(authProvider.notifier).logout();
    expect(container.read(authProvider), isFalse);
  });
}
