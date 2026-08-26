import 'package:flutter/material.dart';
import 'package:riverpod_basics/features/labs/user_list/domain/entities/user.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({
    required this.label,
    required this.background,
    required this.foreground,
    required this.users,
    required this.isLoading,
    required this.onAdd,
    super.key,
  });

  final String label;
  final Color background;
  final Color foreground;
  final List<User> users;
  final bool isLoading;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: textTheme.labelLarge?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return Text(
                          l10n.userValue(users[index].username),
                          style: textTheme.bodyMedium?.copyWith(
                            color: foreground,
                          ),
                        );
                      },
                    ),
            ),
            FullWidthElevatedButton(
              label: l10n.addDemoUser,
              onPressed: isLoading ? null : onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
