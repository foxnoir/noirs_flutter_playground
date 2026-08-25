import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';

void main() {
  const ada = User(id: 1, username: 'Ada', age: 36, email: 'ada@example.com');

  test('copyWith replaces one field and keeps equality on the rest', () {
    final renamed = ada.copyWith(username: 'Ada Lovelace');

    expect(renamed.id, ada.id);
    expect(renamed.username, 'Ada Lovelace');
    expect(renamed.age, ada.age);
    expect(renamed.email, ada.email);
    expect(renamed, isNot(ada));
  });

  test('users with the same fields are equal', () {
    const same = User(
      id: 1,
      username: 'Ada',
      age: 36,
      email: 'ada@example.com',
    );

    expect(same, ada);
  });
}
