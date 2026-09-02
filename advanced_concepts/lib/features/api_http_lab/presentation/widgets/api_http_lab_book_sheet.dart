import 'package:advanced_concepts/core/errors/app_failure_message.dart';
import 'package:advanced_concepts/features/api_http_lab/domain/entities/book.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/providers/api_http_lab_provider.dart';
import 'package:advanced_concepts/features/api_http_lab/presentation/widgets/api_http_lab_book_tile.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<(String action, String title)?> showApiHttpLabBookSheet(
  BuildContext context, {
  Book? book,
}) {
  return showModalBottomSheet<(String, String)>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => ApiHttpLabBookSheet(book: book),
  );
}

class ApiHttpLabBookSheet extends ConsumerStatefulWidget {
  const ApiHttpLabBookSheet({this.book, super.key});

  final Book? book;

  @override
  ConsumerState<ApiHttpLabBookSheet> createState() =>
      _ApiHttpLabBookSheetState();
}

class _ApiHttpLabBookSheetState extends ConsumerState<ApiHttpLabBookSheet> {
  late final TextEditingController _title;
  late final TextEditingController _author;
  late BookStatus _status;
  var _loading = false;
  String? _error;

  bool get _isEdit => widget.book != null;

  @override
  void initState() {
    super.initState();
    final book = widget.book;
    _title = TextEditingController(text: book?.title ?? '');
    _author = TextEditingController(text: book?.author ?? '');
    _status = book?.status ?? BookStatus.notStarted;
  }

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final book = Book(
      id: widget.book?.id,
      title: _title.text.trim(),
      author: _author.text.trim(),
      status: _status,
    );
    try {
      final notifier = ref.read(apiHttpLabProvider.notifier);
      if (_isEdit) {
        await notifier.updateBook(book);
      } else {
        await notifier.addBook(book);
      }
      if (!mounted) return;
      Navigator.of(context).pop((_isEdit ? 'updated' : 'added', book.title));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = localizedError(AppLocalizations.of(context), error);
      });
    }
  }

  Future<void> _delete() async {
    final book = widget.book;
    final id = book?.id;
    if (book == null || id == null) {
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await ref.read(apiHttpLabProvider.notifier).deleteBook(id);
      if (!mounted) return;
      Navigator.of(context).pop(('deleted', book.title));
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = localizedError(AppLocalizations.of(context), error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final error = _error;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.book?.title ?? l10n.apiDioAdd,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('api-http-lab-book-title'),
            controller: _title,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: l10n.apiDioSearchTitleLabel),
          ),
          const SizedBox(height: 8),
          TextField(
            key: const Key('api-http-lab-book-author'),
            controller: _author,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: l10n.apiDioSearchAuthorLabel,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final status in BookStatus.values)
                FilterChip(
                  key: Key('api-http-lab-status-${status.name}'),
                  label: Text(apiHttpLabStatusLabel(l10n, status)),
                  selected: _status == status,
                  onSelected: _loading
                      ? null
                      : (_) => setState(() => _status = status),
                ),
            ],
          ),
          if (error != null) ...[
            const SizedBox(height: 12),
            Text(
              error,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          ],
          const SizedBox(height: 16),
          FilledButton(
            key: const Key('api-http-lab-book-save'),
            onPressed: _loading ? null : _save,
            child: _loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(_isEdit ? l10n.apiDioSave : l10n.apiDioAdd),
          ),
          if (_isEdit) ...[
            const SizedBox(height: 8),
            TextButton(
              key: const Key('api-http-lab-book-delete'),
              onPressed: _loading ? null : _delete,
              child: Text(l10n.apiDioDelete),
            ),
          ],
        ],
      ),
    );
  }
}
