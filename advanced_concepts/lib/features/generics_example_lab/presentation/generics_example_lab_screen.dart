import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/generics_example_lab/domain/generics_example_items.dart';
import 'package:advanced_concepts/features/generics_example_lab/presentation/widgets/generics_example_books_read_icon.dart';
import 'package:advanced_concepts/features/generics_example_lab/presentation/widgets/generics_example_list.dart';
import 'package:advanced_concepts/features/generics_example_lab/presentation/widgets/generics_example_row.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/apis/api_lab_background.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_info_text.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_screen_body.dart';
import 'package:advanced_concepts/shared_widgets/user_avatar.dart';
import 'package:flutter/material.dart';

enum GenericsExampleEnum { user, book }

class GenericsExampleLabScreen extends StatefulWidget {
  const GenericsExampleLabScreen({super.key});

  static const bookIcon = 'assets/img/icons/books/book_turquise.png';

  @override
  State<GenericsExampleLabScreen> createState() =>
      _GenericsExampleLabScreenState();
}

class _GenericsExampleLabScreenState extends State<GenericsExampleLabScreen> {
  var _selected = GenericsExampleEnum.user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tName = switch (_selected) {
      GenericsExampleEnum.user => 'User',
      GenericsExampleEnum.book => 'Book',
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.genericsExample)),
      body: ApiLabBackground(
        child: LabScreenBody(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabInfoText(
                  l10n.genericsExampleHint,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 12),
                SegmentedButton<GenericsExampleEnum>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                      value: GenericsExampleEnum.user,
                      label: Text(l10n.userList),
                    ),
                    ButtonSegment(
                      value: GenericsExampleEnum.book,
                      label: Text(l10n.genericsExampleBooks),
                    ),
                  ],
                  selected: {_selected},
                  onSelectionChanged: (selected) {
                    setState(() => _selected = selected.single);
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'T = $tName',
                  key: const Key('generics-example-t'),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Expanded(child: _list()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    return switch (_selected) {
      GenericsExampleEnum.user => GenericsExampleList<User>(
        items: genericsExampleUsers,
        itemBuilder: (user) => GenericsExampleRow(
          key: Key('generics-example-user-${user.id}'),
          title: user.nickname,
          subtitle: user.email,
          leading: UserAvatar(user: user),
          trailing: GenericsExampleBooksReadIcon(
            genericsExampleBooksRead(user.id),
          ),
        ),
      ),
      GenericsExampleEnum.book => GenericsExampleList<Book>(
        items: genericsExampleBooks,
        itemBuilder: (book) => GenericsExampleRow(
          key: Key('generics-example-book-${book.id}'),
          title: book.title,
          subtitle: book.author,
          leading: Image.asset(
            GenericsExampleLabScreen.bookIcon,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          trailing: GenericsExampleStatusChip(status: book.status),
        ),
      ),
    };
  }
}
