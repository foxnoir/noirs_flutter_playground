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
  String get noProvider => 'Kein Provider';

  @override
  String get stateProvider => 'StateProvider';

  @override
  String get notifierProvider => 'NotifierProvider';

  @override
  String get asyncNotifierPersistentState => 'AsyncNotifier Persistent State';

  @override
  String get asyncNotifierNonPersistentState =>
      'AsyncNotifier Non-Persistent State';

  @override
  String get errorOccurred => 'Es ist leider ein Fehler aufgetreten.';

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

  @override
  String get providers => 'Providers';

  @override
  String get scenarios => 'Szenarien';

  @override
  String scenarioNumber(int number) {
    return 'Szenario $number';
  }
}
