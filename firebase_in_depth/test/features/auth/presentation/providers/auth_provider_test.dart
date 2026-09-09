import 'package:firebase_in_depth/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fake_auth_repository.dart';

void main() {
  ProviderContainer authContainer() {
    return ProviderContainer.test(
      overrides: [
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      ],
    );
  }

  test('signIn stores a trimmed email, signOut clears it', () async {
    final container = authContainer();
    addTearDown(container.dispose);

    await container
        .read(authProvider.notifier)
        .signIn(email: '  noir@lab.dev  ', password: '');

    final session = container.read(authProvider);
    expect(session?.email, 'noir@lab.dev');
    expect(session?.initials, 'N');
    expect(session?.role.name, 'student');

    await container.read(authProvider.notifier).signOut();
    expect(container.read(authProvider), isNull);
  });

  test('tutor@lab.dev is a tutor in the lab fake', () async {
    final container = authContainer();
    addTearDown(container.dispose);

    await container
        .read(authProvider.notifier)
        .signIn(email: 'tutor@lab.dev', password: '');

    expect(container.read(authProvider)?.role.name, 'tutor');
  });

  test('signUp creates a student session', () async {
    final container = authContainer();
    addTearDown(container.dispose);

    await container
        .read(authProvider.notifier)
        .signUp(email: 'new@lab.dev', password: '');

    final session = container.read(authProvider);
    expect(session?.email, 'new@lab.dev');
    expect(session?.role.name, 'student');
  });
}
