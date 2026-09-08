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
  String get navHome => 'Home';

  @override
  String get navFundamentals => 'Fundamentals';

  @override
  String get navLab => 'Lab';

  @override
  String get courseLabCardBody =>
      'Beginner, advanced, and expert tracks. Tap a link or swipe the pages.';

  @override
  String get fundamentalsCardBody =>
      'Collection reads, indexes, nested lessons, and realtime snapshots.';

  @override
  String get errorOccurred => 'Unfortunately, an error occurred.';

  @override
  String get errorNetwork =>
      'Could not reach the server. Check your connection.';

  @override
  String get errorNotFound => 'That item was not found.';

  @override
  String get errorPermission =>
      'This write is not allowed. Deploy firestore.rules (only participants on a course), then tap Increment again.';

  @override
  String get errorInvalidQuery => 'This query is not valid for Firestore.';

  @override
  String get fundamentalsDevtoolsHint =>
      'Start this lab in **Chrome**. Open **DevTools** (View → Developer → Developer Tools, or Cmd+Option+I) → **Network** → filter `firestore`. Each button below is a real Firestore read. Watch the request and the response there. The Firebase Console is for reading fields; DevTools is for seeing that a call happened.';

  @override
  String get fundamentalsReadTitle => 'Read a collection and a document';

  @override
  String get fundamentalsReadHint =>
      'A **collection** is every course, ordered by `seqNo`. A **document** is one course by id (`hiragana-from-zero`) — not the first row of the list.';

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
      'Firestore answers from **indexes**, not by scanning the collection. That is the performance guarantee: query cost stays predictable as the data grows. One **range** filter plus `orderBy` on the same field can use the automatic single-field index. Two range filters on different fields cannot. Equality on one field plus a range on another needs a **composite** index. This lab has one composite (`url` + `seqNo`) and leaves `price` + `seqNo` without one.';

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
  String get fundamentalsQueryCompositeTitle =>
      'where seqNo <= 20 and url == hiragana-from-zero';

  @override
  String get fundamentalsQueryCompositeHint =>
      'Range on seqNo plus equality on url. That pair has a composite index in firestore.indexes.json (`url` then `seqNo`). Same shape as the missing-index button, except the index exists.';

  @override
  String get fundamentalsQueryIndexTitle => 'where seqNo <= 20 and price == 15';

  @override
  String get fundamentalsQueryIndexHint =>
      'Same shape as the composite button, different field pair. There is no composite for `price` + `seqNo`. The error includes a Console URL — do not click it if you want this button to keep failing.';

  @override
  String get fundamentalsRunValidQuery => 'Run valid query';

  @override
  String get fundamentalsRunInvalidQuery => 'Run invalid query';

  @override
  String get fundamentalsRunCompositeQuery => 'Run composite-index query';

  @override
  String get fundamentalsRunIndexQuery => 'Run missing-index query';

  @override
  String get fundamentalsLessonsTitle =>
      'Nested collection vs collection group';

  @override
  String get fundamentalsLessonsHint =>
      'A **nested** query stays under one course. A **collection group** query walks every `lessons` subcollection in the project. That is how you list all lessons without knowing each course id. Rules need a recursive match on `lessons`. `orderBy seqNo` needs a `COLLECTION_GROUP` index.';

  @override
  String get fundamentalsLessonsNestedTitle =>
      'courses/hiragana-from-zero/lessons orderBy seqNo';

  @override
  String get fundamentalsLessonsNestedHint =>
      'One parent path. Automatic single-field index. Only Hiragana lessons.';

  @override
  String get fundamentalsLessonsGroupTitle =>
      'collectionGroup(\'lessons\') orderBy seqNo';

  @override
  String get fundamentalsLessonsGroupHint =>
      'Same collection id under every course. Parent is not in the path. courseId comes from the snapshot parent. CREATE the collection-group index if Firestore returns a URL — this one you do want.';

  @override
  String get fundamentalsReadNestedLessons => 'Read nested lessons';

  @override
  String get fundamentalsRunCollectionGroup => 'Run collection-group query';

  @override
  String fundamentalsLessonMeta(String courseId, int seqNo, String duration) {
    return '$courseId · seqNo $seqNo · $duration';
  }

  @override
  String get fundamentalsRealtimeTitle => 'Realtime snapshots';

  @override
  String get fundamentalsRealtimeHint =>
      'AngularFire **snapshotChanges** is Flutter `snapshots()` plus `docChanges`. `get()` is one answer. `snapshots()` stays open: the first event is every course as **added**, then **added** / **modified** / **removed**.\n\n**Increment** writes `FieldValue.increment(1)` on `hiragana-from-zero.participants` — two clients cannot overwrite each other. Change the same number in the Console; the listen updates. Rules allow only that field. Publish `firestore.rules` (Console or CLI) or increment fails.\n\nOpen **DevTools** → **Network** → filter `firestore` before you tap. **Listen** dumps the first Listen/`channel` payload (the full current list). **Increment** should add a **new** call — the write, then the live snapshot. Tiny pings while listening are keepalives, not new course dumps.';

  @override
  String get fundamentalsRealtimeListenTitle =>
      'courses orderBy seqNo — snapshots()';

  @override
  String get fundamentalsRealtimeListenHint =>
      '**Listen** opens the stream. **Stop** unsubscribes; the last list stays on screen but no longer updates. In **DevTools** → **Network** (filter `firestore`) the first **Listen** dump is the full list, not a one-shot `get()`.';

  @override
  String get fundamentalsRealtimeChangesTitle =>
      'docChanges + increment participants';

  @override
  String get fundamentalsRealtimeChangesHint =>
      'This batch of diffs, not the full history. **Increment** `hiragana-from-zero` in the app or set `participants` in the Console — both should show **modified**. Watch **Network**: **Increment** should add a new `firestore` call.';

  @override
  String get fundamentalsRealtimeListen => 'Listen';

  @override
  String get fundamentalsRealtimeStop => 'Stop';

  @override
  String get fundamentalsRealtimeIncrement => 'Increment participants';

  @override
  String get fundamentalsRealtimeIdle =>
      'Not listening. Tap Listen, then increment or edit the Console.';

  @override
  String get fundamentalsRealtimeIncrementIdle => 'Not incremented yet.';

  @override
  String get fundamentalsRealtimeChangesIdle => 'No snapshot yet.';

  @override
  String get fundamentalsChangeAdded => 'added';

  @override
  String get fundamentalsChangeModified => 'modified';

  @override
  String get fundamentalsChangeRemoved => 'removed';

  @override
  String fundamentalsRealtimeChange(
    String type,
    String description,
    int participants,
  ) {
    return '$type · $description · $participants participants';
  }

  @override
  String fundamentalsRealtimeCourseMeta(
    int seqNo,
    int lessonsCount,
    int participants,
  ) {
    return 'seqNo $seqNo · $lessonsCount lessons · $participants participants';
  }

  @override
  String get courseLab => 'Firebase Course Lab';

  @override
  String get courseLabBeginner => 'Beginner course';

  @override
  String get courseLabAdvanced => 'Advanced course';

  @override
  String get courseLabExpert => 'Expert course';

  @override
  String get courseLabBeginnerHeadline => 'Start with the kana.';

  @override
  String get courseLabBeginnerBody =>
      'Hiragana, katakana, and the first grammar patterns. Short lessons you can finish in an evening.';

  @override
  String get courseLabAdvancedHeadline => 'Keigo, kanji, and nuance.';

  @override
  String get courseLabAdvancedBody =>
      'Keigo, kanji compounds, and the courses that assume you already read kana.';

  @override
  String get courseLabExpertHeadline => 'Past the textbook.';

  @override
  String get courseLabExpertBody =>
      'Newspapers, bungo, and listening that already lives in Japanese.';
}
