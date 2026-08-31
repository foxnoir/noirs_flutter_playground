import 'package:advanced_concepts/core/router/nav_calls.dart';
import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/shared_widgets/code_snippet.dart';
import 'package:advanced_concepts/shared_widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({required this.user, required this.onTap, super.key});

  final User user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final call = NavCalls.userDetails(user.id);

    return ListTile(
      isThreeLine: true,
      leading: UserAvatar(user: user),
      title: Text(user.nickname),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${user.email} · ${user.age}'),
          const SizedBox(height: 2),
          CodeSnippet(call, maxLines: 2),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
