// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Riverpod Basics';

  @override
  String get noProvider => 'No Provider';

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
  String get errorOccurred => 'Unfortunately, an error occurred.';

  @override
  String buttonPressCount(int count) {
    return 'You have pressed the button this many times: $count';
  }

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get goToLanding => 'Go to landing';

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
  String get username => 'Username';

  @override
  String get add => 'Add';

  @override
  String get providerLifetimes => 'AutoDispose Provider Lifetimes';

  @override
  String get addUser => 'Add User';

  @override
  String userValue(String name) {
    return 'User: $name';
  }

  @override
  String get id => 'Id';

  @override
  String get age => 'Age';

  @override
  String get email => 'Email';

  @override
  String get fieldRequired => 'Required.';

  @override
  String get invalidNumber => 'Enter a number.';

  @override
  String get invalidEmail => 'Enter a valid email.';

  @override
  String get duplicateUserId => 'A user with this id already exists.';

  @override
  String get userAdded => 'User added.';

  @override
  String get fetchUsersFailed => 'Could not load users.';

  @override
  String get errorTitle => 'Error';
}
