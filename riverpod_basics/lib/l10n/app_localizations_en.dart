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
  String get provider1 => 'Provider 1';

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
  String get counter => 'Counter';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get goToLanding => 'Go to landing';
}
