import 'package:advanced_concepts/core/errors/app_failure_message.dart';
import 'package:advanced_concepts/features/api_general_lab/data/repositories/book_api_repository.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/error_widget.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiLabCallPad extends ConsumerStatefulWidget {
  const ApiLabCallPad({
    required this.buttonKey,
    required this.label,
    required this.onCall,
    super.key,
  });

  final Key buttonKey;
  final String label;
  final Future<String> Function(WidgetRef ref) onCall;

  @override
  ConsumerState<ApiLabCallPad> createState() => _ApiLabCallPadState();
}

class _ApiLabCallPadState extends ConsumerState<ApiLabCallPad> {
  var _loading = false;
  String? _result;
  Object? _error;

  Future<void> _run() async {
    setState(() {
      _loading = true;
      _result = null;
      _error = null;
    });
    try {
      final result = await widget.onCall(ref);
      if (!mounted) return;
      setState(() {
        _loading = false;
        _result = result;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final error = _error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          key: widget.buttonKey,
          onPressed: _loading ? null : _run,
          child: Text(widget.label),
        ),
        if (_loading) ...[
          const SizedBox(height: 8),
          const Center(child: CircularProgressIndicator()),
        ],
        if (_result != null) ...[
          const SizedBox(height: 8),
          Text(_result!, style: textTheme.bodyMedium),
        ],
        if (error != null) ...[
          const SizedBox(height: 8),
          app.ErrorWidget(message: localizedError(l10n, error)),
        ],
      ],
    );
  }
}

Future<String> apiLabFetchBooks(WidgetRef ref) async {
  final books = await ref.read(bookApiRepositoryProvider).fetchBooks();
  return books.map((book) => '${book.title} — ${book.author}').join('\n');
}

Future<String> apiLabFetchSuccess(WidgetRef ref) async {
  final book = await ref.read(bookApiRepositoryProvider).fetchSuccess();
  return '${book.title} — ${book.author}';
}

Future<String> apiLabFetchError(WidgetRef ref) async {
  await ref.read(bookApiRepositoryProvider).fetchError();
  return '';
}

Future<String> apiLabFetchTimeout(WidgetRef ref, {Duration? timeout}) async {
  final book = await ref
      .read(bookApiRepositoryProvider)
      .fetchTimeout(timeout: timeout);
  return book.title;
}

Future<String> apiLabFetchOffline(WidgetRef ref) async {
  await ref.read(bookApiRepositoryProvider).fetchOffline();
  return '';
}

Future<String> apiLabIdentifyWrong(WidgetRef ref) {
  return ref
      .read(bookApiRepositoryProvider)
      .identify(title: 'Fourth Wing', author: 'Sarah J. Maas')
      .then((book) => book.title);
}
