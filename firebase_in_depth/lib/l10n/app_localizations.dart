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

  /// App and document title.
  ///
  /// In en, this message translates to:
  /// **'Firebase in Depth'**
  String get title;

  /// Retry button on error UI.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Lab screen title and landing tile.
  ///
  /// In en, this message translates to:
  /// **'Firebase Fundamentals'**
  String get fundamentals;

  /// Placeholder for a missing value.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get missing;

  /// Navigate back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Header brand link back to the landing page.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Header link to the Firestore query lab.
  ///
  /// In en, this message translates to:
  /// **'Fundamentals'**
  String get navFundamentals;

  /// Header link to the course catalog home.
  ///
  /// In en, this message translates to:
  /// **'Lab'**
  String get navLab;

  /// Landing card copy for Course Lab.
  ///
  /// In en, this message translates to:
  /// **'Beginner, advanced, and expert tracks. Tap a link or swipe the pages.'**
  String get courseLabCardBody;

  /// Landing card copy for Firebase Fundamentals.
  ///
  /// In en, this message translates to:
  /// **'Collection reads, indexes, nested lessons, and realtime snapshots.'**
  String get fundamentalsCardBody;

  /// Generic error fallback.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, an error occurred.'**
  String get errorOccurred;

  /// Service unreachable. No jargon, no user blame; recovery is try later.
  ///
  /// In en, this message translates to:
  /// **'Sorry, there is a problem with the service. Try again later.'**
  String get errorNetwork;

  /// Not-found failure message.
  ///
  /// In en, this message translates to:
  /// **'That item was not found.'**
  String get errorNotFound;

  /// Permission-denied write, usually undeployed rules.
  ///
  /// In en, this message translates to:
  /// **'This write is not allowed. Deploy firestore.rules (only participants on a course), then tap Increment again.'**
  String get errorPermission;

  /// Invalid query fallback when Firestore sent no detail.
  ///
  /// In en, this message translates to:
  /// **'This query is not valid for Firestore.'**
  String get errorInvalidQuery;

  /// How to watch Firestore traffic in Chrome DevTools.
  ///
  /// In en, this message translates to:
  /// **'Start this lab in **Chrome**. Open **DevTools** (View → Developer → Developer Tools, or Cmd+Option+I) → **Network** → filter `firestore`. Each button below is a real Firestore read. Watch the request and the response there. The Firebase Console is for reading fields; DevTools is for seeing that a call happened.'**
  String get fundamentalsDevtoolsHint;

  /// Section title for collection vs document reads.
  ///
  /// In en, this message translates to:
  /// **'Read a collection and a document'**
  String get fundamentalsReadTitle;

  /// Explains collection vs one document by id.
  ///
  /// In en, this message translates to:
  /// **'A **collection** is every course, ordered by `seqNo`. A **document** is one course by id (`hiragana-from-zero`) — not the first row of the list.'**
  String get fundamentalsReadHint;

  /// Button to fetch one course document.
  ///
  /// In en, this message translates to:
  /// **'Read document'**
  String get fundamentalsReadDocument;

  /// Button to fetch all courses.
  ///
  /// In en, this message translates to:
  /// **'Read collection'**
  String get fundamentalsReadCollection;

  /// Idle label before a lab button is tapped.
  ///
  /// In en, this message translates to:
  /// **'Not run yet. Open DevTools first, then tap a button.'**
  String get fundamentalsIdle;

  /// Empty query result.
  ///
  /// In en, this message translates to:
  /// **'No documents matched.'**
  String get fundamentalsEmpty;

  /// Course tile subtitle.
  ///
  /// In en, this message translates to:
  /// **'seqNo {seqNo} · {lessonsCount} lessons'**
  String fundamentalsCourseMeta(int seqNo, int lessonsCount);

  /// Section title for the index lab.
  ///
  /// In en, this message translates to:
  /// **'Performance guarantees and indexes'**
  String get fundamentalsQueryTitle;

  /// Explains indexes and the four query buttons.
  ///
  /// In en, this message translates to:
  /// **'Firestore answers from **indexes**, not by scanning the collection. That is the performance guarantee: query cost stays predictable as the data grows. One **range** filter plus `orderBy` on the same field can use the automatic single-field index. Two range filters on different fields cannot. Equality on one field plus a range on another needs a **composite** index. This lab has one composite (`url` + `seqNo`) and leaves `price` + `seqNo` without one.'**
  String get fundamentalsQueryHint;

  /// Monospace title for the valid query card.
  ///
  /// In en, this message translates to:
  /// **'where seqNo <= 5, orderBy seqNo'**
  String get fundamentalsQueryValidTitle;

  /// Hint under the valid seqNo query.
  ///
  /// In en, this message translates to:
  /// **'Inequality and orderBy on the same field. Firestore walks one index. This is the query that works.'**
  String get fundamentalsQueryValidHint;

  /// Monospace title for the two-inequality query card.
  ///
  /// In en, this message translates to:
  /// **'where seqNo <= 5 and lessonsCount <= 10'**
  String get fundamentalsQueryInvalidTitle;

  /// Hint under the invalid two-inequality query.
  ///
  /// In en, this message translates to:
  /// **'Two inequalities on different fields. The Angular sample failed with: all inequality filters must be on the same field. Run it and read the FirebaseError here and in DevTools.'**
  String get fundamentalsQueryInvalidHint;

  /// Monospace title for the composite-index query card.
  ///
  /// In en, this message translates to:
  /// **'where seqNo <= 20 and url == hiragana-from-zero'**
  String get fundamentalsQueryCompositeTitle;

  /// Hint under the composite url plus seqNo query.
  ///
  /// In en, this message translates to:
  /// **'Range on seqNo plus equality on url. That pair has a composite index in firestore.indexes.json (`url` then `seqNo`). Same shape as the missing-index button, except the index exists.'**
  String get fundamentalsQueryCompositeHint;

  /// Monospace title for the missing-index query card.
  ///
  /// In en, this message translates to:
  /// **'where seqNo <= 20 and price == 15'**
  String get fundamentalsQueryIndexTitle;

  /// Hint under the missing price plus seqNo index query.
  ///
  /// In en, this message translates to:
  /// **'Same shape as the composite button, different field pair. There is no composite for `price` + `seqNo`. The error includes a Console URL — do not click it if you want this button to keep failing.'**
  String get fundamentalsQueryIndexHint;

  /// Button for the valid seqNo query.
  ///
  /// In en, this message translates to:
  /// **'Run valid query'**
  String get fundamentalsRunValidQuery;

  /// Button for the two-inequality query.
  ///
  /// In en, this message translates to:
  /// **'Run invalid query'**
  String get fundamentalsRunInvalidQuery;

  /// Button for the composite url plus seqNo query.
  ///
  /// In en, this message translates to:
  /// **'Run composite-index query'**
  String get fundamentalsRunCompositeQuery;

  /// Button for the missing price plus seqNo index query.
  ///
  /// In en, this message translates to:
  /// **'Run missing-index query'**
  String get fundamentalsRunIndexQuery;

  /// Section title for nested lessons vs collection group.
  ///
  /// In en, this message translates to:
  /// **'Nested collection vs collection group'**
  String get fundamentalsLessonsTitle;

  /// Explains nested lessons vs collectionGroup.
  ///
  /// In en, this message translates to:
  /// **'A **nested** query stays under one course. A **collection group** query walks every `lessons` subcollection in the project. That is how you list all lessons without knowing each course id. Rules need a recursive match on `lessons`. `orderBy seqNo` needs a `COLLECTION_GROUP` index.'**
  String get fundamentalsLessonsHint;

  /// Monospace title for the nested lessons card.
  ///
  /// In en, this message translates to:
  /// **'courses/hiragana-from-zero/lessons orderBy seqNo'**
  String get fundamentalsLessonsNestedTitle;

  /// Hint under the nested lessons query.
  ///
  /// In en, this message translates to:
  /// **'One parent path. Automatic single-field index. Only Hiragana lessons.'**
  String get fundamentalsLessonsNestedHint;

  /// Monospace title for the collection-group card.
  ///
  /// In en, this message translates to:
  /// **'collectionGroup(\'lessons\') orderBy seqNo'**
  String get fundamentalsLessonsGroupTitle;

  /// Hint under the collection-group query.
  ///
  /// In en, this message translates to:
  /// **'Same collection id under every course. Parent is not in the path. courseId comes from the snapshot parent. CREATE the collection-group index if Firestore returns a URL — this one you do want.'**
  String get fundamentalsLessonsGroupHint;

  /// Button to fetch lessons under one course.
  ///
  /// In en, this message translates to:
  /// **'Read nested lessons'**
  String get fundamentalsReadNestedLessons;

  /// Button to fetch all lessons via collectionGroup.
  ///
  /// In en, this message translates to:
  /// **'Run collection-group query'**
  String get fundamentalsRunCollectionGroup;

  /// Lesson tile subtitle.
  ///
  /// In en, this message translates to:
  /// **'{courseId} · seqNo {seqNo} · {duration}'**
  String fundamentalsLessonMeta(String courseId, int seqNo, String duration);

  /// Section title for the snapshots lab.
  ///
  /// In en, this message translates to:
  /// **'Realtime snapshots'**
  String get fundamentalsRealtimeTitle;

  /// Explains snapshots vs get and the participants increment.
  ///
  /// In en, this message translates to:
  /// **'AngularFire **snapshotChanges** is Flutter `snapshots()` plus `docChanges`. `get()` is one answer. `snapshots()` stays open: the first event is every course as **added**, then **added** / **modified** / **removed**.\n\n**Increment** writes `FieldValue.increment(1)` on `hiragana-from-zero.participants` — two clients cannot overwrite each other. Change the same number in the Console; the listen updates. Rules allow only that field. Publish `firestore.rules` (Console or CLI) or increment fails.\n\nOpen **DevTools** → **Network** → filter `firestore` before you tap. **Listen** dumps the first Listen/`channel` payload (the full current list). **Increment** should add a **new** call — the write, then the live snapshot. Tiny pings while listening are keepalives, not new course dumps.'**
  String get fundamentalsRealtimeHint;

  /// Monospace title for the live course list.
  ///
  /// In en, this message translates to:
  /// **'courses orderBy seqNo — snapshots()'**
  String get fundamentalsRealtimeListenTitle;

  /// Hint under the listen card.
  ///
  /// In en, this message translates to:
  /// **'**Listen** opens the stream. **Stop** unsubscribes; the last list stays on screen but no longer updates. In **DevTools** → **Network** (filter `firestore`) the first **Listen** dump is the full list, not a one-shot `get()`.'**
  String get fundamentalsRealtimeListenHint;

  /// Monospace title for the change log and increment.
  ///
  /// In en, this message translates to:
  /// **'docChanges + increment participants'**
  String get fundamentalsRealtimeChangesTitle;

  /// Hint under the docChanges card.
  ///
  /// In en, this message translates to:
  /// **'This batch of diffs, not the full history. **Increment** `hiragana-from-zero` in the app or set `participants` in the Console — both should show **modified**. Watch **Network**: **Increment** should add a new `firestore` call.'**
  String get fundamentalsRealtimeChangesHint;

  /// Start the courses snapshots stream.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get fundamentalsRealtimeListen;

  /// Cancel the snapshots subscription.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get fundamentalsRealtimeStop;

  /// Add one participant on hiragana-from-zero.
  ///
  /// In en, this message translates to:
  /// **'Increment participants'**
  String get fundamentalsRealtimeIncrement;

  /// Idle label before Listen is tapped.
  ///
  /// In en, this message translates to:
  /// **'Not listening. Tap Listen, then increment or edit the Console.'**
  String get fundamentalsRealtimeIdle;

  /// Idle label before increment is tapped.
  ///
  /// In en, this message translates to:
  /// **'Not incremented yet.'**
  String get fundamentalsRealtimeIncrementIdle;

  /// Idle label for the change log.
  ///
  /// In en, this message translates to:
  /// **'No snapshot yet.'**
  String get fundamentalsRealtimeChangesIdle;

  /// docChanges type added.
  ///
  /// In en, this message translates to:
  /// **'added'**
  String get fundamentalsChangeAdded;

  /// docChanges type modified.
  ///
  /// In en, this message translates to:
  /// **'modified'**
  String get fundamentalsChangeModified;

  /// docChanges type removed.
  ///
  /// In en, this message translates to:
  /// **'removed'**
  String get fundamentalsChangeRemoved;

  /// One docChange row.
  ///
  /// In en, this message translates to:
  /// **'{type} · {description} · {participants} participants'**
  String fundamentalsRealtimeChange(
    String type,
    String description,
    int participants,
  );

  /// Course tile subtitle in the realtime list.
  ///
  /// In en, this message translates to:
  /// **'seqNo {seqNo} · {lessonsCount} lessons · {participants} participants'**
  String fundamentalsRealtimeCourseMeta(
    int seqNo,
    int lessonsCount,
    int participants,
  );

  /// Landing tile for the course catalog.
  ///
  /// In en, this message translates to:
  /// **'Firebase Course Lab'**
  String get courseLab;

  /// Home swap segment for beginner courses.
  ///
  /// In en, this message translates to:
  /// **'Beginner course'**
  String get courseLabBeginner;

  /// Home swap segment for advanced courses.
  ///
  /// In en, this message translates to:
  /// **'Advanced course'**
  String get courseLabAdvanced;

  /// Home swap segment for expert courses.
  ///
  /// In en, this message translates to:
  /// **'Expert course'**
  String get courseLabExpert;

  /// Beginner panel headline on Course Lab Home.
  ///
  /// In en, this message translates to:
  /// **'Start with the kana.'**
  String get courseLabBeginnerHeadline;

  /// Beginner panel body on Course Lab Home.
  ///
  /// In en, this message translates to:
  /// **'Hiragana, katakana, and the first grammar patterns. Short lessons you can finish in an evening.'**
  String get courseLabBeginnerBody;

  /// Advanced panel headline on Course Lab Home.
  ///
  /// In en, this message translates to:
  /// **'Polite speech, counters, and more.'**
  String get courseLabAdvancedHeadline;

  /// Advanced panel body on Course Lab Home.
  ///
  /// In en, this message translates to:
  /// **'Polite language for work, counting things, and the sound words textbooks mention once. Kana is assumed.'**
  String get courseLabAdvancedBody;

  /// Expert panel headline on Course Lab Home.
  ///
  /// In en, this message translates to:
  /// **'Past the textbook.'**
  String get courseLabExpertHeadline;

  /// Expert panel body on Course Lab Home.
  ///
  /// In en, this message translates to:
  /// **'Newspaper headlines, classical Japanese, and listening at N1 speed.'**
  String get courseLabExpertBody;

  /// Empty catalog on a Course Lab track. Not a connection error.
  ///
  /// In en, this message translates to:
  /// **'No courses in this track yet.'**
  String get courseLabEmpty;

  /// Course catalog failed to load. Names the content, not the infrastructure.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load courses. Try again later.'**
  String get courseLabLoadError;
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
