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
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Firebase in Depth'**
  String get title;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @fundamentals.
  ///
  /// In en, this message translates to:
  /// **'Firebase Fundamentals'**
  String get fundamentals;

  /// No description provided for @missing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get missing;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, an error occurred.'**
  String get errorOccurred;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Could not reach the server. Check your connection.'**
  String get errorNetwork;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'That item was not found.'**
  String get errorNotFound;

  /// No description provided for @errorInvalidQuery.
  ///
  /// In en, this message translates to:
  /// **'This query is not valid for Firestore.'**
  String get errorInvalidQuery;

  /// No description provided for @fundamentalsDevtoolsHint.
  ///
  /// In en, this message translates to:
  /// **'Start this lab in Chrome. Open DevTools (View → Developer → Developer Tools, or Cmd+Option+I) → Network → filter firestore. Each button below is a real Firestore read. Watch the request and the response there. The Firebase Console is for reading fields; DevTools is for seeing that a call happened.'**
  String get fundamentalsDevtoolsHint;

  /// No description provided for @fundamentalsReadTitle.
  ///
  /// In en, this message translates to:
  /// **'Read a collection and a document'**
  String get fundamentalsReadTitle;

  /// No description provided for @fundamentalsReadHint.
  ///
  /// In en, this message translates to:
  /// **'A collection is every course, ordered by seqNo. A document is one course by id (hiragana-from-zero) — not the first row of the list.'**
  String get fundamentalsReadHint;

  /// No description provided for @fundamentalsReadDocument.
  ///
  /// In en, this message translates to:
  /// **'Read document'**
  String get fundamentalsReadDocument;

  /// No description provided for @fundamentalsReadCollection.
  ///
  /// In en, this message translates to:
  /// **'Read collection'**
  String get fundamentalsReadCollection;

  /// No description provided for @fundamentalsIdle.
  ///
  /// In en, this message translates to:
  /// **'Not run yet. Open DevTools first, then tap a button.'**
  String get fundamentalsIdle;

  /// No description provided for @fundamentalsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No documents matched.'**
  String get fundamentalsEmpty;

  /// No description provided for @fundamentalsCourseMeta.
  ///
  /// In en, this message translates to:
  /// **'seqNo {seqNo} · {lessonsCount} lessons'**
  String fundamentalsCourseMeta(int seqNo, int lessonsCount);

  /// No description provided for @fundamentalsQueryTitle.
  ///
  /// In en, this message translates to:
  /// **'Performance guarantees and indexes'**
  String get fundamentalsQueryTitle;

  /// No description provided for @fundamentalsQueryHint.
  ///
  /// In en, this message translates to:
  /// **'Firestore answers from indexes, not by scanning the collection. That is the performance guarantee: query cost stays predictable as the data grows. One range filter plus orderBy on the same field can use the automatic single-field index. Two range filters on different fields cannot. Equality on one field plus a range on another needs a composite index. This lab has one composite (`url` + `seqNo`) and leaves `price` + `seqNo` without one.'**
  String get fundamentalsQueryHint;

  /// No description provided for @fundamentalsQueryValidTitle.
  ///
  /// In en, this message translates to:
  /// **'where seqNo <= 5, orderBy seqNo'**
  String get fundamentalsQueryValidTitle;

  /// No description provided for @fundamentalsQueryValidHint.
  ///
  /// In en, this message translates to:
  /// **'Inequality and orderBy on the same field. Firestore walks one index. This is the query that works.'**
  String get fundamentalsQueryValidHint;

  /// No description provided for @fundamentalsQueryInvalidTitle.
  ///
  /// In en, this message translates to:
  /// **'where seqNo <= 5 and lessonsCount <= 10'**
  String get fundamentalsQueryInvalidTitle;

  /// No description provided for @fundamentalsQueryInvalidHint.
  ///
  /// In en, this message translates to:
  /// **'Two inequalities on different fields. The Angular sample failed with: all inequality filters must be on the same field. Run it and read the FirebaseError here and in DevTools.'**
  String get fundamentalsQueryInvalidHint;

  /// No description provided for @fundamentalsQueryCompositeTitle.
  ///
  /// In en, this message translates to:
  /// **'where seqNo <= 20 and url == hiragana-from-zero'**
  String get fundamentalsQueryCompositeTitle;

  /// No description provided for @fundamentalsQueryCompositeHint.
  ///
  /// In en, this message translates to:
  /// **'Range on seqNo plus equality on url. That pair has a composite index in firestore.indexes.json (`url` then `seqNo`). Same shape as the missing-index button, except the index exists.'**
  String get fundamentalsQueryCompositeHint;

  /// No description provided for @fundamentalsQueryIndexTitle.
  ///
  /// In en, this message translates to:
  /// **'where seqNo <= 20 and price == 15'**
  String get fundamentalsQueryIndexTitle;

  /// No description provided for @fundamentalsQueryIndexHint.
  ///
  /// In en, this message translates to:
  /// **'Same shape as the composite button, different field pair. There is no composite for `price` + `seqNo`. The error includes a Console URL — do not click it if you want this button to keep failing.'**
  String get fundamentalsQueryIndexHint;

  /// No description provided for @fundamentalsRunValidQuery.
  ///
  /// In en, this message translates to:
  /// **'Run valid query'**
  String get fundamentalsRunValidQuery;

  /// No description provided for @fundamentalsRunInvalidQuery.
  ///
  /// In en, this message translates to:
  /// **'Run invalid query'**
  String get fundamentalsRunInvalidQuery;

  /// No description provided for @fundamentalsRunCompositeQuery.
  ///
  /// In en, this message translates to:
  /// **'Run composite-index query'**
  String get fundamentalsRunCompositeQuery;

  /// No description provided for @fundamentalsRunIndexQuery.
  ///
  /// In en, this message translates to:
  /// **'Run missing-index query'**
  String get fundamentalsRunIndexQuery;
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
