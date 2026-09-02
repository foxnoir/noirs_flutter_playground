import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/lab_screen_body.dart';
import 'package:flutter/material.dart';

class ApiHttpLabScreen extends StatelessWidget {
  const ApiHttpLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).apiHttp)),
      body: const LabScreenBody(child: SizedBox.shrink()),
    );
  }
}
