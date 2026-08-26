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

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @providerLifetimes.
  ///
  /// In en, this message translates to:
  /// **'AutoDispose Provider Lifetimes'**
  String get providerLifetimes;

  /// No description provided for @addUser.
  ///
  /// In en, this message translates to:
  /// **'Add User'**
  String get addUser;

  /// No description provided for @userList.
  ///
  /// In en, this message translates to:
  /// **'User List'**
  String get userList;

  /// No description provided for @userValue.
  ///
  /// In en, this message translates to:
  /// **'User: {name}'**
  String userValue(String name);

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'Id'**
  String get id;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required.'**
  String get fieldRequired;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number.'**
  String get invalidNumber;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email.'**
  String get invalidEmail;

  /// No description provided for @duplicateUserId.
  ///
  /// In en, this message translates to:
  /// **'A user with this id already exists.'**
  String get duplicateUserId;

  /// No description provided for @duplicateEmail.
  ///
  /// In en, this message translates to:
  /// **'A user with this email already exists.'**
  String get duplicateEmail;

  /// No description provided for @userAdded.
  ///
  /// In en, this message translates to:
  /// **'User added.'**
  String get userAdded;

  /// No description provided for @fetchUsersFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load users.'**
  String get fetchUsersFailed;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @listenManual.
  ///
  /// In en, this message translates to:
  /// **'Listen Manual'**
  String get listenManual;

  /// No description provided for @listenManualBody.
  ///
  /// In en, this message translates to:
  /// **'Same stored error, four colors. Purple watch is always the live value — filled after Back. Gray read is frozen at open. Red listenManual is the dialog (also on reopen). Teal listen is the SnackBar and stays empty on the second visit.'**
  String get listenManualBody;

  /// No description provided for @listenManualWatchLabel.
  ///
  /// In en, this message translates to:
  /// **'watch'**
  String get listenManualWatchLabel;

  /// No description provided for @listenManualIdle.
  ///
  /// In en, this message translates to:
  /// **'Live value. Empty now.'**
  String get listenManualIdle;

  /// No description provided for @listenManualStored.
  ///
  /// In en, this message translates to:
  /// **'Live value. Filled — survives Back.'**
  String get listenManualStored;

  /// No description provided for @listenManualStoreError.
  ///
  /// In en, this message translates to:
  /// **'Store an error'**
  String get listenManualStoreError;

  /// No description provided for @listenManualClearError.
  ///
  /// In en, this message translates to:
  /// **'Clear error'**
  String get listenManualClearError;

  /// No description provided for @listenManualFetchFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load. This stays until you tap Clear error.'**
  String get listenManualFetchFailed;

  /// No description provided for @listenManualManualLabel.
  ///
  /// In en, this message translates to:
  /// **'listenManual'**
  String get listenManualManualLabel;

  /// No description provided for @listenManualManualIdle.
  ///
  /// In en, this message translates to:
  /// **'No stored error on open.'**
  String get listenManualManualIdle;

  /// No description provided for @listenManualManualFired.
  ///
  /// In en, this message translates to:
  /// **'Ran on open — error was already stored.'**
  String get listenManualManualFired;

  /// No description provided for @listenManualListenLabel.
  ///
  /// In en, this message translates to:
  /// **'listen'**
  String get listenManualListenLabel;

  /// No description provided for @listenManualListenIdle.
  ///
  /// In en, this message translates to:
  /// **'No change this visit.'**
  String get listenManualListenIdle;

  /// No description provided for @listenManualListenFired.
  ///
  /// In en, this message translates to:
  /// **'Saw a change this visit.'**
  String get listenManualListenFired;

  /// No description provided for @listenManualListenSnackBar.
  ///
  /// In en, this message translates to:
  /// **'listen: the value changed.'**
  String get listenManualListenSnackBar;

  /// No description provided for @listenManualReadLabel.
  ///
  /// In en, this message translates to:
  /// **'read'**
  String get listenManualReadLabel;

  /// No description provided for @listenManualReadIdle.
  ///
  /// In en, this message translates to:
  /// **'Snapshot at open: null. Store an error will not change this.'**
  String get listenManualReadIdle;

  /// No description provided for @listenManualReadFired.
  ///
  /// In en, this message translates to:
  /// **'Snapshot at open: stored error. initState ran again.'**
  String get listenManualReadFired;

  /// No description provided for @consumerWidget.
  ///
  /// In en, this message translates to:
  /// **'Consumer Widget'**
  String get consumerWidget;

  /// No description provided for @consumerWidgetBody.
  ///
  /// In en, this message translates to:
  /// **'Both panels show the same users because they **watch** the same provider.\n\nTop: a **StatelessWidget** wraps **Consumer** only to get **ref**.\n\nBottom: **ConsumerWidget** — **build** already has **ref**, so there is no wrapper. Prefer **ConsumerWidget**.\n\nUse **ConsumerStatefulWidget** only when you need **initState** or **dispose**.'**
  String get consumerWidgetBody;

  /// No description provided for @consumerWrapLabel.
  ///
  /// In en, this message translates to:
  /// **'StatelessWidget + Consumer'**
  String get consumerWrapLabel;

  /// No description provided for @consumerWidgetLabel.
  ///
  /// In en, this message translates to:
  /// **'ConsumerWidget'**
  String get consumerWidgetLabel;

  /// No description provided for @addDemoUser.
  ///
  /// In en, this message translates to:
  /// **'Add demo user'**
  String get addDemoUser;

  /// No description provided for @refreshLab.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshLab;

  /// No description provided for @refreshLabBody.
  ///
  /// In en, this message translates to:
  /// **'**refresh** is always **invalidate** plus an immediate **read**. That is why refresh returns a Future. Use **refresh** when this callback must wait. **Pull-to-refresh** is the usual case.\n\nUse **invalidate** when you do not need to wait. It marks the provider stale. Whoever **watch**es it reloads. That is the usual choice after a mutation: save, delete, logout, or any time the cache is old.\n\n**Refresh** and **Refresh 3x** disable while they wait so you cannot stack taps. **Invalidate** stays tappable.\n\n**Invalidate 3x** starts one GET. **Refresh 3x** starts three. The **Refresh** button blinks once. **Refresh 3x** blinks three times.'**
  String get refreshLabBody;

  /// No description provided for @refreshLabWatchLabel.
  ///
  /// In en, this message translates to:
  /// **'watch'**
  String get refreshLabWatchLabel;

  /// No description provided for @refreshLabLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get refreshLabLoading;

  /// No description provided for @refreshLabPing.
  ///
  /// In en, this message translates to:
  /// **'Fetch {n} · {time}'**
  String refreshLabPing(int n, String time);

  /// No description provided for @refreshLabRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshLabRefresh;

  /// No description provided for @refreshLabWaitingOnFuture.
  ///
  /// In en, this message translates to:
  /// **'Waiting on Future…'**
  String get refreshLabWaitingOnFuture;

  /// No description provided for @refreshLabWaitingOnThreeFutures.
  ///
  /// In en, this message translates to:
  /// **'Waiting on 3 Futures…'**
  String get refreshLabWaitingOnThreeFutures;

  /// No description provided for @refreshLabInvalidate.
  ///
  /// In en, this message translates to:
  /// **'Invalidate'**
  String get refreshLabInvalidate;

  /// No description provided for @refreshLabRefreshThree.
  ///
  /// In en, this message translates to:
  /// **'Refresh 3x'**
  String get refreshLabRefreshThree;

  /// No description provided for @refreshLabInvalidateThree.
  ///
  /// In en, this message translates to:
  /// **'Invalidate 3x'**
  String get refreshLabInvalidateThree;
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
