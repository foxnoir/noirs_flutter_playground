import 'package:flutter/material.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

class AddUserSection extends StatelessWidget {
  const AddUserSection({
    required this.title,
    required this.user,
    required this.controller,
    required this.onAddPressed,
    super.key,
  });

  final String title;
  final String user;
  final TextEditingController controller;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(title, style: titleStyle),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: l10n.username,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: FullWidthElevatedButton(
                  label: l10n.addUser,
                  onPressed: onAddPressed,
                ),
              ),
            ],
          ),
        ),
        Text(l10n.userValue(user)),
      ],
    );
  }
}
