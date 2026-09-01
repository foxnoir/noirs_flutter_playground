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
  /// **'**Expanded** is **Flexible(fit: FlexFit.tight)**. **Flexible** is **loose** — leftover can stay empty. **PreferredSize** tells **Scaffold** how tall **appBar** wants to be. **Row overflow** is the yellow-black stripes; **Expanded** shares leftover width so children fit.'**
  String get layoutContext;

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
