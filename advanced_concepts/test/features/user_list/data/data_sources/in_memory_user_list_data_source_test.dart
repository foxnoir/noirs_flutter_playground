import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/features/user_list/data/data_sources/in_memory_user_list_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fetchUsers returns five models', () async {
    const source = InMemoryUserListDataSource(delay: Duration.zero);

    final models = await source.fetchUsers();

    expect(models, hasLength(5));
    expect(models.first.nickname, 'Ada');
    expect(models.map((user) => user.imageUrl).toList(), [
      'assets/profiles/1.png',
      'assets/profiles/2.png',
      'assets/profiles/3.png',
      'assets/profiles/4.png',
      'assets/profiles/1.png',
    ]);
  });

  test('fetchUser throws NotFoundException for a missing id', () async {
    const source = InMemoryUserListDataSource(delay: Duration.zero);

    await expectLater(source.fetchUser(99), throwsA(isA<NotFoundException>()));
  });
}
