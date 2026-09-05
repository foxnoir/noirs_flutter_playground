import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/generics_general_lab/domain/generics_lab_items.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/generics_lab_selection.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/providers/generics_lab_selection_provider.dart';
import 'package:advanced_concepts/features/generics_general_lab/presentation/widgets/generics_lab_tile.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract final class GenericsLabIcons {
  static const userSelected = 'assets/user_avatars/2.png';
  static const userIdle = 'assets/user_avatars/5.png';
  static const bookSelected = 'assets/img/icons/books/book_purple.png';
  static const bookIdle = 'assets/img/icons/books/book_black.png';
}

class GenericsLabRows extends ConsumerWidget {
  const GenericsLabRows({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selection = ref.watch(genericsLabSelectionProvider);
    final userSelected = selection == GenericsLabSelection.user;
    final bookSelected = selection == GenericsLabSelection.book;
    final tName = switch (selection) {
      GenericsLabSelection.user => 'User',
      GenericsLabSelection.book => 'Book',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GenericsLabTile<User>(
          item: genericsLabAda,
          titleOf: (user) => user.nickname,
          subtitleOf: (_) => l10n.userList,
          selected: userSelected,
          onTap: () {
            ref
                .read(genericsLabSelectionProvider.notifier)
                .select(GenericsLabSelection.user);
          },
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
          onTap: () {
            ref
                .read(genericsLabSelectionProvider.notifier)
                .select(GenericsLabSelection.book);
          },
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
