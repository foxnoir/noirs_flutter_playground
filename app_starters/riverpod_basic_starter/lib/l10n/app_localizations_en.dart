// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Title';

  @override
  String get items => 'Items';

  @override
  String get itemDetail => 'Item';

  @override
  String get retry => 'Retry';

  @override
  String get two => 'Two';

  @override
  String get three => 'Three';

  @override
  String get missing => 'Missing';

  @override
  String get back => 'Back';

  @override
  String get errorOccurred => 'Unfortunately, an error occurred.';

  @override
  String get errorNetwork =>
      'Could not reach the server. Check your connection.';

  @override
  String get errorNotFound => 'That item was not found.';
}
