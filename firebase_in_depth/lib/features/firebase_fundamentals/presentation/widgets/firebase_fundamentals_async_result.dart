import 'package:firebase_in_depth/core/errors/app_failure_message.dart';
import 'package:firebase_in_depth/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseFundamentalsAsyncResult<T> extends StatelessWidget {
  const FirebaseFundamentalsAsyncResult({
    required this.value,
    required this.data,
    required this.idleLabel,
    super.key,
  });

  final AsyncValue<T>? value;
  final Widget Function(T data) data;
  final String idleLabel;

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    if (value == null) {
      return Text(idleLabel, style: Theme.of(context).textTheme.bodySmall);
    }

    return value.when(
      skipLoadingOnReload: false,
      skipLoadingOnRefresh: false,
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => SelectableText(
        localizedError(AppLocalizations.of(context), error),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      data: data,
    );
  }
}
