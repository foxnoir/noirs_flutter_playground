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
  String get provider2 => 'Provider 2';

  @override
  String get provider3 => 'Provider 3';

  @override
  String get stateProvider => 'StateProvider';

  @override
  String get counter => 'Counter';

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get goToLanding => 'Go to landing';
}
