/// Exact Dart shown in the lab (not localized).
abstract final class GenericsLabCodeSnippets {
  static const twoTiles =
      'class UserTile extends StatelessWidget {\n'
      '  Widget build(...) => ListTile(\n'
      '    title: Text(user.nickname),\n'
      '    subtitle: Text("User List"),\n'
      '  );\n'
      '}\n'
      '\n'
      'class BookTile extends StatelessWidget {\n'
      '  Widget build(...) => ListTile(\n'
      '    title: Text(book.title),\n'
      '    subtitle: Text("Example HTTP"),\n'
      '  );\n'
      '}';

  static const tile =
      'class GenericsLabTile<T> extends StatelessWidget {\n'
      '  const GenericsLabTile({\n'
      '    required this.item,\n'
      '    required this.titleOf,\n'
      '    required this.subtitleOf,\n'
      '  });\n'
      '  final T item;\n'
      '  final String Function(T) titleOf; // you pass this\n'
      '  final String Function(T) subtitleOf;\n'
      '\n'
      '  Widget build(...) => ListTile(\n'
      '    title: Text(titleOf(item)),\n'
      '    subtitle: Text(subtitleOf(item)),\n'
      '  );\n'
      '}\n'
      '\n'
      'GenericsLabTile<User>(\n'
      '  item: ada,\n'
      '  titleOf: (u) => u.nickname,\n'
      ')\n'
      'GenericsLabTile<Book>(\n'
      '  item: fourthWing,\n'
      '  titleOf: (b) => b.title,\n'
      ')';
}
