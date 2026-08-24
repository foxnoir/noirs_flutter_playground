// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Riverpod Basics';

  @override
  String get provider1 => 'Provider 1';

  @override
  String get provider3 => 'Provider 3';

  @override
  String get noProvider => 'Kein Provider';

  @override
  String get stateProvider => 'StateProvider';

  @override
  String get notifierProvider => 'NotifierProvider';

  @override
  String buttonPressCount(int count) {
    return 'Du hast den Button so oft gedrückt: $count';
  }

  @override
  String get counter => 'Zähler';

  @override
  String get pageNotFound => 'Seite nicht gefunden';

  @override
  String get goToLanding => 'Zur Startseite';
}
