import 'package:advanced_concepts/features/api_general_lab/presentation/widgets/api_lab_info.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/api_lab_network.dart';
import 'package:advanced_concepts/shared_widgets/api_lab_timeout.dart';
import 'package:advanced_concepts/shared_widgets/api_lab_unified.dart';
import 'package:advanced_concepts/shared_widgets/lab_screen_body.dart';
import 'package:flutter/material.dart';

class ApiGeneralLabScreen extends StatelessWidget {
  const ApiGeneralLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.apiGeneral)),
      body: LabScreenBody(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            ApiLabInfo(),
            SizedBox(height: 24),
            ApiLabUnified(),
            SizedBox(height: 24),
            ApiLabTimeout(),
            SizedBox(height: 24),
            ApiLabNetwork(),
          ],
        ),
      ),
    );
  }
}
