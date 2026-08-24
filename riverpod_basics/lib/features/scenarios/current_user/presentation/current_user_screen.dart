import 'package:flutter/material.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

class CurrentUserScreen extends StatefulWidget {
  const CurrentUserScreen({super.key});

  @override
  State<CurrentUserScreen> createState() => _CurrentUserScreenState();
}

class _CurrentUserScreenState extends State<CurrentUserScreen> {
  late final TextEditingController _userController;

  @override
  void initState() {
    super.initState();
    _userController = TextEditingController();
  }

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.currentUser)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: TextFormField(
                        controller: _userController,
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
                        onPressed: () {
                          // Add user once a provider exists.
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: Text(l10n.userValue('—'))),
          ],
        ),
      ),
    );
  }
}
