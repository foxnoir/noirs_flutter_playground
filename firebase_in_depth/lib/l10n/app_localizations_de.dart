// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get title => 'Firebase in Depth';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get fundamentals => 'Firebase-Grundlagen';

  @override
  String get missing => 'Fehlt';

  @override
  String get back => 'Zurück';

  @override
  String get errorOccurred => 'Es ist leider ein Fehler aufgetreten.';

  @override
  String get errorNetwork =>
      'Der Server ist nicht erreichbar. Prüfe die Verbindung.';

  @override
  String get errorNotFound => 'Dieser Eintrag wurde nicht gefunden.';

  @override
  String get errorPermission =>
      'Dieser Write ist nicht erlaubt. Deploy firestore.rules (nur participants auf einem Kurs), dann Increment erneut.';

  @override
  String get errorInvalidQuery =>
      'Diese Abfrage ist für Firestore nicht gültig.';

  @override
  String get fundamentalsDevtoolsHint =>
      'Starte dieses Lab in **Chrome**. Öffne die **DevTools** (Ansicht → Entwickler → Entwicklertools, oder Cmd+Option+I) → **Network** → Filter `firestore`. Jeder Button unten ist ein echter Firestore-Read. Schau dir Request und Response dort an. Die Firebase Console ist zum Lesen der Felder; DevTools zeigt, dass ein Call passiert ist.';

  @override
  String get fundamentalsReadTitle => 'Collection und Dokument lesen';

  @override
  String get fundamentalsReadHint =>
      'Eine **Collection** sind alle Kurse, sortiert nach `seqNo`. Ein **Dokument** ist ein Kurs per id (`hiragana-from-zero`) — nicht die erste Zeile der Liste.';

  @override
  String get fundamentalsReadDocument => 'Dokument lesen';

  @override
  String get fundamentalsReadCollection => 'Collection lesen';

  @override
  String get fundamentalsIdle =>
      'Noch nicht ausgeführt. Erst DevTools öffnen, dann einen Button tippen.';

  @override
  String get fundamentalsEmpty => 'Keine Dokumente gefunden.';

  @override
  String fundamentalsCourseMeta(int seqNo, int lessonsCount) {
    return 'seqNo $seqNo · $lessonsCount Lektionen';
  }

  @override
  String get fundamentalsQueryTitle => 'Performance-Garantien und Indexes';

  @override
  String get fundamentalsQueryHint =>
      'Firestore antwortet aus **Indexes**, nicht durch Scannen der Collection. Das ist die Performance-Garantie: die Query-Kosten bleiben vorhersagbar, wenn die Daten wachsen. Ein **Range**-Filter plus `orderBy` auf demselben Feld nutzt den automatischen Single-Field-Index. Zwei Range-Filter auf verschiedenen Feldern können das nicht. Gleichheit auf einem Feld plus Range auf einem anderen braucht einen **Composite** Index. Dieses Lab hat einen Composite (`url` + `seqNo`) und lässt `price` + `seqNo` ohne.';

  @override
  String get fundamentalsQueryValidTitle => 'where seqNo <= 5, orderBy seqNo';

  @override
  String get fundamentalsQueryValidHint =>
      'Inequality und orderBy auf demselben Feld. Firestore läuft einen Index ab. Das ist die Query, die funktioniert.';

  @override
  String get fundamentalsQueryInvalidTitle =>
      'where seqNo <= 5 and lessonsCount <= 10';

  @override
  String get fundamentalsQueryInvalidHint =>
      'Zwei Inequalities auf verschiedenen Feldern. Das Angular-Beispiel scheiterte mit: alle Inequality-Filter müssen auf demselben Feld liegen. Ausführen und den FirebaseError hier und in den DevTools lesen.';

  @override
  String get fundamentalsQueryCompositeTitle =>
      'where seqNo <= 20 and url == hiragana-from-zero';

  @override
  String get fundamentalsQueryCompositeHint =>
      'Range auf seqNo plus Gleichheit auf url. Für dieses Paar steht ein Composite in firestore.indexes.json (`url` dann `seqNo`). Gleiche Form wie der Missing-Index-Button, nur dass der Index existiert.';

  @override
  String get fundamentalsQueryIndexTitle => 'where seqNo <= 20 and price == 15';

  @override
  String get fundamentalsQueryIndexHint =>
      'Gleiche Form wie der Composite-Button, anderes Feldpaar. Für `price` + `seqNo` gibt es keinen Composite. Der Fehler enthält eine Console-URL — nicht klicken, wenn der Button weiter scheitern soll.';

  @override
  String get fundamentalsRunValidQuery => 'Gültige Query ausführen';

  @override
  String get fundamentalsRunInvalidQuery => 'Ungültige Query ausführen';

  @override
  String get fundamentalsRunCompositeQuery => 'Composite-Index-Query ausführen';

  @override
  String get fundamentalsRunIndexQuery => 'Missing-Index-Query ausführen';

  @override
  String get fundamentalsLessonsTitle =>
      'Nested Collection vs Collection Group';

  @override
  String get fundamentalsLessonsHint =>
      'Eine **nested** Query bleibt unter einem Kurs. Eine **Collection-Group**-Query läuft jede `lessons`-Subcollection im Projekt ab. So listest du alle Lektionen, ohne jede Kurs-id zu kennen. Rules brauchen ein rekursives Match auf `lessons`. `orderBy seqNo` braucht einen `COLLECTION_GROUP`-Index.';

  @override
  String get fundamentalsLessonsNestedTitle =>
      'courses/hiragana-from-zero/lessons orderBy seqNo';

  @override
  String get fundamentalsLessonsNestedHint =>
      'Ein Parent-Pfad. Automatischer Single-Field-Index. Nur Hiragana-Lektionen.';

  @override
  String get fundamentalsLessonsGroupTitle =>
      'collectionGroup(\'lessons\') orderBy seqNo';

  @override
  String get fundamentalsLessonsGroupHint =>
      'Dieselbe Collection-id unter jedem Kurs. Der Parent steht nicht im Query-Pfad. courseId kommt vom Snapshot-Parent. CREATE den Collection-Group-Index, wenn Firestore eine URL liefert — diesen Index willst du.';

  @override
  String get fundamentalsReadNestedLessons => 'Nested Lessons lesen';

  @override
  String get fundamentalsRunCollectionGroup =>
      'Collection-Group-Query ausführen';

  @override
  String fundamentalsLessonMeta(String courseId, int seqNo, String duration) {
    return '$courseId · seqNo $seqNo · $duration';
  }

  @override
  String get fundamentalsRealtimeTitle => 'Realtime Snapshots';

  @override
  String get fundamentalsRealtimeHint =>
      'AngularFire **snapshotChanges** ist in Flutter `snapshots()` plus `docChanges`. `get()` ist eine Antwort. `snapshots()` bleibt offen: das erste Event sind alle Kurse als **added**, danach **added** / **modified** / **removed**.\n\n**Increment** schreibt `FieldValue.increment(1)` auf `hiragana-from-zero.participants` — zwei Clients überschreiben sich nicht. Dieselbe Zahl in der Console ändern; der Listen aktualisiert. Rules erlauben nur dieses Feld. `firestore.rules` publishen (Console oder CLI), sonst scheitert Increment.\n\n**DevTools** → **Network** → Filter `firestore` öffnen, bevor du tippst. **Listen** liefert den ersten Listen/`channel`-Payload (die volle aktuelle Liste). **Increment** sollte einen **neuen** Call bringen — den Write, dann den Live-Snapshot. Kleine Pings während des Listen sind Keepalives, keine neuen Kurs-Dumps.';

  @override
  String get fundamentalsRealtimeListenTitle =>
      'courses orderBy seqNo — snapshots()';

  @override
  String get fundamentalsRealtimeListenHint =>
      '**Listen** öffnet den Stream. **Stop** kündigt ab; die letzte Liste bleibt stehen, aktualisiert aber nicht mehr. In **DevTools** → **Network** (Filter `firestore`) ist der erste **Listen**-Dump die volle Liste, kein einmaliges `get()`.';

  @override
  String get fundamentalsRealtimeChangesTitle =>
      'docChanges + increment participants';

  @override
  String get fundamentalsRealtimeChangesHint =>
      'Dieser Diff-Batch, nicht die ganze History. **Increment** auf `hiragana-from-zero` in der App oder `participants` in der Console setzen — beides sollte **modified** zeigen. **Network** beobachten: **Increment** sollte einen neuen `firestore`-Call bringen.';

  @override
  String get fundamentalsRealtimeListen => 'Listen';

  @override
  String get fundamentalsRealtimeStop => 'Stop';

  @override
  String get fundamentalsRealtimeIncrement => 'Teilnehmer +1';

  @override
  String get fundamentalsRealtimeIdle =>
      'Kein Listen. Listen tippen, dann Increment oder in der Console ändern.';

  @override
  String get fundamentalsRealtimeIncrementIdle => 'Noch nicht erhöht.';

  @override
  String get fundamentalsRealtimeChangesIdle => 'Noch kein Snapshot.';

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
    return '$type · $description · $participants Teilnehmer';
  }

  @override
  String fundamentalsRealtimeCourseMeta(
    int seqNo,
    int lessonsCount,
    int participants,
  ) {
    return 'seqNo $seqNo · $lessonsCount Lektionen · $participants Teilnehmer';
  }
}
