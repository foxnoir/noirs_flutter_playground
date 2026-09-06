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
  String get errorInvalidQuery =>
      'Diese Abfrage ist für Firestore nicht gültig.';

  @override
  String get fundamentalsDevtoolsHint =>
      'Starte dieses Lab in Chrome. Öffne die DevTools (Ansicht → Entwickler → Entwicklertools, oder Cmd+Option+I) → Network → Filter firestore. Jeder Button unten ist ein echter Firestore-Read. Schau dir Request und Response dort an. Die Firebase Console ist zum Lesen der Felder; DevTools zeigt, dass ein Call passiert ist.';

  @override
  String get fundamentalsReadTitle => 'Dokument und Collection lesen';

  @override
  String get fundamentalsReadHint =>
      'Ein Dokument ist ein Kurs (hiragana-from-zero). Eine Collection sind alle Kurse, sortiert nach seqNo.';

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
      'Firestore antwortet aus Indexes, nicht durch Scannen der Collection. Das ist die Performance-Garantie: die Query-Kosten bleiben vorhersagbar, wenn die Daten wachsen. Ein Range-Filter plus orderBy auf demselben Feld nutzt den automatischen Single-Field-Index. Zwei Range-Filter auf verschiedenen Feldern können das nicht. Gleichheit auf einem Feld plus Range auf einem anderen braucht einen Composite Index — Firestore antwortet mit einer Console-URL. Dieses Lab legt den Index nicht an.';

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
  String get fundamentalsQueryIndexTitle =>
      'where seqNo <= 20 and url == hiragana-from-zero';

  @override
  String get fundamentalsQueryIndexHint =>
      'Range auf seqNo plus Gleichheit auf url. Dafür gibt es keinen Composite Index. Der Fehler enthält eine Console-URL zum Anlegen — nicht klicken, wenn der Button weiter scheitern soll.';

  @override
  String get fundamentalsRunValidQuery => 'Gültige Query ausführen';

  @override
  String get fundamentalsRunInvalidQuery => 'Ungültige Query ausführen';

  @override
  String get fundamentalsRunIndexQuery => 'Missing-Index-Query ausführen';
}
