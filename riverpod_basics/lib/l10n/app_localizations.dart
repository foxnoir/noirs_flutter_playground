import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Riverpod Basics'**
  String get appTitle;

  /// No description provided for @provider1.
  ///
  /// In en, this message translates to:
  /// **'Provider 1'**
  String get provider1;

  /// No description provided for @noProvider.
  ///
  /// In en, this message translates to:
  /// **'No Provider'**
  String get noProvider;

  /// No description provided for @stateProvider.
  ///
  /// In en, this message translates to:
  /// **'StateProvider'**
  String get stateProvider;

  /// No description provided for @notifierProvider.
  ///
  /// In en, this message translates to:
  /// **'NotifierProvider'**
  String get notifierProvider;

  /// No description provided for @asyncNotifierPersistentState.
  ///
  /// In en, this message translates to:
  /// **'AsyncNotifier Persistent State'**
  String get asyncNotifierPersistentState;

  /// No description provided for @asyncNotifierNonPersistentState.
  ///
  /// In en, this message translates to:
  /// **'AsyncNotifier Non-Persistent State'**
  String get asyncNotifierNonPersistentState;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, an error occurred.'**
  String get errorOccurred;

  /// Shown on the StateProvider screen with the current press count.
  ///
  /// In en, this message translates to:
  /// **'You have pressed the button this many times: {count}'**
  String buttonPressCount(int count);

  /// No description provided for @counter.
  ///
  /// In en, this message translates to:
  /// **'Counter'**
  String get counter;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// No description provided for @goToLanding.
  ///
  /// In en, this message translates to:
  /// **'Go to landing'**
  String get goToLanding;

  /// No description provided for @providers.
  ///
  /// In en, this message translates to:
  /// **'Providers'**
  String get providers;

  /// No description provided for @labs.
  ///
  /// In en, this message translates to:
  /// **'Labs'**
  String get labs;

  /// No description provided for @labNumber.
  ///
  /// In en, this message translates to:
  /// **'Lab {number}'**
  String labNumber(int number);

  /// No description provided for @persistent.
  ///
  /// In en, this message translates to:
  /// **'Persistent'**
  String get persistent;

  /// No description provided for @nonPersistent.
  ///
  /// In en, this message translates to:
  /// **'Non-Persistent'**
  String get nonPersistent;

  /// No description provided for @keepAliveForSeconds.
  ///
  /// In en, this message translates to:
  /// **'Keep Alive {seconds} Seconds'**
  String keepAliveForSeconds(int seconds);

  /// No description provided for @keepAliveOnResume.
  ///
  /// In en, this message translates to:
  /// **'Keep Alive: onResume (Timer stopped)'**
  String get keepAliveOnResume;

  /// No description provided for @keepAliveOnDispose.
  ///
  /// In en, this message translates to:
  /// **'Keep Alive: onDispose'**
  String get keepAliveOnDispose;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @addUser.
  ///
  /// In en, this message translates to:
  /// **'Add User'**
  String get addUser;

  /// No description provided for @autoDisposeProvider.
  ///
  /// In en, this message translates to:
  /// **'Auto Dispose Provider'**
  String get autoDisposeProvider;

  /// No description provided for @userValue.
  ///
  /// In en, this message translates to:
  /// **'User: {name}'**
  String userValue(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
