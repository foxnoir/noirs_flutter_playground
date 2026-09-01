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

  @override
  String get lists => 'Lists';

  @override
  String get listsOneAxis => 'One column';

  @override
  String get listsOneAxisCalls => 'ListView.builder';

  @override
  String get listsOneAxisHint => 'Lazy. Long vertical lists.';

  @override
  String get listsRow => 'One row';

  @override
  String get listsRowCalls => 'Axis.horizontal';

  @override
  String get listsRowHint =>
      'Same lazy ListView. Cross axis is height. Needs a max width — not a Row without Expanded.';

  @override
  String get listsGrid => 'Same-size tiles';

  @override
  String get listsGridCalls => 'GridView.builder';

  @override
  String get listsGridHint => 'Lazy. A grid, not a table with mixed spans.';

  @override
  String get listsSliver => 'One scroll, mixed pieces';

  @override
  String get listsSliverCalls => 'CustomScrollView + slivers';

  @override
  String get listsSliverHint => 'Header + grid + list share one scrollbar.';

  @override
  String get listsEagerWhen => 'Few, known children';

  @override
  String get listsEagerCalls => 'ListView(children:)';

  @override
  String get listsEagerHint =>
      'Builds every child now. Fine for ~10. Wrong for hundreds.';

  @override
  String get listsContext =>
      '**ListView** and **GridView** are boxes with their own scroll. A **sliver** is a slice inside **CustomScrollView**. Prefer **.builder**. Do not put a vertical ListView in a Column without **Expanded** or a height. Same trap sideways: horizontal ListView in a Row.';

  @override
  String get listsKindList => 'ListView';

  @override
  String get listsKindGrid => 'GridView';

  @override
  String get listsKindSliver => 'Sliver';

  @override
  String get listsKindHorizontal => 'Horizontal';

  @override
  String get listsCells => 'cells';

  @override
  String get listsBuilds => 'builds';

  @override
  String get listsDemoHint =>
      'Scroll the box. cells stay ≤ 48. Scroll away and back: off-screen children are disposed — builds go up, cells do not.';

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
      'children: all cells now. .builder: viewport plus cache. Scroll back: cells stay, builds climb.';

  @override
  String get listsProblemEagerLabel => 'ListView(children:)';

  @override
  String get listsProblemLazyLabel => 'ListView.builder';

  @override
  String get listsProblemUnboundedTitle => 'Unbounded height';

  @override
  String get listsProblemUnboundedCaption =>
      'Wrong looks like a crash. Works is a list you can scroll. Same header, different constraints.';

  @override
  String get listsProblemUnboundedBadTitle => 'wrong  ·  Column + ListView';

  @override
  String get listsProblemUnboundedBadHint =>
      'Column gives the ListView infinite max height. Debug shows this assertion. The lab paints the stripes so the rest of the page stays up.';

  @override
  String get listsProblemUnboundedGoodTitle =>
      'works  ·  Column + Expanded + ListView';

  @override
  String get listsProblemUnboundedGoodHint =>
      'Expanded eats the leftover height. ListView gets a max. Scroll it.';

  @override
  String get listsStripeUnbounded =>
      'Vertical viewport was given unbounded height.';

  @override
  String get listsLayerHeader => 'header';

  @override
  String get listsProblemShrinkTitle => 'shrinkWrap + nested scroll';

  @override
  String get listsProblemShrinkBody =>
      'shrinkWrap: true sizes the list by laying out every child. Nested ListViews often need it — that is expensive. Prefer one CustomScrollView of slivers.';

  @override
  String get layout => 'Layout';

  @override
  String get layoutMayShrink => 'Child may shrink';

  @override
  String get layoutMayShrinkCalls => 'Flexible';

  @override
  String get layoutMayShrinkHint =>
      'Leftover space in a Row or Column. min = 0. Child can stay small.';

  @override
  String get layoutMustFill => 'Child must fill';

  @override
  String get layoutMustFillCalls => 'Expanded';

  @override
  String get layoutMustFillHint =>
      'Same leftover. min = max. Expanded is Flexible(fit: FlexFit.tight).';

  @override
  String get layoutPreferredWhen => 'Scaffold slot height';

  @override
  String get layoutPreferredCalls => 'PreferredSize / AppBar';

  @override
  String get layoutPreferredHint =>
      'appBar and bottomNavigationBar ask for PreferredSizeWidget. Not a Flex child.';

  @override
  String get layoutContext =>
      '**Expanded** is **Flexible(fit: FlexFit.tight)**. **Flexible** is **loose** — leftover can stay empty. **PreferredSize** tells **Scaffold** how tall **appBar** wants to be. **MediaQuery.sizeOf** is the window. **LayoutBuilder** is the parent. **AppBreakpoint** is compact until **600** — mobile first, every layout. **Row overflow** is the yellow-black stripes; **Expanded** shares leftover width so children fit.';

  @override
  String get layoutWindowWhen => 'Window size';

  @override
  String get layoutWindowCalls => 'MediaQuery.sizeOf';

  @override
  String get layoutWindowHint =>
      'The app window. Resize Chrome. Do not use kIsWeb.';

  @override
  String get layoutBuilderWhen => 'Parent space';

  @override
  String get layoutBuilderCalls => 'LayoutBuilder';

  @override
  String get layoutBuilderHint =>
      'The parent. A 120-wide box is not the window.';

  @override
  String get layoutMobileFirstWhen => 'Default layout';

  @override
  String get layoutMobileFirstCalls => 'compact, then ≥ 600';

  @override
  String get layoutMobileFirstRuleHint =>
      'Mobile first everywhere. AppBreakpoint in theme — not AdaptiveScaffold.';

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
      'Breakpoints are numbers in AppBreakpoint. MediaQuery does not jump — it only reports the window. This Column/Row jumps at 600 of the parent. Ticks are 600, 840, 1200, 1600.';

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
      'The parent is 120. MediaQuery.sizeOf is the window. Same yellow-black as Row overflow.';

  @override
  String get layoutBuilderRightTitle => 'works  ·  child width = LayoutBuilder';

  @override
  String get layoutBuilderRightHint =>
      'LayoutBuilder.maxWidth is 120. The child is 120. No stripes.';

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
  String get layoutOverflowWrongTitle => 'wrong  ·  Row + long children';

  @override
  String get layoutOverflowWrongHint =>
      'The children want more width than the Row. Flutter paints yellow-black stripes on the overflowing edge.';

  @override
  String get layoutOverflowRightTitle => 'works  ·  Row + Expanded';

  @override
  String get layoutOverflowRightHint =>
      'Each Expanded gets a slice. Text ellipsizes. No stripes.';

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
      'leftover is empty. Hi stays as wide as the text.';

  @override
  String get layoutFlexExpandedHint => 'No leftover. Hi is forced to fill.';

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
      'AppBar implements PreferredSizeWidget. Height is the toolbar (56) when primary is false.';

  @override
  String get layoutPreferredCustomHint =>
      'Scaffold.appBar uses preferredSize.height. The child does not have to be an AppBar.';

  @override
  String get layoutPreferredCallAppBar => 'AppBar()  // PreferredSizeWidget';

  @override
  String get layoutPreferredCallCustom =>
      'PreferredSize(preferredSize: Size.fromHeight(96), child: …)';
}
