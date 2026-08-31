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
