import 'package:advanced_concepts/features/layout_lab/presentation/widgets/layout_lab_flex.dart';
import 'package:advanced_concepts/features/layout_lab/presentation/widgets/layout_lab_info.dart';
import 'package:advanced_concepts/features/layout_lab/presentation/widgets/layout_lab_overflow.dart';
import 'package:advanced_concepts/features/layout_lab/presentation/widgets/layout_lab_preferred_size.dart';
import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LayoutLabScreen extends StatelessWidget {
  const LayoutLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.layout)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          LayoutLabInfo(),
          SizedBox(height: 24),
          LayoutLabFlex(),
          SizedBox(height: 24),
          LayoutLabPreferredSize(),
          SizedBox(height: 24),
          LayoutLabOverflow(),
        ],
      ),
    );
  }
}
