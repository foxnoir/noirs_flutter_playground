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
    Locale('en'),
    Locale('de'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced Concepts'**
  String get appTitle;

  /// No description provided for @landing.
  ///
  /// In en, this message translates to:
  /// **'Landing Screen'**
  String get landing;

  /// No description provided for @navigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigation;

  /// No description provided for @routing.
  ///
  /// In en, this message translates to:
  /// **'Routing Lab'**
  String get routing;

  /// No description provided for @userList.
  ///
  /// In en, this message translates to:
  /// **'User List'**
  String get userList;

  /// No description provided for @userDetails.
  ///
  /// In en, this message translates to:
  /// **'User Details'**
  String get userDetails;

  /// No description provided for @bookDetails.
  ///
  /// In en, this message translates to:
  /// **'Book Details'**
  String get bookDetails;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

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

  /// No description provided for @goToLanding.
  ///
  /// In en, this message translates to:
  /// **'Go to Landing Screen'**
  String get goToLanding;

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
  /// **'That user was not found.'**
  String get errorNotFound;

  /// No description provided for @routingNeedBack.
  ///
  /// In en, this message translates to:
  /// **'Need Back'**
  String get routingNeedBack;

  /// No description provided for @routingNeedBackCalls.
  ///
  /// In en, this message translates to:
  /// **'push / pushNamed'**
  String get routingNeedBackCalls;

  /// No description provided for @routingNeedBackHint.
  ///
  /// In en, this message translates to:
  /// **'User List → User Details. Back returns to the list.'**
  String get routingNeedBackHint;

  /// No description provided for @routingNoReturn.
  ///
  /// In en, this message translates to:
  /// **'No return'**
  String get routingNoReturn;

  /// No description provided for @routingNoReturnCalls.
  ///
  /// In en, this message translates to:
  /// **'go / goNamed'**
  String get routingNoReturnCalls;

  /// No description provided for @routingNoReturnHint.
  ///
  /// In en, this message translates to:
  /// **'Wipes the stack. Jump from anywhere.'**
  String get routingNoReturnHint;

  /// No description provided for @routingPopWhen.
  ///
  /// In en, this message translates to:
  /// **'Back one screen'**
  String get routingPopWhen;

  /// No description provided for @routingPopCalls.
  ///
  /// In en, this message translates to:
  /// **'pop'**
  String get routingPopCalls;

  /// No description provided for @routingPopHint.
  ///
  /// In en, this message translates to:
  /// **'Only if canPop(). After push, yes. After go, no.'**
  String get routingPopHint;

  /// No description provided for @routingReplaceWhen.
  ///
  /// In en, this message translates to:
  /// **'Swap this screen'**
  String get routingReplaceWhen;

  /// No description provided for @routingReplaceCalls.
  ///
  /// In en, this message translates to:
  /// **'replace / replaceNamed'**
  String get routingReplaceCalls;

  /// No description provided for @routingReplaceHint.
  ///
  /// In en, this message translates to:
  /// **'This screen is gone. The stack below is not. Pop skips this screen. Login → home. Wrong for List → Details.'**
  String get routingReplaceHint;

  /// No description provided for @routingNamedWhen.
  ///
  /// In en, this message translates to:
  /// **'Named'**
  String get routingNamedWhen;

  /// No description provided for @routingNamedCalls.
  ///
  /// In en, this message translates to:
  /// **'always, in app code'**
  String get routingNamedCalls;

  /// No description provided for @routingNamedHint.
  ///
  /// In en, this message translates to:
  /// **'Not about Back. Combines with push, go, replace. Path (`/user-list`) is the URL.'**
  String get routingNamedHint;

  /// No description provided for @routingContext.
  ///
  /// In en, this message translates to:
  /// **'**context.go** is **GoRouter.of(context).go** — same router, via **BuildContext**. A **Notifier** has no context, so it reads **goRouterProvider**.'**
  String get routingContext;

  /// No description provided for @navGoCaption.
  ///
  /// In en, this message translates to:
  /// **'Wipes the stack.'**
  String get navGoCaption;

  /// No description provided for @navGoNamedCaption.
  ///
  /// In en, this message translates to:
  /// **'Same as go, by route name.'**
  String get navGoNamedCaption;

  /// No description provided for @navPushCaption.
  ///
  /// In en, this message translates to:
  /// **'Stacks on top. Back works.'**
  String get navPushCaption;

  /// No description provided for @navPushNamedCaption.
  ///
  /// In en, this message translates to:
  /// **'Same as push, by route name.'**
  String get navPushNamedCaption;

  /// No description provided for @navGoViaRouterCaption.
  ///
  /// In en, this message translates to:
  /// **'Same as go, from Riverpod.'**
  String get navGoViaRouterCaption;

  /// No description provided for @navPushNamedViaRouterCaption.
  ///
  /// In en, this message translates to:
  /// **'Same as pushNamed, from Riverpod.'**
  String get navPushNamedViaRouterCaption;

  /// No description provided for @navPopCaption.
  ///
  /// In en, this message translates to:
  /// **'Back one screen. Needs canPop().'**
  String get navPopCaption;

  /// No description provided for @navReplaceNamedCaption.
  ///
  /// In en, this message translates to:
  /// **'Swap this screen. Pop goes to Landing Screen.'**
  String get navReplaceNamedCaption;

  /// No description provided for @navStackTitle.
  ///
  /// In en, this message translates to:
  /// **'Stack'**
  String get navStackTitle;

  /// No description provided for @stackYouAreHere.
  ///
  /// In en, this message translates to:
  /// **'you are here'**
  String get stackYouAreHere;

  /// No description provided for @stackRoutingReplaced.
  ///
  /// In en, this message translates to:
  /// **'go wiped Routing Lab — nothing to pop.'**
  String get stackRoutingReplaced;

  /// No description provided for @stackReplaceKeptLanding.
  ///
  /// In en, this message translates to:
  /// **'replace swapped Routing Lab. Back goes to Landing Screen.'**
  String get stackReplaceKeptLanding;

  /// No description provided for @openedWith.
  ///
  /// In en, this message translates to:
  /// **'Opened with'**
  String get openedWith;

  /// No description provided for @userListOpenDetails.
  ///
  /// In en, this message translates to:
  /// **'Each row calls:'**
  String get userListOpenDetails;

  /// No description provided for @userListPopCaptionCan.
  ///
  /// In en, this message translates to:
  /// **'Back to Routing Lab.'**
  String get userListPopCaptionCan;

  /// No description provided for @userListPopCaptionCannot.
  ///
  /// In en, this message translates to:
  /// **'canPop() is false. This will not pop.'**
  String get userListPopCaptionCannot;

  /// No description provided for @userListCanPopTrue.
  ///
  /// In en, this message translates to:
  /// **'pop / Back returns to Routing Lab.'**
  String get userListCanPopTrue;

  /// No description provided for @userListCanPopReplace.
  ///
  /// In en, this message translates to:
  /// **'pop / Back returns to Landing Screen.'**
  String get userListCanPopReplace;

  /// No description provided for @userListCanPopFalse.
  ///
  /// In en, this message translates to:
  /// **'canPop() is false. pop will not work.'**
  String get userListCanPopFalse;

  /// No description provided for @lists.
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get lists;

  /// No description provided for @listsOneAxis.
  ///
  /// In en, this message translates to:
  /// **'One column'**
  String get listsOneAxis;

  /// No description provided for @listsOneAxisCalls.
  ///
  /// In en, this message translates to:
  /// **'ListView.builder'**
  String get listsOneAxisCalls;

  /// No description provided for @listsOneAxisHint.
  ///
  /// In en, this message translates to:
  /// **'Lazy. Long vertical lists.'**
  String get listsOneAxisHint;

  /// No description provided for @listsRow.
  ///
  /// In en, this message translates to:
  /// **'One row'**
  String get listsRow;

  /// No description provided for @listsRowCalls.
  ///
  /// In en, this message translates to:
  /// **'Axis.horizontal'**
  String get listsRowCalls;

  /// No description provided for @listsRowHint.
  ///
  /// In en, this message translates to:
  /// **'Same lazy ListView. Cross axis is height. Needs a max width — not a Row without Expanded.'**
  String get listsRowHint;

  /// No description provided for @listsGrid.
  ///
  /// In en, this message translates to:
  /// **'Same-size tiles'**
  String get listsGrid;

  /// No description provided for @listsGridCalls.
  ///
  /// In en, this message translates to:
  /// **'GridView.builder'**
  String get listsGridCalls;

  /// No description provided for @listsGridHint.
  ///
  /// In en, this message translates to:
  /// **'Lazy. A grid, not a table with mixed spans.'**
  String get listsGridHint;

  /// No description provided for @listsSliver.
  ///
  /// In en, this message translates to:
  /// **'One scroll, mixed pieces'**
  String get listsSliver;

  /// No description provided for @listsSliverCalls.
  ///
  /// In en, this message translates to:
  /// **'CustomScrollView + slivers'**
  String get listsSliverCalls;

  /// No description provided for @listsSliverHint.
  ///
  /// In en, this message translates to:
  /// **'Header + grid + list share one scrollbar.'**
  String get listsSliverHint;

  /// No description provided for @listsEagerWhen.
  ///
  /// In en, this message translates to:
  /// **'Few, known children'**
  String get listsEagerWhen;

  /// No description provided for @listsEagerCalls.
  ///
  /// In en, this message translates to:
  /// **'ListView(children:)'**
  String get listsEagerCalls;

  /// No description provided for @listsEagerHint.
  ///
  /// In en, this message translates to:
  /// **'Builds every child now. Fine for ~10. Wrong for hundreds.'**
  String get listsEagerHint;

  /// No description provided for @listsContext.
  ///
  /// In en, this message translates to:
  /// **'**ListView** and **GridView** are boxes with their own scroll. A **sliver** is a slice inside **CustomScrollView**. Prefer **.builder**. Do not put a vertical ListView in a Column without **Expanded** or a height. Same trap sideways: horizontal ListView in a Row.'**
  String get listsContext;

  /// No description provided for @listsKindList.
  ///
  /// In en, this message translates to:
  /// **'ListView'**
  String get listsKindList;

  /// No description provided for @listsKindGrid.
  ///
  /// In en, this message translates to:
  /// **'GridView'**
  String get listsKindGrid;

  /// No description provided for @listsKindSliver.
  ///
  /// In en, this message translates to:
  /// **'Sliver'**
  String get listsKindSliver;

  /// No description provided for @listsKindHorizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal'**
  String get listsKindHorizontal;

  /// No description provided for @listsCells.
  ///
  /// In en, this message translates to:
  /// **'cells'**
  String get listsCells;

  /// No description provided for @listsBuilds.
  ///
  /// In en, this message translates to:
  /// **'builds'**
  String get listsBuilds;

  /// No description provided for @listsDemoHint.
  ///
  /// In en, this message translates to:
  /// **'Scroll the box. cells stay ≤ 48. Scroll away and back: off-screen children are disposed — builds go up, cells do not.'**
  String get listsDemoHint;

  /// No description provided for @listsCallList.
  ///
  /// In en, this message translates to:
  /// **'ListView.builder(itemBuilder: …)'**
  String get listsCallList;

  /// No description provided for @listsCallGrid.
  ///
  /// In en, this message translates to:
  /// **'GridView.builder(gridDelegate: …)'**
  String get listsCallGrid;

  /// No description provided for @listsCallSliver.
  ///
  /// In en, this message translates to:
  /// **'CustomScrollView(slivers: [SliverGrid, SliverList])'**
  String get listsCallSliver;

  /// No description provided for @listsCallHorizontal.
  ///
  /// In en, this message translates to:
  /// **'ListView.builder(scrollDirection: Axis.horizontal, …)'**
  String get listsCallHorizontal;

  /// No description provided for @listsSliverHeader.
  ///
  /// In en, this message translates to:
  /// **'SliverToBoxAdapter'**
  String get listsSliverHeader;

  /// No description provided for @listsProblemEagerTitle.
  ///
  /// In en, this message translates to:
  /// **'Eager vs lazy'**
  String get listsProblemEagerTitle;

  /// No description provided for @listsProblemEagerCaption.
  ///
  /// In en, this message translates to:
  /// **'children: all cells now. .builder: viewport plus cache. Scroll back: cells stay, builds climb.'**
  String get listsProblemEagerCaption;

  /// No description provided for @listsProblemEagerLabel.
  ///
  /// In en, this message translates to:
  /// **'ListView(children:)'**
  String get listsProblemEagerLabel;

  /// No description provided for @listsProblemLazyLabel.
  ///
  /// In en, this message translates to:
  /// **'ListView.builder'**
  String get listsProblemLazyLabel;

  /// No description provided for @listsProblemUnboundedTitle.
  ///
  /// In en, this message translates to:
  /// **'Unbounded height'**
  String get listsProblemUnboundedTitle;

  /// No description provided for @listsProblemUnboundedCaption.
  ///
  /// In en, this message translates to:
  /// **'Wrong looks like a crash. Works is a list you can scroll. Same header, different constraints.'**
  String get listsProblemUnboundedCaption;

  /// No description provided for @listsProblemUnboundedBadTitle.
  ///
  /// In en, this message translates to:
  /// **'wrong  ·  Column + ListView'**
  String get listsProblemUnboundedBadTitle;

  /// No description provided for @listsProblemUnboundedBadHint.
  ///
  /// In en, this message translates to:
  /// **'Column gives the ListView infinite max height. Debug shows this assertion. The lab paints the stripes so the rest of the page stays up.'**
  String get listsProblemUnboundedBadHint;

  /// No description provided for @listsProblemUnboundedGoodTitle.
  ///
  /// In en, this message translates to:
  /// **'works  ·  Column + Expanded + ListView'**
  String get listsProblemUnboundedGoodTitle;

  /// No description provided for @listsProblemUnboundedGoodHint.
  ///
  /// In en, this message translates to:
  /// **'Expanded eats the leftover height. ListView gets a max. Scroll it.'**
  String get listsProblemUnboundedGoodHint;

  /// No description provided for @listsStripeUnbounded.
  ///
  /// In en, this message translates to:
  /// **'Vertical viewport was given unbounded height.'**
  String get listsStripeUnbounded;

  /// No description provided for @listsLayerHeader.
  ///
  /// In en, this message translates to:
  /// **'header'**
  String get listsLayerHeader;

  /// No description provided for @listsProblemShrinkTitle.
  ///
  /// In en, this message translates to:
  /// **'shrinkWrap + nested scroll'**
  String get listsProblemShrinkTitle;

  /// No description provided for @listsProblemShrinkBody.
  ///
  /// In en, this message translates to:
  /// **'shrinkWrap: true sizes the list by laying out every child. Nested ListViews often need it — that is expensive. Prefer one CustomScrollView of slivers.'**
  String get listsProblemShrinkBody;

  /// No description provided for @layout.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get layout;

  /// No description provided for @layoutMayShrink.
  ///
  /// In en, this message translates to:
  /// **'Child may shrink'**
  String get layoutMayShrink;

  /// No description provided for @layoutMayShrinkCalls.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get layoutMayShrinkCalls;

  /// No description provided for @layoutMayShrinkHint.
  ///
  /// In en, this message translates to:
  /// **'Leftover space in a Row or Column. min = 0. Child can stay small.'**
  String get layoutMayShrinkHint;

  /// No description provided for @layoutMustFill.
  ///
  /// In en, this message translates to:
  /// **'Child must fill'**
  String get layoutMustFill;

  /// No description provided for @layoutMustFillCalls.
  ///
  /// In en, this message translates to:
  /// **'Expanded'**
  String get layoutMustFillCalls;

  /// No description provided for @layoutMustFillHint.
  ///
  /// In en, this message translates to:
  /// **'Same leftover. min = max. Expanded is Flexible(fit: FlexFit.tight).'**
  String get layoutMustFillHint;

  /// No description provided for @layoutPreferredWhen.
  ///
  /// In en, this message translates to:
  /// **'Scaffold slot height'**
  String get layoutPreferredWhen;

  /// No description provided for @layoutPreferredCalls.
  ///
  /// In en, this message translates to:
  /// **'PreferredSize / AppBar'**
  String get layoutPreferredCalls;

  /// No description provided for @layoutPreferredHint.
  ///
  /// In en, this message translates to:
  /// **'appBar and bottomNavigationBar ask for PreferredSizeWidget. Not a Flex child.'**
  String get layoutPreferredHint;

  /// No description provided for @layoutContext.
  ///
  /// In en, this message translates to:
  /// **'**Expanded** is **Flexible(fit: FlexFit.tight)**. **Flexible** is **loose** — leftover can stay empty. **PreferredSize** tells **Scaffold** how tall **appBar** wants to be. **MediaQuery.sizeOf** is the window. **LayoutBuilder** is the parent. **AppBreakpoint** is compact until **600** — mobile first, every layout. **Row overflow** is the yellow-black stripes; **Expanded** shares leftover width so children fit.'**
  String get layoutContext;

  /// No description provided for @layoutWindowWhen.
  ///
  /// In en, this message translates to:
  /// **'Window size'**
  String get layoutWindowWhen;

  /// No description provided for @layoutWindowCalls.
  ///
  /// In en, this message translates to:
  /// **'MediaQuery.sizeOf'**
  String get layoutWindowCalls;

  /// No description provided for @layoutWindowHint.
  ///
  /// In en, this message translates to:
  /// **'The app window. Resize Chrome. Do not use kIsWeb.'**
  String get layoutWindowHint;

  /// No description provided for @layoutBuilderWhen.
  ///
  /// In en, this message translates to:
  /// **'Parent space'**
  String get layoutBuilderWhen;

  /// No description provided for @layoutBuilderCalls.
  ///
  /// In en, this message translates to:
  /// **'LayoutBuilder'**
  String get layoutBuilderCalls;

  /// No description provided for @layoutBuilderHint.
  ///
  /// In en, this message translates to:
  /// **'The parent. A 120-wide box is not the window.'**
  String get layoutBuilderHint;

  /// No description provided for @layoutMobileFirstWhen.
  ///
  /// In en, this message translates to:
  /// **'Default layout'**
  String get layoutMobileFirstWhen;

  /// No description provided for @layoutMobileFirstCalls.
  ///
  /// In en, this message translates to:
  /// **'compact, then ≥ 600'**
  String get layoutMobileFirstCalls;

  /// No description provided for @layoutMobileFirstRuleHint.
  ///
  /// In en, this message translates to:
  /// **'Mobile first everywhere. AppBreakpoint in theme — not AdaptiveScaffold.'**
  String get layoutMobileFirstRuleHint;

  /// No description provided for @layoutSizeCompact.
  ///
  /// In en, this message translates to:
  /// **'compact'**
  String get layoutSizeCompact;

  /// No description provided for @layoutSizeMedium.
  ///
  /// In en, this message translates to:
  /// **'medium'**
  String get layoutSizeMedium;

  /// No description provided for @layoutSizeExpanded.
  ///
  /// In en, this message translates to:
  /// **'expanded'**
  String get layoutSizeExpanded;

  /// No description provided for @layoutSizeLarge.
  ///
  /// In en, this message translates to:
  /// **'large'**
  String get layoutSizeLarge;

  /// No description provided for @layoutSizeExtraLarge.
  ///
  /// In en, this message translates to:
  /// **'extra-large'**
  String get layoutSizeExtraLarge;

  /// No description provided for @layoutBreakpointTitle.
  ///
  /// In en, this message translates to:
  /// **'Breakpoints'**
  String get layoutBreakpointTitle;

  /// No description provided for @layoutBreakpointHint.
  ///
  /// In en, this message translates to:
  /// **'Breakpoints are numbers in AppBreakpoint. MediaQuery does not jump — it only reports the window. This Column/Row jumps at 600 of the parent. Ticks are 600, 840, 1200, 1600.'**
  String get layoutBreakpointHint;

  /// No description provided for @layoutBreakpointCall.
  ///
  /// In en, this message translates to:
  /// **'if (AppBreakpoint.fromWidth(parentWidth).isCompact) Column else Row'**
  String get layoutBreakpointCall;

  /// No description provided for @layoutBreakpointChip.
  ///
  /// In en, this message translates to:
  /// **'parent {width}  ·  {name}'**
  String layoutBreakpointChip(int width, String name);

  /// No description provided for @layoutBreakpointWindowChip.
  ///
  /// In en, this message translates to:
  /// **'window {width}  ·  {name}'**
  String layoutBreakpointWindowChip(int width, String name);

  /// No description provided for @layoutBuilderTitle.
  ///
  /// In en, this message translates to:
  /// **'LayoutBuilder vs MediaQuery'**
  String get layoutBuilderTitle;

  /// No description provided for @layoutBuilderWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'wrong  ·  child width = MediaQuery.sizeOf'**
  String get layoutBuilderWrongTitle;

  /// No description provided for @layoutBuilderWrongHint.
  ///
  /// In en, this message translates to:
  /// **'The parent is 120. MediaQuery.sizeOf is the window. Same yellow-black as Row overflow.'**
  String get layoutBuilderWrongHint;

  /// No description provided for @layoutBuilderRightTitle.
  ///
  /// In en, this message translates to:
  /// **'works  ·  child width = LayoutBuilder'**
  String get layoutBuilderRightTitle;

  /// No description provided for @layoutBuilderRightHint.
  ///
  /// In en, this message translates to:
  /// **'LayoutBuilder.maxWidth is 120. The child is 120. No stripes.'**
  String get layoutBuilderRightHint;

  /// No description provided for @layoutBuilderCallWrong.
  ///
  /// In en, this message translates to:
  /// **'SizedBox(width: MediaQuery.sizeOf(context).width)'**
  String get layoutBuilderCallWrong;

  /// No description provided for @layoutBuilderCallRight.
  ///
  /// In en, this message translates to:
  /// **'SizedBox(width: constraints.maxWidth)'**
  String get layoutBuilderCallRight;

  /// No description provided for @layoutBuilderPaneChip.
  ///
  /// In en, this message translates to:
  /// **'parent {parent}  ·  child {child}'**
  String layoutBuilderPaneChip(int parent, int child);

  /// No description provided for @layoutBuilderStripe.
  ///
  /// In en, this message translates to:
  /// **'RIGHT OVERFLOWED BY {pixels} PIXELS'**
  String layoutBuilderStripe(int pixels);

  /// No description provided for @layoutOverflowTitle.
  ///
  /// In en, this message translates to:
  /// **'Row overflow'**
  String get layoutOverflowTitle;

  /// No description provided for @layoutOverflowWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'wrong  ·  Row + long children'**
  String get layoutOverflowWrongTitle;

  /// No description provided for @layoutOverflowWrongHint.
  ///
  /// In en, this message translates to:
  /// **'The children want more width than the Row. Flutter paints yellow-black stripes on the overflowing edge.'**
  String get layoutOverflowWrongHint;

  /// No description provided for @layoutOverflowRightTitle.
  ///
  /// In en, this message translates to:
  /// **'works  ·  Row + Expanded'**
  String get layoutOverflowRightTitle;

  /// No description provided for @layoutOverflowRightHint.
  ///
  /// In en, this message translates to:
  /// **'Each Expanded gets a slice. Text ellipsizes. No stripes.'**
  String get layoutOverflowRightHint;

  /// No description provided for @layoutOverflowStripe.
  ///
  /// In en, this message translates to:
  /// **'RIGHT OVERFLOWED BY 87 PIXELS'**
  String get layoutOverflowStripe;

  /// No description provided for @layoutOverflowCallWrong.
  ///
  /// In en, this message translates to:
  /// **'Row(children: [Text, Text, Text, …])'**
  String get layoutOverflowCallWrong;

  /// No description provided for @layoutOverflowCallRight.
  ///
  /// In en, this message translates to:
  /// **'Row(children: [Expanded(child: Text(…, overflow: ellipsis))])'**
  String get layoutOverflowCallRight;

  /// No description provided for @layoutFlexTitle.
  ///
  /// In en, this message translates to:
  /// **'Flexible vs Expanded'**
  String get layoutFlexTitle;

  /// No description provided for @layoutFlexFlexibleLabel.
  ///
  /// In en, this message translates to:
  /// **'Flexible'**
  String get layoutFlexFlexibleLabel;

  /// No description provided for @layoutFlexExpandedLabel.
  ///
  /// In en, this message translates to:
  /// **'Expanded'**
  String get layoutFlexExpandedLabel;

  /// No description provided for @layoutFlexChild.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get layoutFlexChild;

  /// No description provided for @layoutFlexEnd.
  ///
  /// In en, this message translates to:
  /// **'64'**
  String get layoutFlexEnd;

  /// No description provided for @layoutFlexLeftover.
  ///
  /// In en, this message translates to:
  /// **'leftover'**
  String get layoutFlexLeftover;

  /// No description provided for @layoutFlexFlexibleHint.
  ///
  /// In en, this message translates to:
  /// **'leftover is empty. Hi stays as wide as the text.'**
  String get layoutFlexFlexibleHint;

  /// No description provided for @layoutFlexExpandedHint.
  ///
  /// In en, this message translates to:
  /// **'No leftover. Hi is forced to fill.'**
  String get layoutFlexExpandedHint;

  /// No description provided for @layoutFlexCallFlexible.
  ///
  /// In en, this message translates to:
  /// **'Flexible(child: …)  // FlexFit.loose'**
  String get layoutFlexCallFlexible;

  /// No description provided for @layoutFlexCallExpanded.
  ///
  /// In en, this message translates to:
  /// **'Expanded(child: …)  // Flexible(fit: FlexFit.tight)'**
  String get layoutFlexCallExpanded;

  /// No description provided for @layoutPreferredTitle.
  ///
  /// In en, this message translates to:
  /// **'PreferredSize'**
  String get layoutPreferredTitle;

  /// No description provided for @layoutPreferredAppBar.
  ///
  /// In en, this message translates to:
  /// **'AppBar'**
  String get layoutPreferredAppBar;

  /// No description provided for @layoutPreferredCustom.
  ///
  /// In en, this message translates to:
  /// **'PreferredSize 96'**
  String get layoutPreferredCustom;

  /// No description provided for @layoutPreferredBody.
  ///
  /// In en, this message translates to:
  /// **'body'**
  String get layoutPreferredBody;

  /// No description provided for @layoutPreferredAppBarHint.
  ///
  /// In en, this message translates to:
  /// **'AppBar implements PreferredSizeWidget. Height is the toolbar (56) when primary is false.'**
  String get layoutPreferredAppBarHint;

  /// No description provided for @layoutPreferredCustomHint.
  ///
  /// In en, this message translates to:
  /// **'Scaffold.appBar uses preferredSize.height. The child does not have to be an AppBar.'**
  String get layoutPreferredCustomHint;

  /// No description provided for @layoutPreferredCallAppBar.
  ///
  /// In en, this message translates to:
  /// **'AppBar()  // PreferredSizeWidget'**
  String get layoutPreferredCallAppBar;

  /// No description provided for @layoutPreferredCallCustom.
  ///
  /// In en, this message translates to:
  /// **'PreferredSize(preferredSize: Size.fromHeight(96), child: …)'**
  String get layoutPreferredCallCustom;

  /// No description provided for @mixins.
  ///
  /// In en, this message translates to:
  /// **'Mixins'**
  String get mixins;

  /// No description provided for @mixinsHint.
  ///
  /// In en, this message translates to:
  /// **'A mixin is a bag of functions two classes can with. Each class keeps its own look. MixinsLabBusyMixin is ours, not Dart. Tap Save: only the button is busy.'**
  String get mixinsHint;

  /// No description provided for @mixinsWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'wrong  ·  two extends'**
  String get mixinsWrongTitle;

  /// No description provided for @mixinsWrongHint.
  ///
  /// In en, this message translates to:
  /// **'Dart allows one parent. State is already the parent.'**
  String get mixinsWrongHint;

  /// No description provided for @mixinsRightTitle.
  ///
  /// In en, this message translates to:
  /// **'works  ·  with MixinsLabBusyMixin'**
  String get mixinsRightTitle;

  /// No description provided for @mixinsRightHint.
  ///
  /// In en, this message translates to:
  /// **'runBusy: busy on, wait 2s, busy off. Each widget has its own busy.'**
  String get mixinsRightHint;

  /// No description provided for @mixinsWithLabel.
  ///
  /// In en, this message translates to:
  /// **'the with line'**
  String get mixinsWithLabel;

  /// No description provided for @mixinsMixinLabel.
  ///
  /// In en, this message translates to:
  /// **'our mixin MixinsLabBusyMixin'**
  String get mixinsMixinLabel;

  /// No description provided for @mixinsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get mixinsSave;

  /// No description provided for @mixinsReload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get mixinsReload;

  /// No description provided for @mixinsIdle.
  ///
  /// In en, this message translates to:
  /// **'idle'**
  String get mixinsIdle;

  /// No description provided for @mixinsBusy.
  ///
  /// In en, this message translates to:
  /// **'busy'**
  String get mixinsBusy;

  /// No description provided for @generics.
  ///
  /// In en, this message translates to:
  /// **'Generics'**
  String get generics;

  /// No description provided for @genericsGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get genericsGeneral;

  /// No description provided for @genericsExample.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get genericsExample;

  /// No description provided for @genericsExampleHint.
  ///
  /// In en, this message translates to:
  /// **'One generic list. itemBuilder maps each User or Book into the row.'**
  String get genericsExampleHint;

  /// No description provided for @genericsExampleBooks.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get genericsExampleBooks;

  /// No description provided for @genericsExampleBooksRead.
  ///
  /// In en, this message translates to:
  /// **'Books read this year'**
  String get genericsExampleBooksRead;

  /// No description provided for @genericsExampleBooksReadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} books read this year'**
  String genericsExampleBooksReadCount(int count);

  /// No description provided for @genericsHint.
  ///
  /// In en, this message translates to:
  /// **'Write a generic when the UI is the same and only the model changes. titleOf is a function you pass, not a field named title: (u) => u.nickname or (b) => b.title.'**
  String get genericsHint;

  /// No description provided for @genericsWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'wrong  ·  two tiles'**
  String get genericsWrongTitle;

  /// No description provided for @genericsWrongHint.
  ///
  /// In en, this message translates to:
  /// **'UserTile and BookTile are the same ListTile twice. Only nickname vs title changes.'**
  String get genericsWrongHint;

  /// No description provided for @genericsRightTitle.
  ///
  /// In en, this message translates to:
  /// **'works  ·  GenericsLabTile<T>'**
  String get genericsRightTitle;

  /// No description provided for @genericsRightHint.
  ///
  /// In en, this message translates to:
  /// **'Tap Ada or Fourth Wing. One widget. titleOf: (u) => u.nickname vs (b) => b.title.'**
  String get genericsRightHint;

  /// No description provided for @genericsTileLabel.
  ///
  /// In en, this message translates to:
  /// **'class GenericsLabTile<T>'**
  String get genericsTileLabel;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The server took too long to answer.'**
  String get errorTimeout;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'That request was not allowed.'**
  String get errorUnauthorized;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'The server failed. Try again.'**
  String get errorServer;

  /// No description provided for @apiHandling.
  ///
  /// In en, this message translates to:
  /// **'API Handling'**
  String get apiHandling;

  /// No description provided for @apiGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get apiGeneral;

  /// No description provided for @apiHttp.
  ///
  /// In en, this message translates to:
  /// **'Example HTTP'**
  String get apiHttp;

  /// No description provided for @apiDio.
  ///
  /// In en, this message translates to:
  /// **'Example Dio'**
  String get apiDio;

  /// No description provided for @apiCompare.
  ///
  /// In en, this message translates to:
  /// **'HTTP vs Dio'**
  String get apiCompare;

  /// No description provided for @apiCompareHint.
  ///
  /// In en, this message translates to:
  /// **'No live call. Step GET or DELETE through package:http (_send) and Dio (interceptors) until the request fires.'**
  String get apiCompareHint;

  /// No description provided for @apiCompareNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get apiCompareNext;

  /// No description provided for @apiCompareReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get apiCompareReset;

  /// No description provided for @apiCompareGet.
  ///
  /// In en, this message translates to:
  /// **'GET'**
  String get apiCompareGet;

  /// No description provided for @apiCompareDelete.
  ///
  /// In en, this message translates to:
  /// **'DELETE'**
  String get apiCompareDelete;

  /// No description provided for @apiCompareIdle.
  ///
  /// In en, this message translates to:
  /// **'Pick GET, DELETE, or a drill. Next walks both stacks.'**
  String get apiCompareIdle;

  /// No description provided for @apiCompareHttpTitle.
  ///
  /// In en, this message translates to:
  /// **'package:http'**
  String get apiCompareHttpTitle;

  /// No description provided for @apiCompareDioTitle.
  ///
  /// In en, this message translates to:
  /// **'Dio'**
  String get apiCompareDioTitle;

  /// No description provided for @apiCompareFires.
  ///
  /// In en, this message translates to:
  /// **'{verb} fires'**
  String apiCompareFires(String verb);

  /// No description provided for @apiCompareHintEnter.
  ///
  /// In en, this message translates to:
  /// **'Data source calls the client. Same entry, different internals.'**
  String get apiCompareHintEnter;

  /// No description provided for @apiCompareHintHttpSend.
  ///
  /// In en, this message translates to:
  /// **'No interceptors. Headers, timeout, and status mapping live in _send.'**
  String get apiCompareHintHttpSend;

  /// No description provided for @apiCompareHintDioSend.
  ///
  /// In en, this message translates to:
  /// **'_send only forwards to _dio.request. Logging and mapping are interceptors.'**
  String get apiCompareHintDioSend;

  /// No description provided for @apiCompareHintHttpNoInterceptor.
  ///
  /// In en, this message translates to:
  /// **'No interceptor pipeline. Still inside _send until the socket.'**
  String get apiCompareHintHttpNoInterceptor;

  /// No description provided for @apiCompareHintDioOnRequest.
  ///
  /// In en, this message translates to:
  /// **'onRequest runs before the socket. Logging and mapping are interceptors, not the data source.'**
  String get apiCompareHintDioOnRequest;

  /// No description provided for @apiCompareHintFire.
  ///
  /// In en, this message translates to:
  /// **'The HTTP request leaves the device here.'**
  String get apiCompareHintFire;

  /// No description provided for @apiCompareHintHttpMap.
  ///
  /// In en, this message translates to:
  /// **'Status 200 is mapped in _send, then JSON is parsed.'**
  String get apiCompareHintHttpMap;

  /// No description provided for @apiCompareHintDioOnResponse.
  ///
  /// In en, this message translates to:
  /// **'onResponse runs after the socket. Then the client parses JSON.'**
  String get apiCompareHintDioOnResponse;

  /// No description provided for @apiCompareHintHttpDeleteMap.
  ///
  /// In en, this message translates to:
  /// **'Status 2xx is mapped in _send. DELETE has no body to parse.'**
  String get apiCompareHintHttpDeleteMap;

  /// No description provided for @apiCompareHintDioDeleteOnResponse.
  ///
  /// In en, this message translates to:
  /// **'onResponse runs after the socket. DELETE has no JSON to parse.'**
  String get apiCompareHintDioDeleteOnResponse;

  /// No description provided for @apiCompareHintHttpTimeout.
  ///
  /// In en, this message translates to:
  /// **'_send catches TimeoutException and throws RequestTimeoutException.'**
  String get apiCompareHintHttpTimeout;

  /// No description provided for @apiCompareHintDioOnError.
  ///
  /// In en, this message translates to:
  /// **'onError maps DioExceptionType.receiveTimeout to RequestTimeoutException.'**
  String get apiCompareHintDioOnError;

  /// No description provided for @apiCompareHintHttpOffline.
  ///
  /// In en, this message translates to:
  /// **'_send catch becomes NetworkException. No interceptor pipeline.'**
  String get apiCompareHintHttpOffline;

  /// No description provided for @apiCompareHintDioOffline.
  ///
  /// In en, this message translates to:
  /// **'onError maps connectionError to NetworkException.'**
  String get apiCompareHintDioOffline;

  /// No description provided for @apiCompareHintHttpServer.
  ///
  /// In en, this message translates to:
  /// **'_send switch: status >= 500 → ServerException.'**
  String get apiCompareHintHttpServer;

  /// No description provided for @apiCompareHintDioServer.
  ///
  /// In en, this message translates to:
  /// **'onError maps badResponse 500 to ServerException.'**
  String get apiCompareHintDioServer;

  /// No description provided for @apiCompareUnstableHint.
  ///
  /// In en, this message translates to:
  /// **'Unstable is not a verb. The live labs fail every third GET. The stack is the same as GET.'**
  String get apiCompareUnstableHint;

  /// No description provided for @apiCompareDeleteHint.
  ///
  /// In en, this message translates to:
  /// **'Same _send vs interceptors as GET. Path is /books/:id. DELETE without Bearer lab is 401. package:http sets the header in _send; Dio uses DioAuthInterceptor.'**
  String get apiCompareDeleteHint;

  /// No description provided for @apiCrudWhen.
  ///
  /// In en, this message translates to:
  /// **'Four verbs for a resource'**
  String get apiCrudWhen;

  /// No description provided for @apiCrudCalls.
  ///
  /// In en, this message translates to:
  /// **'CRUD'**
  String get apiCrudCalls;

  /// No description provided for @apiCrudHint.
  ///
  /// In en, this message translates to:
  /// **'Create POST, Read GET, Update PUT, Delete DELETE. GET /books lists. POST /books adds. PUT /books/:id edits. DELETE /books/:id removes.'**
  String get apiCrudHint;

  /// No description provided for @apiInterceptorWhen.
  ///
  /// In en, this message translates to:
  /// **'Same work on every request'**
  String get apiInterceptorWhen;

  /// No description provided for @apiInterceptorCalls.
  ///
  /// In en, this message translates to:
  /// **'Interceptor (Dio)'**
  String get apiInterceptorCalls;

  /// No description provided for @apiInterceptorHint.
  ///
  /// In en, this message translates to:
  /// **'Dio runs onRequest, onResponse, and onError before the data source. package:http has no interceptors — ApiClient maps timeout and status in _send instead.'**
  String get apiInterceptorHint;

  /// No description provided for @apiUnifiedWhen.
  ///
  /// In en, this message translates to:
  /// **'Every HTTP call'**
  String get apiUnifiedWhen;

  /// No description provided for @apiUnifiedCalls.
  ///
  /// In en, this message translates to:
  /// **'one client class'**
  String get apiUnifiedCalls;

  /// No description provided for @apiUnifiedHint.
  ///
  /// In en, this message translates to:
  /// **'Timeout, 401, 404, 500, and connection errors live in one class. The data source only parses JSON.'**
  String get apiUnifiedHint;

  /// No description provided for @apiTimeoutWhen.
  ///
  /// In en, this message translates to:
  /// **'Server is slow'**
  String get apiTimeoutWhen;

  /// No description provided for @apiTimeoutCalls.
  ///
  /// In en, this message translates to:
  /// **'.timeout'**
  String get apiTimeoutCalls;

  /// No description provided for @apiTimeoutHint.
  ///
  /// In en, this message translates to:
  /// **'The client gives up. GET /timeout on the Firebase emulator waits 2s. Do not wait it out.'**
  String get apiTimeoutHint;

  /// No description provided for @apiNetworkWhen.
  ///
  /// In en, this message translates to:
  /// **'No body to parse'**
  String get apiNetworkWhen;

  /// No description provided for @apiNetworkCalls.
  ///
  /// In en, this message translates to:
  /// **'status → AppException'**
  String get apiNetworkCalls;

  /// No description provided for @apiNetworkHint.
  ///
  /// In en, this message translates to:
  /// **'500 is ServerFailure. 401 is UnauthorizedFailure. DNS / socket is NetworkFailure. Never show e.toString().'**
  String get apiNetworkHint;

  /// No description provided for @apiContext.
  ///
  /// In en, this message translates to:
  /// **'**CRUD** is the four HTTP verbs for one resource. A **unified API class** maps timeout and status once. **Interceptors** are Dio\'s pipeline for that (and logging). **Example HTTP** uses **package:http**. **Example Dio** uses **Dio**. Same Firebase backend. No live calls here.'**
  String get apiContext;

  /// No description provided for @apiUnifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Unified API class'**
  String get apiUnifiedTitle;

  /// No description provided for @apiUnifiedWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'wrong  ·  statusCode in the data source'**
  String get apiUnifiedWrongTitle;

  /// No description provided for @apiUnifiedWrongHint.
  ///
  /// In en, this message translates to:
  /// **'Every method repeats if (statusCode == 401). Timeout is forgotten. Error strings leak into data.'**
  String get apiUnifiedWrongHint;

  /// No description provided for @apiUnifiedRightTitle.
  ///
  /// In en, this message translates to:
  /// **'works  ·  ApiClient.send'**
  String get apiUnifiedRightTitle;

  /// No description provided for @apiUnifiedRightHint.
  ///
  /// In en, this message translates to:
  /// **'GET /books and GET /success share the same mapping. JSON stays wrapped (books / data).'**
  String get apiUnifiedRightHint;

  /// No description provided for @apiUnifiedCallWrong.
  ///
  /// In en, this message translates to:
  /// **'if (response.statusCode == 200) BookModel.fromJson(json)'**
  String get apiUnifiedCallWrong;

  /// No description provided for @apiUnifiedCallRight.
  ///
  /// In en, this message translates to:
  /// **'ApiClient.get(\'/books\', parse)  // throws AppException'**
  String get apiUnifiedCallRight;

  /// No description provided for @apiTimeoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get apiTimeoutTitle;

  /// No description provided for @apiTimeoutWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'wrong  ·  no client timeout'**
  String get apiTimeoutWrongTitle;

  /// No description provided for @apiTimeoutWrongHint.
  ///
  /// In en, this message translates to:
  /// **'GET /timeout waits the full delay. Without a client timeout the UI waits until the server answers.'**
  String get apiTimeoutWrongHint;

  /// No description provided for @apiTimeoutRightTitle.
  ///
  /// In en, this message translates to:
  /// **'works  ·  ApiClient.timeout'**
  String get apiTimeoutRightTitle;

  /// No description provided for @apiTimeoutRightHint.
  ///
  /// In en, this message translates to:
  /// **'Same path. The client cancels first. TimeoutFailure → ErrorWidget.'**
  String get apiTimeoutRightHint;

  /// No description provided for @apiTimeoutCallWrong.
  ///
  /// In en, this message translates to:
  /// **'send(request)  // waits forever'**
  String get apiTimeoutCallWrong;

  /// No description provided for @apiTimeoutCallRight.
  ///
  /// In en, this message translates to:
  /// **'send(request).timeout(Duration(milliseconds: 400))'**
  String get apiTimeoutCallRight;

  /// No description provided for @apiNetworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Network errors'**
  String get apiNetworkTitle;

  /// No description provided for @apiNetworkWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'wrong  ·  catch (e) => e.toString()'**
  String get apiNetworkWrongTitle;

  /// No description provided for @apiNetworkWrongHint.
  ///
  /// In en, this message translates to:
  /// **'The UI shows a socket dump. 401 and 500 look the same.'**
  String get apiNetworkWrongHint;

  /// No description provided for @apiNetworkRightTitle.
  ///
  /// In en, this message translates to:
  /// **'works  ·  map in ApiClient'**
  String get apiNetworkRightTitle;

  /// No description provided for @apiNetworkRightHint.
  ///
  /// In en, this message translates to:
  /// **'500, 401, and offline each get a typed failure and a localized line.'**
  String get apiNetworkRightHint;

  /// No description provided for @apiNetworkCallWrong.
  ///
  /// In en, this message translates to:
  /// **'catch (e) => Text(e.toString())'**
  String get apiNetworkCallWrong;

  /// No description provided for @apiNetworkCallRight.
  ///
  /// In en, this message translates to:
  /// **'401 → UnauthorizedException  ·  500 → ServerException  ·  catch → NetworkException'**
  String get apiNetworkCallRight;

  /// No description provided for @apiDioScenarioBooks.
  ///
  /// In en, this message translates to:
  /// **'Shelf'**
  String get apiDioScenarioBooks;

  /// No description provided for @apiDioScenarioUnstable.
  ///
  /// In en, this message translates to:
  /// **'Unstable'**
  String get apiDioScenarioUnstable;

  /// No description provided for @apiDioScenarioTimeout.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get apiDioScenarioTimeout;

  /// No description provided for @apiDioScenarioOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get apiDioScenarioOffline;

  /// No description provided for @apiDioScenarioServer.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get apiDioScenarioServer;

  /// No description provided for @apiDioUnstableHint.
  ///
  /// In en, this message translates to:
  /// **'Every third Unstable tap fails. Retry loads the shelf.'**
  String get apiDioUnstableHint;

  /// No description provided for @apiDioSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get apiDioSearch;

  /// No description provided for @apiDioSearchTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get apiDioSearchTitleLabel;

  /// No description provided for @apiDioSearchAuthorLabel.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get apiDioSearchAuthorLabel;

  /// No description provided for @apiDioSearchSubmit.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get apiDioSearchSubmit;

  /// No description provided for @apiDioSearchClear.
  ///
  /// In en, this message translates to:
  /// **'Show all books'**
  String get apiDioSearchClear;

  /// No description provided for @apiDioSearchFound.
  ///
  /// In en, this message translates to:
  /// **'POST /search · {title}'**
  String apiDioSearchFound(String title);

  /// No description provided for @apiDioEmpty.
  ///
  /// In en, this message translates to:
  /// **'No books on this shelf.'**
  String get apiDioEmpty;

  /// No description provided for @apiDioNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get apiDioNotStarted;

  /// No description provided for @apiDioFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get apiDioFinished;

  /// No description provided for @apiDioReading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get apiDioReading;

  /// No description provided for @apiDioAdd.
  ///
  /// In en, this message translates to:
  /// **'Add book'**
  String get apiDioAdd;

  /// No description provided for @apiDioEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get apiDioEdit;

  /// No description provided for @apiDioSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get apiDioSave;

  /// No description provided for @apiDioDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get apiDioDelete;

  /// No description provided for @apiDioConfirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete {title}?'**
  String apiDioConfirmDelete(String title);

  /// No description provided for @apiDioSnackGetBooks.
  ///
  /// In en, this message translates to:
  /// **'GET /books'**
  String get apiDioSnackGetBooks;

  /// No description provided for @apiDioSnackAdded.
  ///
  /// In en, this message translates to:
  /// **'POST /books · {title}'**
  String apiDioSnackAdded(String title);

  /// No description provided for @apiDioSnackUpdated.
  ///
  /// In en, this message translates to:
  /// **'PUT /books · {title}'**
  String apiDioSnackUpdated(String title);

  /// No description provided for @apiDioSnackDeleted.
  ///
  /// In en, this message translates to:
  /// **'DELETE /books · {title}'**
  String apiDioSnackDeleted(String title);

  /// No description provided for @apiLabUnauthorizedTitle.
  ///
  /// In en, this message translates to:
  /// **'Not authorized'**
  String get apiLabUnauthorizedTitle;

  /// No description provided for @apiLabUnauthorizedBody.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized for this step. Please log in.'**
  String get apiLabUnauthorizedBody;

  /// No description provided for @apiLabLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get apiLabLogin;

  /// No description provided for @apiLabLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get apiLabLoginTitle;

  /// No description provided for @apiLabPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get apiLabPassword;

  /// No description provided for @apiLabLoginEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter an email.'**
  String get apiLabLoginEmailRequired;

  /// No description provided for @apiLabLoginEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter an email with @.'**
  String get apiLabLoginEmailInvalid;

  /// No description provided for @apiLabLoginPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a password.'**
  String get apiLabLoginPasswordRequired;

  /// No description provided for @apiLabLoginPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 6 characters.'**
  String get apiLabLoginPasswordShort;

  /// No description provided for @apiLabLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Logged in'**
  String get apiLabLoggedIn;

  /// No description provided for @apiLabLoggedOut.
  ///
  /// In en, this message translates to:
  /// **'Not logged in'**
  String get apiLabLoggedOut;

  /// No description provided for @apiLabSnackLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'Logged in'**
  String get apiLabSnackLoggedIn;
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
