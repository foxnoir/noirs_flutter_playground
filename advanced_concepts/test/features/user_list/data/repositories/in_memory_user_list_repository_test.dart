import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/user_list/data/data_sources/in_memory_user_list_data_source.dart';
import 'package:advanced_concepts/features/user_list/data/models/user_model.dart';
import 'package:advanced_concepts/features/user_list/data/repositories/in_memory_user_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class _ThrowingUserListDataSource implements UserListDataSource {
  const _ThrowingUserListDataSource(this.exception);

  final AppException exception;

  @override
  Future<List<UserModel>> fetchUsers() async {
    throw exception;
  }

  @override
  Future<UserModel> fetchUser(int id) async {
    throw exception;
  }
}

void main() {
  test('maps models to entities', () async {
    const repository = InMemoryUserListRepository(
      InMemoryUserListDataSource(delay: Duration.zero),
    );

    final users = await repository.fetchUsers();

    expect(users, hasLength(5));
    expect(users.first.nickname, 'Ada');
  });

  test('maps NotFoundException to NotFoundFailure', () async {
    const repository = InMemoryUserListRepository(
      _ThrowingUserListDataSource(NotFoundException()),
    );

    await expectLater(repository.fetchUser(1), throwsA(isA<NotFoundFailure>()));
  });
}
