import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/core/errors/app_failure.dart';
import 'package:advanced_concepts/features/user_list/data/data_sources/in_memory_user_list_data_source.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/features/user_list/domain/repositories/user_list_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListRepositoryProvider = Provider<UserListRepository>((ref) {
  return InMemoryUserListRepository(ref.watch(userListDataSourceProvider));
});

/// Maps models → entities and AppException → AppFailure.
class InMemoryUserListRepository implements UserListRepository {
  const InMemoryUserListRepository(this._dataSource);

  final UserListDataSource _dataSource;

  @override
  Future<List<User>> fetchUsers() async {
    try {
      final models = await _dataSource.fetchUsers();
      return [for (final model in models) model.toEntity()];
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  @override
  Future<User> fetchUser(int id) async {
    try {
      final model = await _dataSource.fetchUser(id);
      return model.toEntity();
    } on AppException catch (e) {
      throw AppFailure.fromException(e);
    }
  }
}
