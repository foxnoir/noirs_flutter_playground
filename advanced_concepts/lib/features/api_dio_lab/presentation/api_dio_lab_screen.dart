import 'package:advanced_concepts/features/api_dio_lab/presentation/widgets/api_dio_lab_body.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/lab_screen_body.dart';
import 'package:flutter/material.dart';

class ApiDioLabScreen extends StatelessWidget {
  const ApiDioLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).apiDio)),
      body: const LabScreenBody(child: ApiDioLabBody()),
    );
  }
}
