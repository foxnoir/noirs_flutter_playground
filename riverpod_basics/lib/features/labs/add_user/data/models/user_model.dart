import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_basics/features/labs/add_user/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String username,
    required int age,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity() {
    return User(id: id, username: username, age: age, email: email);
  }
}

extension UserToUserModel on User {
  UserModel toModel() {
    return UserModel(id: id, username: username, age: age, email: email);
  }
}
