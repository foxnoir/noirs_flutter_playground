import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    required this.id,
    required this.nickname,
    required this.email,
    required this.age,
    required this.imageUrl,
  });

  final int id;
  final String nickname;
  final String email;
  final int age;
  final String imageUrl;

  @override
  bool operator ==(Object other) {
    return other is User &&
        other.id == id &&
        other.nickname == nickname &&
        other.email == email &&
        other.age == age &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => Object.hash(id, nickname, email, age, imageUrl);
}
