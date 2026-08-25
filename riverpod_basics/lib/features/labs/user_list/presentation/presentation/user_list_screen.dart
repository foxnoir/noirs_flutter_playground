import 'package:flutter/material.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  // Hardcoded rows. Not `addUserProvider` — that wiring comes later.
  static const _dummyUsers = [
    (id: 10, username: 'Grace', age: 85, email: 'grace@example.com'),
    (id: 11, username: 'Alan', age: 41, email: 'alan@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.userList)),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _dummyUsers.length,
        itemBuilder: (context, index) {
          final user = _dummyUsers[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(user.username),
            subtitle: Text('${user.email} · ${user.age}'),
            leading: Text('${user.id}'),
          );
        },
      ),
    );
  }
}
