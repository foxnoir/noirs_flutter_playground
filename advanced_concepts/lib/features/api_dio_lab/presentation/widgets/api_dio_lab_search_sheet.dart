import 'package:advanced_concepts/core/errors/app_failure_message.dart';
import 'package:advanced_concepts/features/api_dio_lab/presentation/providers/api_dio_lab_provider.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showApiDioLabSearchSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => const ApiDioLabSearchSheet(),
  );
}

class ApiDioLabSearchSheet extends ConsumerStatefulWidget {
  const ApiDioLabSearchSheet({super.key});

  @override
  ConsumerState<ApiDioLabSearchSheet> createState() =>
      _ApiDioLabSearchSheetState();
}

class _ApiDioLabSearchSheetState extends ConsumerState<ApiDioLabSearchSheet> {
  final _title = TextEditingController();
  final _author = TextEditingController();
  var _loading = false;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final book = await ref
          .read(apiDioLabProvider.notifier)
          .search(title: _title.text.trim(), author: _author.text.trim());
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      final messenger = ScaffoldMessenger.of(context);
      Navigator.of(context).pop();
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.apiDioSearchFound(book.title))),
      );
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
            l10n.apiDioSearch,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('api-dio-lab-search-title'),
            controller: _title,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.apiDioSearchTitleLabel,
              hintText: 'Fourth Wing',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            key: const Key('api-dio-lab-search-author'),
            controller: _author,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onSubmitted: _loading ? null : (_) => _submit(),
            decoration: InputDecoration(
              labelText: l10n.apiDioSearchAuthorLabel,
              hintText: 'Rebecca Yarros',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
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
            key: const Key('api-dio-lab-search-submit'),
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.apiDioSearchSubmit),
          ),
        ],
      ),
    );
  }
}
