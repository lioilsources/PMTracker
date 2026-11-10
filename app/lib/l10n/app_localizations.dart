import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

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
    Locale('ar'),
    Locale('bn'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('fr'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kn'),
    Locale('ko'),
    Locale('ml'),
    Locale('mr'),
    Locale('ms'),
    Locale('nb'),
    Locale('nl'),
    Locale('or'),
    Locale('pa'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('pt', 'PT'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sv'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')
  ];

  /// No description provided for @appTitle.
  ///
  /// In cs, this message translates to:
  /// **'PMTracker'**
  String get appTitle;

  /// No description provided for @navTracking.
  ///
  /// In cs, this message translates to:
  /// **'Výkaz'**
  String get navTracking;

  /// No description provided for @navJobs.
  ///
  /// In cs, this message translates to:
  /// **'Zakázky'**
  String get navJobs;

  /// No description provided for @navRoster.
  ///
  /// In cs, this message translates to:
  /// **'Roster'**
  String get navRoster;

  /// No description provided for @navReports.
  ///
  /// In cs, this message translates to:
  /// **'Reporty'**
  String get navReports;

  /// No description provided for @navAdmin.
  ///
  /// In cs, this message translates to:
  /// **'Admin'**
  String get navAdmin;

  /// No description provided for @retry.
  ///
  /// In cs, this message translates to:
  /// **'Zkusit znovu'**
  String get retry;

  /// No description provided for @loginSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Evidence času na zakázkách'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In cs, this message translates to:
  /// **'E-mail'**
  String get emailLabel;

  /// No description provided for @emailInvalid.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte platný e-mail'**
  String get emailInvalid;

  /// No description provided for @passwordLabel.
  ///
  /// In cs, this message translates to:
  /// **'Heslo'**
  String get passwordLabel;

  /// No description provided for @passwordMin.
  ///
  /// In cs, this message translates to:
  /// **'Minimum 6 znaků'**
  String get passwordMin;

  /// No description provided for @signIn.
  ///
  /// In cs, this message translates to:
  /// **'Přihlásit se'**
  String get signIn;

  /// No description provided for @trackingTitle.
  ///
  /// In cs, this message translates to:
  /// **'Výkaz práce'**
  String get trackingTitle;

  /// No description provided for @greeting.
  ///
  /// In cs, this message translates to:
  /// **'Dobrý den, {name}!'**
  String greeting(String name);

  /// No description provided for @ready.
  ///
  /// In cs, this message translates to:
  /// **'Připraven'**
  String get ready;

  /// No description provided for @onSite.
  ///
  /// In cs, this message translates to:
  /// **'Na místě'**
  String get onSite;

  /// No description provided for @overrideBadge.
  ///
  /// In cs, this message translates to:
  /// **'Override'**
  String get overrideBadge;

  /// No description provided for @startShift.
  ///
  /// In cs, this message translates to:
  /// **'Zahájit výkaz'**
  String get startShift;

  /// No description provided for @stopShift.
  ///
  /// In cs, this message translates to:
  /// **'Ukončit výkaz'**
  String get stopShift;

  /// No description provided for @todayTotal.
  ///
  /// In cs, this message translates to:
  /// **'Dnes celkem'**
  String get todayTotal;

  /// No description provided for @pickJob.
  ///
  /// In cs, this message translates to:
  /// **'Vyberte zakázku'**
  String get pickJob;

  /// No description provided for @noAssignedActiveJob.
  ///
  /// In cs, this message translates to:
  /// **'Nejste přiřazeni k žádné aktivní zakázce'**
  String get noAssignedActiveJob;

  /// No description provided for @outsideGeofenceTitle.
  ///
  /// In cs, this message translates to:
  /// **'Mimo geofence'**
  String get outsideGeofenceTitle;

  /// No description provided for @outsideGeofenceBody.
  ///
  /// In cs, this message translates to:
  /// **'Nejste na místě zakázky. Uveďte důvod a manager bude informován.'**
  String get outsideGeofenceBody;

  /// No description provided for @overrideReasonLabel.
  ///
  /// In cs, this message translates to:
  /// **'Důvod override'**
  String get overrideReasonLabel;

  /// No description provided for @cancel.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit'**
  String get cancel;

  /// No description provided for @startWithOverride.
  ///
  /// In cs, this message translates to:
  /// **'Zahájit s override'**
  String get startWithOverride;

  /// No description provided for @locationServicesOff.
  ///
  /// In cs, this message translates to:
  /// **'Lokalizační služby jsou vypnuté'**
  String get locationServicesOff;

  /// No description provided for @locationDenied.
  ///
  /// In cs, this message translates to:
  /// **'Přístup k poloze odmítnut'**
  String get locationDenied;

  /// No description provided for @locationDeniedForever.
  ///
  /// In cs, this message translates to:
  /// **'Přístup k poloze trvale odmítnut — povolte v nastavení'**
  String get locationDeniedForever;

  /// No description provided for @jobsTitle.
  ///
  /// In cs, this message translates to:
  /// **'Zakázky'**
  String get jobsTitle;

  /// No description provided for @newJob.
  ///
  /// In cs, this message translates to:
  /// **'Nová zakázka'**
  String get newJob;

  /// No description provided for @noJobs.
  ///
  /// In cs, this message translates to:
  /// **'Žádné zakázky'**
  String get noJobs;

  /// No description provided for @createJob.
  ///
  /// In cs, this message translates to:
  /// **'Vytvořit zakázku'**
  String get createJob;

  /// No description provided for @plannedHours.
  ///
  /// In cs, this message translates to:
  /// **'{hours} h plán'**
  String plannedHours(String hours);

  /// No description provided for @editJob.
  ///
  /// In cs, this message translates to:
  /// **'Upravit zakázku'**
  String get editJob;

  /// No description provided for @jobName.
  ///
  /// In cs, this message translates to:
  /// **'Název zakázky *'**
  String get jobName;

  /// No description provided for @requiredField.
  ///
  /// In cs, this message translates to:
  /// **'Povinné pole'**
  String get requiredField;

  /// No description provided for @description.
  ///
  /// In cs, this message translates to:
  /// **'Popis'**
  String get description;

  /// No description provided for @address.
  ///
  /// In cs, this message translates to:
  /// **'Adresa'**
  String get address;

  /// No description provided for @latitude.
  ///
  /// In cs, this message translates to:
  /// **'Zeměpisná šířka (lat)'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In cs, this message translates to:
  /// **'Zeměpisná délka (lon)'**
  String get longitude;

  /// No description provided for @geofenceRadius.
  ///
  /// In cs, this message translates to:
  /// **'Geofence poloměr (m)'**
  String get geofenceRadius;

  /// No description provided for @enterNumber.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte číslo'**
  String get enterNumber;

  /// No description provided for @estimatedHours.
  ///
  /// In cs, this message translates to:
  /// **'Odhadované hodiny'**
  String get estimatedHours;

  /// No description provided for @status.
  ///
  /// In cs, this message translates to:
  /// **'Stav'**
  String get status;

  /// No description provided for @statusActive.
  ///
  /// In cs, this message translates to:
  /// **'Aktivní'**
  String get statusActive;

  /// No description provided for @statusPaused.
  ///
  /// In cs, this message translates to:
  /// **'Pozastavena'**
  String get statusPaused;

  /// No description provided for @statusCompleted.
  ///
  /// In cs, this message translates to:
  /// **'Dokončena'**
  String get statusCompleted;

  /// No description provided for @statusArchived.
  ///
  /// In cs, this message translates to:
  /// **'Archiv'**
  String get statusArchived;

  /// No description provided for @saveChanges.
  ///
  /// In cs, this message translates to:
  /// **'Uložit změny'**
  String get saveChanges;

  /// No description provided for @jobFallbackTitle.
  ///
  /// In cs, this message translates to:
  /// **'Zakázka'**
  String get jobFallbackTitle;

  /// No description provided for @info.
  ///
  /// In cs, this message translates to:
  /// **'Informace'**
  String get info;

  /// No description provided for @manager.
  ///
  /// In cs, this message translates to:
  /// **'Manager'**
  String get manager;

  /// No description provided for @geofence.
  ///
  /// In cs, this message translates to:
  /// **'Geofence'**
  String get geofence;

  /// No description provided for @estimatedHoursShort.
  ///
  /// In cs, this message translates to:
  /// **'Odhad hodin'**
  String get estimatedHoursShort;

  /// No description provided for @addressUnset.
  ///
  /// In cs, this message translates to:
  /// **'Nezadána'**
  String get addressUnset;

  /// No description provided for @assignments.
  ///
  /// In cs, this message translates to:
  /// **'Přiřazení'**
  String get assignments;

  /// No description provided for @add.
  ///
  /// In cs, this message translates to:
  /// **'Přidat'**
  String get add;

  /// No description provided for @errorWith.
  ///
  /// In cs, this message translates to:
  /// **'Chyba: {error}'**
  String errorWith(String error);

  /// No description provided for @noAssignedMembers.
  ///
  /// In cs, this message translates to:
  /// **'Žádní přiřazení členové'**
  String get noAssignedMembers;

  /// No description provided for @tasks.
  ///
  /// In cs, this message translates to:
  /// **'Úkoly'**
  String get tasks;

  /// No description provided for @noTasks.
  ///
  /// In cs, this message translates to:
  /// **'Žádné úkoly'**
  String get noTasks;

  /// No description provided for @rosterTitle.
  ///
  /// In cs, this message translates to:
  /// **'Můj tým'**
  String get rosterTitle;

  /// No description provided for @noTeamMembers.
  ///
  /// In cs, this message translates to:
  /// **'Nemáte žádné členy v týmu'**
  String get noTeamMembers;

  /// No description provided for @askAdminAssign.
  ///
  /// In cs, this message translates to:
  /// **'Požádejte administrátora o přiřazení členů'**
  String get askAdminAssign;

  /// No description provided for @reportsTitle.
  ///
  /// In cs, this message translates to:
  /// **'Reporty'**
  String get reportsTitle;

  /// No description provided for @change.
  ///
  /// In cs, this message translates to:
  /// **'Změnit'**
  String get change;

  /// No description provided for @noReportData.
  ///
  /// In cs, this message translates to:
  /// **'Žádná data pro vybrané období'**
  String get noReportData;

  /// No description provided for @totalLabel.
  ///
  /// In cs, this message translates to:
  /// **'Celkem: {hours}'**
  String totalLabel(String hours);

  /// No description provided for @hoursMinutes.
  ///
  /// In cs, this message translates to:
  /// **'{h} h {m} min'**
  String hoursMinutes(int h, String m);

  /// No description provided for @entryCount.
  ///
  /// In cs, this message translates to:
  /// **'{n, plural, one{{n} záznam} few{{n} záznamy} other{{n} záznamů}}'**
  String entryCount(int n);

  /// No description provided for @adminTitle.
  ///
  /// In cs, this message translates to:
  /// **'Správa uživatelů'**
  String get adminTitle;

  /// No description provided for @roleMember.
  ///
  /// In cs, this message translates to:
  /// **'Člen'**
  String get roleMember;

  /// No description provided for @roleManager.
  ///
  /// In cs, this message translates to:
  /// **'Manager'**
  String get roleManager;

  /// No description provided for @roleAdmin.
  ///
  /// In cs, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// No description provided for @roleAdminFull.
  ///
  /// In cs, this message translates to:
  /// **'Administrátor'**
  String get roleAdminFull;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'bn',
        'ca',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'es',
        'fi',
        'fr',
        'gu',
        'he',
        'hi',
        'hr',
        'hu',
        'id',
        'it',
        'ja',
        'kn',
        'ko',
        'ml',
        'mr',
        'ms',
        'nb',
        'nl',
        'or',
        'pa',
        'pl',
        'pt',
        'ro',
        'ru',
        'sk',
        'sl',
        'sv',
        'ta',
        'te',
        'th',
        'tr',
        'uk',
        'ur',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hans':
            return AppLocalizationsZhHans();
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
          case 'PT':
            return AppLocalizationsPtPt();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'gu':
      return AppLocalizationsGu();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'kn':
      return AppLocalizationsKn();
    case 'ko':
      return AppLocalizationsKo();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'ms':
      return AppLocalizationsMs();
    case 'nb':
      return AppLocalizationsNb();
    case 'nl':
      return AppLocalizationsNl();
    case 'or':
      return AppLocalizationsOr();
    case 'pa':
      return AppLocalizationsPa();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sv':
      return AppLocalizationsSv();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'ur':
      return AppLocalizationsUr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
