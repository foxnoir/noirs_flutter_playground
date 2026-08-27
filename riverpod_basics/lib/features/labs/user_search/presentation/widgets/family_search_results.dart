import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_failure_message.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_family_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/widgets/user_search_results.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

class FamilySearchResults extends ConsumerWidget {
  const FamilySearchResults({required this.query, super.key});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    if (query.isEmpty) {
      return const UserSearchResults(
        isLoading: false,
        hasSearched: false,
        matches: [],
        notFoundMessage: '',
      );
    }

    // (query) is Family — it picks the mailbox, it is not search(query).
    final async = ref.watch(userSearchFamilyProvider(query));
    return async.when(
      skipLoadingOnReload: false,
      skipLoadingOnRefresh: false,
      loading: () => const UserSearchResults(
        isLoading: true,
        hasSearched: false,
        matches: [],
        notFoundMessage: '',
      ),
      error: (error, _) => ErrorWidget(message: localizedError(l10n, error)),
      data: (matches) => UserSearchResults(
        isLoading: false,
        hasSearched: true,
        matches: matches,
        notFoundMessage: l10n.userSearchNotFound,
      ),
    );
  }
}
