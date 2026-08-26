import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

/// Throws AppFailure when the data source failed. No user-facing strings.
// ignore: one_member_abstracts -- contract; write APIs come later
abstract interface class UserRepository {
  Future<List<User>> fetchUsers();
}
