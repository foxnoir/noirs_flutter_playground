import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.nickname,
    required this.email,
    required this.age,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  final int id;
  final String nickname;
  final String email;
  final int age;
  final String imageUrl;

  User toEntity() {
    return User(
      id: id,
      nickname: nickname,
      email: email,
      age: age,
      imageUrl: imageUrl,
    );
  }
}
