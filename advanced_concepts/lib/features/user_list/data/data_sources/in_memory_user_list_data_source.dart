import 'package:advanced_concepts/core/errors/app_exception.dart';
import 'package:advanced_concepts/features/user_list/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class UserListDataSource {
  Future<List<UserModel>> fetchUsers();

  Future<UserModel> fetchUser(int id);
}

final userListDataSourceProvider = Provider<UserListDataSource>((ref) {
  return const InMemoryUserListDataSource();
});

/// Fake GET. Throws AppException, never AppFailure.
class InMemoryUserListDataSource implements UserListDataSource {
  const InMemoryUserListDataSource({
    this.delay = const Duration(milliseconds: 300),
  });

  final Duration delay;

  static const seedJson = [
    {
      'id': 1,
      'nickname': 'Ada',
      'email': 'ada@example.com',
      'age': 36,
      'imageUrl': 'assets/profiles/1.png',
    },
    {
      'id': 2,
      'nickname': 'Bob',
      'email': 'bob@example.com',
      'age': 29,
      'imageUrl': 'assets/profiles/2.png',
    },
    {
      'id': 3,
      'nickname': 'Cyd',
      'email': 'cyd@example.com',
      'age': 41,
      'imageUrl': 'assets/profiles/3.png',
    },
    {
      'id': 4,
      'nickname': 'Dee',
      'email': 'dee@example.com',
      'age': 33,
      'imageUrl': 'assets/profiles/4.png',
    },
    {
      'id': 5,
      'nickname': 'Eli',
      'email': 'eli@example.com',
      'age': 47,
      'imageUrl': 'assets/profiles/1.png',
    },
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
      throw const NetworkException();
    }
  }

  @override
  Future<UserModel> fetchUser(int id) async {
    try {
      final users = await fetchUsers();
      for (final user in users) {
        if (user.id == id) return user;
      }
      throw const NotFoundException();
    } on AppException {
      rethrow;
    } catch (_) {
      throw const NetworkException();
    }
  }
}
