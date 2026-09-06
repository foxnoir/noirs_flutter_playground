// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Firebase in Depth';

  @override
  String get retry => 'Retry';

  @override
  String get fundamentals => 'Firebase Fundamentals';

  @override
  String get missing => 'Missing';

  @override
  String get back => 'Back';

  @override
  String get errorOccurred => 'Unfortunately, an error occurred.';

  @override
  String get errorNetwork =>
      'Could not reach the server. Check your connection.';

  @override
  String get errorNotFound => 'That item was not found.';

  @override
  String get errorInvalidQuery => 'This query is not valid for Firestore.';

  @override
  String get fundamentalsDevtoolsHint =>
      'Start this lab in Chrome. Open DevTools (View → Developer → Developer Tools, or Cmd+Option+I) → Network → filter firestore. Each button below is a real Firestore read. Watch the request and the response there. The Firebase Console is for reading fields; DevTools is for seeing that a call happened.';

  @override
  String get fundamentalsReadTitle => 'Read a document and a collection';

  @override
  String get fundamentalsReadHint =>
      'A document is one course (hiragana-from-zero). A collection is every course, ordered by seqNo.';

  @override
  String get fundamentalsReadDocument => 'Read document';

  @override
  String get fundamentalsReadCollection => 'Read collection';

  @override
  String get fundamentalsIdle =>
      'Not run yet. Open DevTools first, then tap a button.';

  @override
  String get fundamentalsEmpty => 'No documents matched.';

  @override
  String fundamentalsCourseMeta(int seqNo, int lessonsCount) {
    return 'seqNo $seqNo · $lessonsCount lessons';
  }

  @override
  String get fundamentalsQueryTitle => 'Performance guarantees and indexes';

  @override
  String get fundamentalsQueryHint =>
      'Firestore answers from indexes, not by scanning the collection. That is the performance guarantee: query cost stays predictable as the data grows. One range filter plus orderBy on the same field can use the automatic single-field index. Two range filters on different fields cannot. Equality on one field plus a range on another needs a composite index — Firestore answers with a Console URL. This lab does not create that index.';

  @override
  String get fundamentalsQueryValidTitle => 'where seqNo <= 5, orderBy seqNo';

  @override
  String get fundamentalsQueryValidHint =>
      'Inequality and orderBy on the same field. Firestore walks one index. This is the query that works.';

  @override
  String get fundamentalsQueryInvalidTitle =>
      'where seqNo <= 5 and lessonsCount <= 10';

  @override
  String get fundamentalsQueryInvalidHint =>
      'Two inequalities on different fields. The Angular sample failed with: all inequality filters must be on the same field. Run it and read the FirebaseError here and in DevTools.';

  @override
  String get fundamentalsQueryIndexTitle =>
      'where seqNo <= 20 and url == hiragana-from-zero';

  @override
  String get fundamentalsQueryIndexHint =>
      'Range on seqNo plus equality on url. Firestore has no composite index for that pair. The error includes a Console URL to create one — do not click it if you want this button to keep failing.';

  @override
  String get fundamentalsRunValidQuery => 'Run valid query';

  @override
  String get fundamentalsRunInvalidQuery => 'Run invalid query';

  @override
  String get fundamentalsRunIndexQuery => 'Run missing-index query';
}
