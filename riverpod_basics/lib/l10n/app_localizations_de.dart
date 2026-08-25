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
  String get pageNotFound => 'Seite nicht gefunden';

  @override
  String get goToLanding => 'Zur Startseite';

  @override
  String get providers => 'Providers';

  @override
  String get labs => 'Labs';

  @override
  String labNumber(int number) {
    return 'Lab $number';
  }

  @override
  String get persistent => 'Persistent';

  @override
  String get nonPersistent => 'Non-Persistent';

  @override
  String keepAliveForSeconds(int seconds) {
    return 'Keep Alive $seconds Seconds';
  }

  @override
  String get keepAliveOnResume => 'Keep Alive: onResume (Timer stopped)';

  @override
  String get keepAliveOnDispose => 'Keep Alive: onDispose';

  @override
  String get username => 'Benutzername';

  @override
  String get add => 'Hinzufügen';

  @override
  String get providerLifetimes => 'AutoDispose Provider Lifetimes';

  @override
  String get addUser => 'Benutzer hinzufügen';

  @override
  String get userList => 'Benutzerliste';

  @override
  String userValue(String name) {
    return 'Benutzer: $name';
  }

  @override
  String get id => 'Id';

  @override
  String get age => 'Alter';

  @override
  String get email => 'E-Mail';

  @override
  String get fieldRequired => 'Pflichtfeld.';

  @override
  String get invalidNumber => 'Bitte eine Zahl eingeben.';

  @override
  String get invalidEmail => 'Bitte eine gültige E-Mail eingeben.';

  @override
  String get duplicateUserId => 'Ein Benutzer mit dieser Id existiert bereits.';

  @override
  String get userAdded => 'Benutzer hinzugefügt.';

  @override
  String get fetchUsersFailed => 'Benutzer konnten nicht geladen werden.';

  @override
  String get errorTitle => 'Fehler';
}
