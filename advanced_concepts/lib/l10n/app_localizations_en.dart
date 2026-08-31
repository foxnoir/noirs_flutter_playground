// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Advanced Concepts';

  @override
  String get landing => 'Landing Screen';

  @override
  String get navigation => 'Navigation';

  @override
  String get routing => 'Routing Lab';

  @override
  String get userList => 'User List';

  @override
  String get userDetails => 'User Details';

  @override
  String get nickname => 'Nickname';

  @override
  String get email => 'Email';

  @override
  String get age => 'Age';

  @override
  String get retry => 'Retry';

  @override
  String get missing => 'Missing';

  @override
  String get back => 'Back';

  @override
  String get goToLanding => 'Go to Landing Screen';

  @override
  String get errorOccurred => 'Unfortunately, an error occurred.';

  @override
  String get errorNetwork =>
      'Could not reach the server. Check your connection.';

  @override
  String get errorNotFound => 'That user was not found.';

  @override
  String get routingNeedBack => 'Need Back';

  @override
  String get routingNeedBackCalls => 'push / pushNamed';

  @override
  String get routingNeedBackHint =>
      'User List → User Details. Back returns to the list.';

  @override
  String get routingNoReturn => 'No return';

  @override
  String get routingNoReturnCalls => 'go / goNamed';

  @override
  String get routingNoReturnHint => 'Wipes the stack. Jump from anywhere.';

  @override
  String get routingPopWhen => 'Back one screen';

  @override
  String get routingPopCalls => 'pop';

  @override
  String get routingPopHint =>
      'Only if canPop(). After push, yes. After go, no.';

  @override
  String get routingReplaceWhen => 'Swap this screen';

  @override
  String get routingReplaceCalls => 'replace / replaceNamed';

  @override
  String get routingReplaceHint =>
      'This screen is gone. The stack below is not. Pop skips this screen. Login → home. Wrong for List → Details.';

  @override
  String get routingNamedWhen => 'Named';

  @override
  String get routingNamedCalls => 'always, in app code';

  @override
  String get routingNamedHint =>
      'Not about Back. Combines with push, go, replace. Path (`/user-list`) is the URL.';

  @override
  String get routingContext =>
      '**context.go** is **GoRouter.of(context).go** — same router, via **BuildContext**. A **Notifier** has no context, so it reads **goRouterProvider**.';

  @override
  String get navGoCaption => 'Wipes the stack.';

  @override
  String get navGoNamedCaption => 'Same as go, by route name.';

  @override
  String get navPushCaption => 'Stacks on top. Back works.';

  @override
  String get navPushNamedCaption => 'Same as push, by route name.';

  @override
  String get navGoViaRouterCaption => 'Same as go, from Riverpod.';

  @override
  String get navPushNamedViaRouterCaption =>
      'Same as pushNamed, from Riverpod.';

  @override
  String get navPopCaption => 'Back one screen. Needs canPop().';

  @override
  String get navReplaceNamedCaption =>
      'Swap this screen. Pop goes to Landing Screen.';

  @override
  String get navStackTitle => 'Stack';

  @override
  String get stackYouAreHere => 'you are here';

  @override
  String get stackRoutingReplaced => 'go wiped Routing Lab — nothing to pop.';

  @override
  String get stackReplaceKeptLanding =>
      'replace swapped Routing Lab. Back goes to Landing Screen.';

  @override
  String get openedWith => 'Opened with';

  @override
  String get userListOpenDetails => 'Each row calls:';

  @override
  String get userListPopCaptionCan => 'Back to Routing Lab.';

  @override
  String get userListPopCaptionCannot =>
      'canPop() is false. This will not pop.';

  @override
  String get userListCanPopTrue => 'pop / Back returns to Routing Lab.';

  @override
  String get userListCanPopReplace => 'pop / Back returns to Landing Screen.';

  @override
  String get userListCanPopFalse => 'canPop() is false. pop will not work.';
}
