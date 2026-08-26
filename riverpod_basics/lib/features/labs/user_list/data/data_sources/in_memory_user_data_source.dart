import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_exception.dart';
import 'package:riverpod_basics/features/labs/user_list/data/models/user_model.dart';

// ignore: one_member_abstracts -- contract; write APIs come later
abstract interface class UserDataSource {
  Future<List<UserModel>> fetchUsers();
}

final userDataSourceProvider = Provider<UserDataSource>((ref) {
  return const InMemoryUserDataSource();
});

/// Fake GET. Throws AppException, never AppFailure. Mapping is the
/// repository's job.
class InMemoryUserDataSource implements UserDataSource {
  const InMemoryUserDataSource({
    this.delay = const Duration(milliseconds: 300),
  });

  final Duration delay;

  static const seedJson = [
    {'id': 10, 'username': 'Grace', 'age': 85, 'email': 'grace@example.com'},
    {'id': 11, 'username': 'Alan', 'age': 41, 'email': 'alan@example.com'},
  ];

  @override
  Future<List<UserModel>> fetchUsers() async {
    try {
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }

      return [
        for (final json in seedJson)
          UserModel.fromJson(Map<String, dynamic>.from(json)),
      ];
    } on AppException {
      rethrow;
    } catch (_) {
      // Unexpected (parse, etc.) → AppException. Repo only maps AppException.
      throw const NetworkException();
    }
  }
}
