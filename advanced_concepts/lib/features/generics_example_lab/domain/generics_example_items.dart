import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';

/// Same people as User List.
const genericsExampleUsers = [
  User(
    id: 1,
    nickname: 'Ada',
    email: 'ada@example.com',
    age: 36,
    imageUrl: 'assets/user_avatars/1.png',
  ),
  User(
    id: 2,
    nickname: 'Bob',
    email: 'bob@example.com',
    age: 29,
    imageUrl: 'assets/user_avatars/2.png',
  ),
  User(
    id: 3,
    nickname: 'Cyd',
    email: 'cyd@example.com',
    age: 41,
    imageUrl: 'assets/user_avatars/3.png',
  ),
  User(
    id: 4,
    nickname: 'Dee',
    email: 'dee@example.com',
    age: 33,
    imageUrl: 'assets/user_avatars/4.png',
  ),
  User(
    id: 5,
    nickname: 'Eli',
    email: 'eli@example.com',
    age: 47,
    imageUrl: 'assets/user_avatars/1.png',
  ),
];

/// Same books as Example HTTP (seed ids 1–6).
const genericsExampleBooks = [
  Book(
    id: '1',
    title: 'A Court of Thorns and Roses',
    author: 'Sarah J. Maas',
    status: BookStatus.finished,
  ),
  Book(
    id: '2',
    title: 'A Court of Mist and Fury',
    author: 'Sarah J. Maas',
    status: BookStatus.finished,
  ),
  Book(
    id: '3',
    title: 'Fourth Wing',
    author: 'Rebecca Yarros',
    status: BookStatus.finished,
  ),
  Book(
    id: '4',
    title: 'Iron Flame',
    author: 'Rebecca Yarros',
    status: BookStatus.reading,
  ),
  Book(
    id: '5',
    title: 'Onyx Storm',
    author: 'Rebecca Yarros',
    status: BookStatus.notStarted,
  ),
  Book(
    id: '6',
    title: 'House of Earth and Blood',
    author: 'Sarah J. Maas',
    status: BookStatus.finished,
  ),
];

/// Example-lab only. [User.age] stays on User List / User Details.
int genericsExampleBooksRead(int userId) {
  return switch (userId) {
    1 => 12,
    2 => 4,
    3 => 9,
    4 => 3,
    5 => 7,
    _ => 0,
  };
}
