import 'package:advanced_concepts/l10n/app_localizations.dart';
import 'package:advanced_concepts/shared_widgets/apis/api_lab_background.dart';
import 'package:advanced_concepts/shared_widgets/labs/lab_screen_body.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({required this.bookId, this.title, super.key});

  static const dragonAsset = 'assets/img/details_dragon.png';

  final String bookId;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title ?? l10n.bookDetails,
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.clip,
        ),
      ),
      body: ApiLabBackground(
        child: LabScreenBody(
          child: Center(
            child: Image.asset(
              key: Key('book-details-$bookId'),
              dragonAsset,
              width: 280,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
