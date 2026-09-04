import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';

/// Same Ada as User List.
const genericsLabAda = User(
  id: 1,
  nickname: 'Ada',
  email: 'ada@example.com',
  age: 36,
  imageUrl: 'assets/user_avatars/1.png',
);

/// Same Fourth Wing as Example HTTP.
const genericsLabFourthWing = Book(
  id: '3',
  title: 'Fourth Wing',
  author: 'Rebecca Yarros',
  status: BookStatus.finished,
);
