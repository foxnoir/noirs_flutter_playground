import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/user_list/data/models/user_model.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

void main() {
  const ada = User(id: 1, username: 'Ada', age: 36, email: 'ada@example.com');
  const adaModel = UserModel(
    id: 1,
    username: 'Ada',
    age: 36,
    email: 'ada@example.com',
  );
  final json = {
    'id': 1,
    'username': 'Ada',
    'age': 36,
    'email': 'ada@example.com',
  };

  test('fromJson and toJson round-trip', () {
    expect(UserModel.fromJson(json), adaModel);
    expect(adaModel.toJson(), json);
  });

  test('toEntity maps JSON fields onto the domain user', () {
    expect(adaModel.toEntity(), ada);
  });

  test('toModel maps the domain user onto JSON fields', () {
    expect(ada.toModel(), adaModel);
  });
}
