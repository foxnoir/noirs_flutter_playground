// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Advanced Concepts';

  @override
  String get landing => 'Landing Screen';

  @override
  String get navigation => 'Navigation';

  @override
  String get routing => 'Routing Lab';

  @override
  String get userList => 'Userliste';

  @override
  String get userDetails => 'Userdetails';

  @override
  String get nickname => 'Spitzname';

  @override
  String get email => 'E-Mail';

  @override
  String get age => 'Alter';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get missing => 'Fehlt';

  @override
  String get back => 'Zurück';

  @override
  String get goToLanding => 'Zum Landing Screen';

  @override
  String get errorOccurred => 'Es ist leider ein Fehler aufgetreten.';

  @override
  String get errorNetwork =>
      'Der Server ist nicht erreichbar. Prüfe die Verbindung.';

  @override
  String get errorNotFound => 'Dieser User wurde nicht gefunden.';

  @override
  String get routingNeedBack => 'Need Back';

  @override
  String get routingNeedBackCalls => 'push / pushNamed';

  @override
  String get routingNeedBackHint =>
      'Userliste → Userdetails. Zurück kommt zur Liste.';

  @override
  String get routingNoReturn => 'No return';

  @override
  String get routingNoReturnCalls => 'go / goNamed';

  @override
  String get routingNoReturnHint => 'Leert den Stack. Sprung von überall.';

  @override
  String get routingPopWhen => 'Back one screen';

  @override
  String get routingPopCalls => 'pop';

  @override
  String get routingPopHint => 'Nur wenn canPop(). Nach push ja. Nach go nein.';

  @override
  String get routingReplaceWhen => 'Swap this screen';

  @override
  String get routingReplaceCalls => 'replace / replaceNamed';

  @override
  String get routingReplaceHint =>
      'Dieser Screen ist weg. Der Stack darunter nicht. Pop überspringt ihn. Login → Home. Falsch für Liste → Details.';

  @override
  String get routingNamedWhen => 'Named';

  @override
  String get routingNamedCalls => 'immer, im App-Code';

  @override
  String get routingNamedHint =>
      'Nicht wegen Zurück. Geht mit push, go, replace. Der Pfad (`/user-list`) ist die URL.';

  @override
  String get routingContext =>
      '**context.go** ist **GoRouter.of(context).go** — derselbe Router, über **BuildContext**. Ein **Notifier** hat keinen Context, also liest er **goRouterProvider**.';

  @override
  String get navGoCaption => 'Leert den Stack.';

  @override
  String get navGoNamedCaption => 'Wie go, per Routenname.';

  @override
  String get navPushCaption => 'Legt oben drauf. Zurück geht.';

  @override
  String get navPushNamedCaption => 'Wie push, per Routenname.';

  @override
  String get navGoViaRouterCaption => 'Wie go, aus Riverpod.';

  @override
  String get navPushNamedViaRouterCaption => 'Wie pushNamed, aus Riverpod.';

  @override
  String get navPopCaption => 'Einen Screen zurück. Braucht canPop().';

  @override
  String get navReplaceNamedCaption =>
      'Tauscht diesen Screen. Pop geht zum Landing Screen.';

  @override
  String get navStackTitle => 'Stack';

  @override
  String get stackYouAreHere => 'du bist hier';

  @override
  String get stackRoutingReplaced =>
      'go hat Routing Lab geleert — nichts zu poppen.';

  @override
  String get stackReplaceKeptLanding =>
      'replace hat Routing Lab getauscht. Zurück geht zum Landing Screen.';

  @override
  String get openedWith => 'Geöffnet mit';

  @override
  String get userListOpenDetails => 'Jede Zeile ruft auf:';

  @override
  String get userListPopCaptionCan => 'Zurück zum Routing Lab.';

  @override
  String get userListPopCaptionCannot => 'canPop() ist false. Poppt nicht.';

  @override
  String get userListCanPopTrue => 'pop / Zurück kommt zum Routing Lab.';

  @override
  String get userListCanPopReplace => 'pop / Zurück kommt zum Landing Screen.';

  @override
  String get userListCanPopFalse => 'canPop() ist false. pop geht nicht.';
}
