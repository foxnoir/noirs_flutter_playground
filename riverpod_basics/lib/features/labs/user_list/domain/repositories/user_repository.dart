import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

// ignore: one_member_abstracts -- contract; write APIs come later
abstract interface class UserRepository {
  Future<List<User>> fetchUsers();
}
