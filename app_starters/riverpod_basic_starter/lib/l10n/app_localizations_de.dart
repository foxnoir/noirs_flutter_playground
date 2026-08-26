// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get title => 'Titel';

  @override
  String get items => 'Einträge';

  @override
  String get itemDetail => 'Eintrag';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get two => 'Zwei';

  @override
  String get three => 'Drei';

  @override
  String get missing => 'Fehlt';

  @override
  String get back => 'Zurück';

  @override
  String get errorOccurred => 'Es ist leider ein Fehler aufgetreten.';

  @override
  String get errorNetwork =>
      'Der Server ist nicht erreichbar. Prüfe die Verbindung.';

  @override
  String get errorNotFound => 'Dieser Eintrag wurde nicht gefunden.';
}
