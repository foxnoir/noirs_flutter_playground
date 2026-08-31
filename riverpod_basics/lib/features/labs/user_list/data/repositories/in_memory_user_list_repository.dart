import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/core/errors/app_failure.dart';
import 'package:riverpod_basics/features/labs/user_list/data/data_sources/in_memory_user_list_data_source.dart';
import 'package:riverpod_basics/features/labs/user_list/data/models/user_model.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/repositories/user_list_repository.dart';

final userListRepositoryProvider = Provider<UserListRepository>((ref) {
  return InMemoryUserListRepository(ref.watch(userListDataSourceProvider));
});

/// Maps models → entities and AppException → AppFailure.
/// Throwing AppFailure stands in for dartz `Left` — no extra package.
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
}
