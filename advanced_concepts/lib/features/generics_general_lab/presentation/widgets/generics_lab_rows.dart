import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/generics_general_lab/domain/generics_lab_items.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/widgets/generics_lab_tile.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum GenericsLabKind { user, book }

abstract final class GenericsLabIcons {
  static const userSelected = 'assets/user_avatars/2.png';
  static const userIdle = 'assets/user_avatars/5.png';
  static const bookSelected = 'assets/img/icons/books/book_purple.png';
  static const bookIdle = 'assets/img/icons/books/book_black.png';
}

class GenericsLabRows extends StatefulWidget {
  const GenericsLabRows({super.key});

  @override
  State<GenericsLabRows> createState() => _GenericsLabRowsState();
}

class _GenericsLabRowsState extends State<GenericsLabRows> {
  var _kind = GenericsLabKind.user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final userSelected = _kind == GenericsLabKind.user;
    final bookSelected = _kind == GenericsLabKind.book;
    final tName = switch (_kind) {
      GenericsLabKind.user => 'User',
      GenericsLabKind.book => 'Book',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GenericsLabTile<User>(
          item: genericsLabAda,
          titleOf: (user) => user.nickname,
          subtitleOf: (_) => l10n.userList,
          selected: userSelected,
          onTap: () => setState(() => _kind = GenericsLabKind.user),
          tileKey: const Key('generics-lab-user'),
          leading: ClipOval(
            child: Image.asset(
              userSelected
                  ? GenericsLabIcons.userSelected
                  : GenericsLabIcons.userIdle,
              key: const Key('generics-lab-user-icon'),
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        GenericsLabTile<Book>(
          item: genericsLabFourthWing,
          titleOf: (book) => book.title,
          subtitleOf: (_) => l10n.apiHttp,
          selected: bookSelected,
          onTap: () => setState(() => _kind = GenericsLabKind.book),
          tileKey: const Key('generics-lab-book'),
          leading: Image.asset(
            bookSelected
                ? GenericsLabIcons.bookSelected
                : GenericsLabIcons.bookIdle,
            key: const Key('generics-lab-book-icon'),
            width: 56,
            height: 56,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'T = $tName',
          key: const Key('generics-lab-t'),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
