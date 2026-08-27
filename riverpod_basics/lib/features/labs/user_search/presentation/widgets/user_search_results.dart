import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/shared_widgets/error_widget.dart';

class UserSearchResults extends StatelessWidget {
  const UserSearchResults({
    required this.isLoading,
    required this.hasSearched,
    required this.matches,
    required this.notFoundMessage,
    super.key,
  });

  final bool isLoading;
  final bool hasSearched;
  final List<User> matches;
  final String notFoundMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!hasSearched) {
      return const SizedBox.expand();
    }

    if (matches.isEmpty) {
      return Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: ErrorWidget(
            message: notFoundMessage,
            imageAsset: ErrorWidget.notFoundImageAsset,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final user = matches[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(user.username),
          subtitle: Text('${user.email} · ${user.age}'),
          leading: Text('${user.id}'),
        );
      },
    );
  }
}
