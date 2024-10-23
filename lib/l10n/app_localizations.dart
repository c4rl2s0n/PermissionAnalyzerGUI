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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'PermissionAnalyzerGui'**
  String get title;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @themeSettings.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// No description provided for @selectedLanguage.
  ///
  /// In en, this message translates to:
  /// **'Selected Language'**
  String get selectedLanguage;

  /// No description provided for @testScenario.
  ///
  /// In en, this message translates to:
  /// **'Test Scenario'**
  String get testScenario;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @adbSettings.
  ///
  /// In en, this message translates to:
  /// **'ADB Executable Path'**
  String get adbSettings;

  /// No description provided for @adbDeviceSettings.
  ///
  /// In en, this message translates to:
  /// **'Android Device Name'**
  String get adbDeviceSettings;

  /// No description provided for @adbNotFound.
  ///
  /// In en, this message translates to:
  /// **'Could not find ADB on the system.\nSpecify the path manually or install ADB.'**
  String get adbNotFound;

  /// No description provided for @pickAdbPath.
  ///
  /// In en, this message translates to:
  /// **'Select the path of ADB on your system.'**
  String get pickAdbPath;

  /// No description provided for @tsharkSettings.
  ///
  /// In en, this message translates to:
  /// **'TShark Executable Path'**
  String get tsharkSettings;

  /// No description provided for @tsharkNotFound.
  ///
  /// In en, this message translates to:
  /// **'Could not find TShark on the system.\nSpecify the path manually or install TShark.'**
  String get tsharkNotFound;

  /// No description provided for @pickTsharkPath.
  ///
  /// In en, this message translates to:
  /// **'Select the path of TShark on your system.'**
  String get pickTsharkPath;

  /// No description provided for @recorderLocalSettings.
  ///
  /// In en, this message translates to:
  /// **'Gesture Recorder Executable Path'**
  String get recorderLocalSettings;

  /// No description provided for @recorderDestinationSettings.
  ///
  /// In en, this message translates to:
  /// **'Gesture Recorder Destination Path'**
  String get recorderDestinationSettings;

  /// No description provided for @recorderDestinationSettingsDescription.
  ///
  /// In en, this message translates to:
  /// **'Location where the gesture recorder executable will be stored on the test device'**
  String get recorderDestinationSettingsDescription;

  /// No description provided for @pickRecorderPath.
  ///
  /// In en, this message translates to:
  /// **'Select the path of gesture recorder executable.'**
  String get pickRecorderPath;

  /// No description provided for @pathFound.
  ///
  /// In en, this message translates to:
  /// **'The file was found on your system.'**
  String get pathFound;

  /// No description provided for @path.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get path;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
