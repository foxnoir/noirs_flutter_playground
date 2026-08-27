import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/core/errors/app_failure_message.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/user_list/presentation/providers/user_list_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_family_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_provider.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/providers/user_search_state.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/widgets/family_search_results.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/widgets/user_search_panel.dart';
import 'package:riverpod_basics/features/labs/user_search/presentation/widgets/user_search_results.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';
import 'package:riverpod_basics/shared_widgets/lab_info_text.dart';

class UserSearchScreen extends ConsumerStatefulWidget {
  const UserSearchScreen({super.key});

  @override
  ConsumerState<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends ConsumerState<UserSearchScreen> {
  late final TextEditingController _queryController;
  var _familyQuery = '';

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(userListProvider.notifier).ensureLoaded();
    });
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _search() {
    final query = _queryController.text;
    setState(() => _familyQuery = query.trim());
    ref.read(userSearchProvider.notifier).search(query);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final listState = ref.watch(userListProvider);
    final searchState = ref.watch(userSearchProvider);
    final familyAsync = _familyQuery.isEmpty
        ? null
        : ref.watch(userSearchFamilyProvider(_familyQuery));
    final showSharedMiss = _bothSearchesMissed(
      listLoading: listState.isLoading,
      searchState: searchState,
      familyAsync: familyAsync,
    );

    ref.listen(userListProvider.select((state) => state.error), (_, error) {
      if (error == null) return;
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.errorTitle),
            content: Text(error.message(l10n)),
          );
        },
      );
      ref.read(userListProvider.notifier).clearError();
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.userSearch)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LabInfoText(l10n.userSearchBody, textAlign: TextAlign.start),
            const SizedBox(height: 16),
            TextField(
              controller: _queryController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _search(),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: l10n.userSearchHint,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            FullWidthElevatedButton(
              label: l10n.userSearchAction,
              onPressed: searchState.isSearching ? null : _search,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: showSharedMiss
                  ? Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: ErrorWidget(
                          message: l10n.userSearchNotFound,
                          imageAsset: ErrorWidget.notFoundImageAsset,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: UserSearchPanel(
                            key: const Key('userSearchNotifierPanel'),
                            label: l10n.userSearchNotifierLabel,
                            background: scheme.primaryContainer,
                            foreground: scheme.onPrimaryContainer,
                            child: UserSearchResults(
                              isLoading:
                                  listState.isLoading ||
                                  searchState.isSearching,
                              hasSearched: searchState.hasSearched,
                              matches: searchState.matches,
                              notFoundMessage: l10n.userSearchNotFound,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: UserSearchPanel(
                            key: const Key('userSearchFamilyPanel'),
                            label: l10n.userSearchFamilyLabel,
                            background: scheme.secondaryContainer,
                            foreground: scheme.onSecondaryContainer,
                            child: FamilySearchResults(query: _familyQuery),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _bothSearchesMissed({
  required bool listLoading,
  required UserSearchState searchState,
  required AsyncValue<List<User>>? familyAsync,
}) {
  if (listLoading || searchState.isSearching) return false;
  if (!searchState.hasSearched || searchState.matches.isNotEmpty) {
    return false;
  }
  if (familyAsync == null) return false;
  return familyAsync.maybeWhen(
    data: (matches) => matches.isEmpty,
    orElse: () => false,
  );
}
