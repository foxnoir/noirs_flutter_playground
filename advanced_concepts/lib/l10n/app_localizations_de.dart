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
  String get bookDetails => 'Buchdetails';

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

  @override
  String get lists => 'Lists';

  @override
  String get listsOneAxis => 'Eine Spalte';

  @override
  String get listsOneAxisCalls => 'ListView.builder';

  @override
  String get listsOneAxisHint => 'Lazy. Lange vertikale Listen.';

  @override
  String get listsRow => 'Eine Reihe';

  @override
  String get listsRowCalls => 'Axis.horizontal';

  @override
  String get listsRowHint =>
      'Dasselbe lazy ListView. Cross-Axis ist die Höhe. Braucht eine Max-Breite — keine Row ohne Expanded.';

  @override
  String get listsGrid => 'Gleich große Kacheln';

  @override
  String get listsGridCalls => 'GridView.builder';

  @override
  String get listsGridHint =>
      'Lazy. Ein Raster, keine Tabelle mit gemischten Spans.';

  @override
  String get listsSliver => 'Ein Scroll, gemischte Teile';

  @override
  String get listsSliverCalls => 'CustomScrollView + slivers';

  @override
  String get listsSliverHint =>
      'Header + Grid + Liste teilen sich eine Scrollbar.';

  @override
  String get listsEagerWhen => 'Wenige, bekannte Kinder';

  @override
  String get listsEagerCalls => 'ListView(children:)';

  @override
  String get listsEagerHint =>
      'Baut jedes Kind sofort. Okay für ~10. Falsch für Hunderte.';

  @override
  String get listsContext =>
      '**ListView** und **GridView** sind Boxen mit eigenem Scroll. Ein **Sliver** ist ein Stück in **CustomScrollView**. Lieber **.builder**. Kein vertikales ListView in einer Column ohne **Expanded** oder Höhe. Dieselbe Falle seitwärts: horizontales ListView in einer Row.';

  @override
  String get listsKindList => 'ListView';

  @override
  String get listsKindGrid => 'GridView';

  @override
  String get listsKindSliver => 'Sliver';

  @override
  String get listsKindHorizontal => 'Horizontal';

  @override
  String get listsCells => 'Zellen';

  @override
  String get listsBuilds => 'Builds';

  @override
  String get listsDemoHint =>
      'Scroll den Kasten. Zellen bleiben ≤ 48. Weg und zurück: Off-Screen-Kinder werden disposed — Builds steigen, Zellen nicht.';

  @override
  String get listsCallList => 'ListView.builder(itemBuilder: …)';

  @override
  String get listsCallGrid => 'GridView.builder(gridDelegate: …)';

  @override
  String get listsCallSliver =>
      'CustomScrollView(slivers: [SliverGrid, SliverList])';

  @override
  String get listsCallHorizontal =>
      'ListView.builder(scrollDirection: Axis.horizontal, …)';

  @override
  String get listsSliverHeader => 'SliverToBoxAdapter';

  @override
  String get listsProblemEagerTitle => 'Eager vs lazy';

  @override
  String get listsProblemEagerCaption =>
      'children: alle Zellen sofort. .builder: Viewport plus Cache. Zurückscrollen: Zellen bleiben, Builds steigen.';

  @override
  String get listsProblemEagerLabel => 'ListView(children:)';

  @override
  String get listsProblemLazyLabel => 'ListView.builder';

  @override
  String get listsProblemUnboundedTitle => 'Unbounded height';

  @override
  String get listsProblemUnboundedCaption =>
      'Wrong sieht aus wie ein Crash. Works ist eine Liste, die du scrollen kannst. Gleicher Header, andere Constraints.';

  @override
  String get listsProblemUnboundedBadTitle => 'wrong  ·  Column + ListView';

  @override
  String get listsProblemUnboundedBadHint =>
      'Column gibt dem ListView unendliche Max-Höhe. Debug zeigt diese Assertion. Das Lab malt die Streifen, damit die Seite stehen bleibt.';

  @override
  String get listsProblemUnboundedGoodTitle =>
      'works  ·  Column + Expanded + ListView';

  @override
  String get listsProblemUnboundedGoodHint =>
      'Expanded nimmt den Rest. ListView bekommt ein Max. Scroll es.';

  @override
  String get listsStripeUnbounded =>
      'Vertical viewport was given unbounded height.';

  @override
  String get listsLayerHeader => 'header';

  @override
  String get listsProblemShrinkTitle => 'shrinkWrap + nested scroll';

  @override
  String get listsProblemShrinkBody =>
      'shrinkWrap: true misst die Liste, indem jedes Kind gelegt wird. Verschachtelte ListViews brauchen das oft — das ist teuer. Lieber ein CustomScrollView aus Slivers.';

  @override
  String get layout => 'Layout';

  @override
  String get layoutMayShrink => 'Kind darf schrumpfen';

  @override
  String get layoutMayShrinkCalls => 'Flexible';

  @override
  String get layoutMayShrinkHint =>
      'Restplatz in Row oder Column. min = 0. Das Kind darf klein bleiben.';

  @override
  String get layoutMustFill => 'Kind muss füllen';

  @override
  String get layoutMustFillCalls => 'Expanded';

  @override
  String get layoutMustFillHint =>
      'Derselbe Restplatz. min = max. Expanded ist Flexible(fit: FlexFit.tight).';

  @override
  String get layoutPreferredWhen => 'Scaffold-Slot-Höhe';

  @override
  String get layoutPreferredCalls => 'PreferredSize / AppBar';

  @override
  String get layoutPreferredHint =>
      'appBar und bottomNavigationBar wollen PreferredSizeWidget. Kein Flex-Kind.';

  @override
  String get layoutContext =>
      '**Expanded** ist **Flexible(fit: FlexFit.tight)**. **Flexible** ist **loose** — Restplatz darf leer bleiben. **PreferredSize** sagt **Scaffold**, wie hoch **appBar** sein will. **MediaQuery.sizeOf** ist das Fenster. **LayoutBuilder** ist der Parent. **AppBreakpoint** ist compact bis **600** — mobile first, jedes Layout. **Row-Overflow** sind die gelb-schwarzen Streifen; **Expanded** teilt den Rest, damit die Kinder passen.';

  @override
  String get layoutWindowWhen => 'Fenstergröße';

  @override
  String get layoutWindowCalls => 'MediaQuery.sizeOf';

  @override
  String get layoutWindowHint =>
      'Das App-Fenster. Chrome skalieren. Nicht kIsWeb.';

  @override
  String get layoutBuilderWhen => 'Eltern-Platz';

  @override
  String get layoutBuilderCalls => 'LayoutBuilder';

  @override
  String get layoutBuilderHint =>
      'Der Parent. Eine 120-breite Box ist nicht das Fenster.';

  @override
  String get layoutMobileFirstWhen => 'Default-Layout';

  @override
  String get layoutMobileFirstCalls => 'compact, dann ≥ 600';

  @override
  String get layoutMobileFirstRuleHint =>
      'Überall mobile first. AppBreakpoint im Theme — kein AdaptiveScaffold.';

  @override
  String get layoutSizeCompact => 'compact';

  @override
  String get layoutSizeMedium => 'medium';

  @override
  String get layoutSizeExpanded => 'expanded';

  @override
  String get layoutSizeLarge => 'large';

  @override
  String get layoutSizeExtraLarge => 'extra-large';

  @override
  String get layoutBreakpointTitle => 'Breakpoints';

  @override
  String get layoutBreakpointHint =>
      'Breakpoints sind Zahlen in AppBreakpoint. MediaQuery jumpt nicht — sie meldet nur das Fenster. Diese Column/Row jumpt bei 600 vom Parent. Striche: 600, 840, 1200, 1600.';

  @override
  String get layoutBreakpointCall =>
      'if (AppBreakpoint.fromWidth(parentWidth).isCompact) Column else Row';

  @override
  String layoutBreakpointChip(int width, String name) {
    return 'parent $width  ·  $name';
  }

  @override
  String layoutBreakpointWindowChip(int width, String name) {
    return 'window $width  ·  $name';
  }

  @override
  String get layoutBuilderTitle => 'LayoutBuilder vs MediaQuery';

  @override
  String get layoutBuilderWrongTitle =>
      'wrong  ·  child width = MediaQuery.sizeOf';

  @override
  String get layoutBuilderWrongHint =>
      'Der Parent ist 120. MediaQuery.sizeOf ist das Fenster. Dieselben gelb-schwarzen Streifen wie beim Row-Overflow.';

  @override
  String get layoutBuilderRightTitle => 'works  ·  child width = LayoutBuilder';

  @override
  String get layoutBuilderRightHint =>
      'LayoutBuilder.maxWidth ist 120. Das Kind ist 120. Keine Streifen.';

  @override
  String get layoutBuilderCallWrong =>
      'SizedBox(width: MediaQuery.sizeOf(context).width)';

  @override
  String get layoutBuilderCallRight => 'SizedBox(width: constraints.maxWidth)';

  @override
  String layoutBuilderPaneChip(int parent, int child) {
    return 'parent $parent  ·  child $child';
  }

  @override
  String layoutBuilderStripe(int pixels) {
    return 'RIGHT OVERFLOWED BY $pixels PIXELS';
  }

  @override
  String get layoutOverflowTitle => 'Row overflow';

  @override
  String get layoutOverflowWrongTitle => 'wrong  ·  Row + lange Kinder';

  @override
  String get layoutOverflowWrongHint =>
      'Die Kinder wollen mehr Breite als die Row. Flutter malt gelb-schwarze Streifen am Rand.';

  @override
  String get layoutOverflowRightTitle => 'works  ·  Row + Expanded';

  @override
  String get layoutOverflowRightHint =>
      'Jedes Expanded bekommt ein Stück. Text wird ellipsisiert. Keine Streifen.';

  @override
  String get layoutOverflowStripe => 'RIGHT OVERFLOWED BY 87 PIXELS';

  @override
  String get layoutOverflowCallWrong => 'Row(children: [Text, Text, Text, …])';

  @override
  String get layoutOverflowCallRight =>
      'Row(children: [Expanded(child: Text(…, overflow: ellipsis))])';

  @override
  String get layoutFlexTitle => 'Flexible vs Expanded';

  @override
  String get layoutFlexFlexibleLabel => 'Flexible';

  @override
  String get layoutFlexExpandedLabel => 'Expanded';

  @override
  String get layoutFlexChild => 'Hi';

  @override
  String get layoutFlexEnd => '64';

  @override
  String get layoutFlexLeftover => 'leftover';

  @override
  String get layoutFlexFlexibleHint =>
      'leftover bleibt leer. Hi bleibt so breit wie der Text.';

  @override
  String get layoutFlexExpandedHint => 'Kein leftover. Hi muss füllen.';

  @override
  String get layoutFlexCallFlexible => 'Flexible(child: …)  // FlexFit.loose';

  @override
  String get layoutFlexCallExpanded =>
      'Expanded(child: …)  // Flexible(fit: FlexFit.tight)';

  @override
  String get layoutPreferredTitle => 'PreferredSize';

  @override
  String get layoutPreferredAppBar => 'AppBar';

  @override
  String get layoutPreferredCustom => 'PreferredSize 96';

  @override
  String get layoutPreferredBody => 'body';

  @override
  String get layoutPreferredAppBarHint =>
      'AppBar implementiert PreferredSizeWidget. Höhe ist die Toolbar (56), wenn primary false ist.';

  @override
  String get layoutPreferredCustomHint =>
      'Scaffold.appBar nutzt preferredSize.height. Das Kind muss keine AppBar sein.';

  @override
  String get layoutPreferredCallAppBar => 'AppBar()  // PreferredSizeWidget';

  @override
  String get layoutPreferredCallCustom =>
      'PreferredSize(preferredSize: Size.fromHeight(96), child: …)';

  @override
  String get errorTimeout => 'Der Server hat zu lange gebraucht.';

  @override
  String get errorUnauthorized => 'Diese Anfrage war nicht erlaubt.';

  @override
  String get errorServer =>
      'Der Server ist fehlgeschlagen. Versuch es nochmal.';

  @override
  String get apiHandling => 'API Handling';

  @override
  String get apiGeneral => 'General';

  @override
  String get apiHttp => 'Example HTTP';

  @override
  String get apiDio => 'Example Dio';

  @override
  String get apiCrudWhen => 'Vier Verben für eine Ressource';

  @override
  String get apiCrudCalls => 'CRUD';

  @override
  String get apiCrudHint =>
      'Create POST, Read GET, Update PUT, Delete DELETE. GET /books listet. POST /books legt an. PUT /books/:id ändert. DELETE /books/:id löscht.';

  @override
  String get apiInterceptorWhen => 'Dieselbe Arbeit bei jedem Request';

  @override
  String get apiInterceptorCalls => 'Interceptor (Dio)';

  @override
  String get apiInterceptorHint =>
      'Dio läuft onRequest, onResponse und onError vor der Data Source. package:http hat keine Interceptors — ApiClient mappt Timeout und Status in _send.';

  @override
  String get apiUnifiedWhen => 'Jeder HTTP-Call';

  @override
  String get apiUnifiedCalls => 'eine Client-Klasse';

  @override
  String get apiUnifiedHint =>
      'Timeout, 401, 404, 500 und Verbindungsfehler liegen in einer Klasse. Die Data Source parst nur JSON.';

  @override
  String get apiTimeoutWhen => 'Server ist langsam';

  @override
  String get apiTimeoutCalls => '.timeout';

  @override
  String get apiTimeoutHint =>
      'Der Client gibt auf. GET /timeout auf dem Firebase-Emulator wartet 2s. Nicht durchwarten.';

  @override
  String get apiNetworkWhen => 'Kein Body zum Parsen';

  @override
  String get apiNetworkCalls => 'status → AppException';

  @override
  String get apiNetworkHint =>
      '500 ist ServerFailure. 401 ist UnauthorizedFailure. DNS / Socket ist NetworkFailure. Nie e.toString() zeigen.';

  @override
  String get apiContext =>
      '**CRUD** sind die vier HTTP-Verben für eine Ressource. Eine **Unified API Class** mappt Timeout und Status einmal. **Interceptors** sind Dios Pipeline dafür (und für Logs). **Example HTTP** nutzt **package:http**. **Example Dio** nutzt **Dio**. Dasselbe Firebase-Backend. Hier keine Live-Calls.';

  @override
  String get apiUnifiedTitle => 'Unified API class';

  @override
  String get apiUnifiedWrongTitle => 'wrong  ·  statusCode in der Data Source';

  @override
  String get apiUnifiedWrongHint =>
      'Jede Methode wiederholt if (statusCode == 401). Timeout fehlt. Fehlerstrings sickern in die Data-Schicht.';

  @override
  String get apiUnifiedRightTitle => 'works  ·  ApiClient.send';

  @override
  String get apiUnifiedRightHint =>
      'GET /books und GET /success teilen dasselbe Mapping. JSON bleibt gewrappt (books / data).';

  @override
  String get apiUnifiedCallWrong =>
      'if (response.statusCode == 200) BookModel.fromJson(json)';

  @override
  String get apiUnifiedCallRight =>
      'ApiClient.get(\'/books\', parse)  // throws AppException';

  @override
  String get apiTimeoutTitle => 'Timeout';

  @override
  String get apiTimeoutWrongTitle => 'wrong  ·  kein Client-Timeout';

  @override
  String get apiTimeoutWrongHint =>
      'GET /timeout wartet die volle Delay. Ohne Client-Timeout wartet die UI, bis der Server antwortet.';

  @override
  String get apiTimeoutRightTitle => 'works  ·  ApiClient.timeout';

  @override
  String get apiTimeoutRightHint =>
      'Derselbe Pfad. Der Client bricht zuerst ab. TimeoutFailure → ErrorWidget.';

  @override
  String get apiTimeoutCallWrong => 'send(request)  // waits forever';

  @override
  String get apiTimeoutCallRight =>
      'send(request).timeout(Duration(milliseconds: 400))';

  @override
  String get apiNetworkTitle => 'Network errors';

  @override
  String get apiNetworkWrongTitle => 'wrong  ·  catch (e) => e.toString()';

  @override
  String get apiNetworkWrongHint =>
      'Die UI zeigt einen Socket-Dump. 401 und 500 sehen gleich aus.';

  @override
  String get apiNetworkRightTitle => 'works  ·  Mapping in ApiClient';

  @override
  String get apiNetworkRightHint =>
      '500, 401 und offline bekommen je ein typisiertes Failure und eine lokalisierte Zeile.';

  @override
  String get apiNetworkCallWrong => 'catch (e) => Text(e.toString())';

  @override
  String get apiNetworkCallRight =>
      '401 → UnauthorizedException  ·  500 → ServerException  ·  catch → NetworkException';

  @override
  String get apiDioScenarioBooks => 'Regal';

  @override
  String get apiDioScenarioUnstable => 'Instabil';

  @override
  String get apiDioScenarioTimeout => 'Langsam';

  @override
  String get apiDioScenarioOffline => 'Offline';

  @override
  String get apiDioScenarioServer => 'Serverfehler';

  @override
  String get apiDioUnstableHint =>
      'Jeder dritte Tipp auf Instabil schlägt fehl. Retry lädt das Regal.';

  @override
  String get apiDioSearch => 'Suchen';

  @override
  String get apiDioSearchTitleLabel => 'Titel';

  @override
  String get apiDioSearchAuthorLabel => 'Autorin';

  @override
  String get apiDioSearchSubmit => 'Suchen';

  @override
  String apiDioSearchFound(String title) {
    return 'POST /search · $title';
  }

  @override
  String get apiDioEmpty => 'Keine Bücher in diesem Regal.';

  @override
  String get apiDioNotStarted => 'Nicht begonnen';

  @override
  String get apiDioFinished => 'Gelesen';

  @override
  String get apiDioReading => 'Am Lesen';

  @override
  String get apiDioAdd => 'Buch hinzufügen';

  @override
  String get apiDioEdit => 'Bearbeiten';

  @override
  String get apiDioSave => 'Speichern';

  @override
  String get apiDioDelete => 'Löschen';

  @override
  String apiDioConfirmDelete(String title) {
    return '$title löschen?';
  }

  @override
  String get apiDioSnackGetBooks => 'GET /books';

  @override
  String apiDioSnackAdded(String title) {
    return 'POST /books · $title';
  }

  @override
  String apiDioSnackUpdated(String title) {
    return 'PUT /books · $title';
  }

  @override
  String apiDioSnackDeleted(String title) {
    return 'DELETE /books · $title';
  }
}
