import 'package:advanced_concepts/features/user_list/domain/entities/user.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class UserDetailsBody extends StatelessWidget {
  const UserDetailsBody({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserDetailLine(label: l10n.nickname, value: user.nickname),
              const SizedBox(height: 12),
              _UserDetailLine(label: l10n.email, value: user.email),
              const SizedBox(height: 12),
              _UserDetailLine(label: l10n.age, value: '${user.age}'),
            ],
          ),
        ),
        const SizedBox(width: 16),
        UserAvatar(user: user, radius: 56),
      ],
    );
  }
}

class _UserDetailLine extends StatelessWidget {
  const _UserDetailLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.labelMedium),
        Text(value, style: textTheme.titleMedium),
      ],
    );
  }
}
