// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Výkaz';

  @override
  String get navJobs => 'Zákazky';

  @override
  String get navRoster => 'Tím';

  @override
  String get navReports => 'Reporty';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Skúsiť znova';

  @override
  String get loginSubtitle => 'Evidencia času na zákazkách';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Zadajte platný e-mail';

  @override
  String get passwordLabel => 'Heslo';

  @override
  String get passwordMin => 'Minimum 6 znakov';

  @override
  String get signIn => 'Prihlásiť sa';

  @override
  String get trackingTitle => 'Výkaz práce';

  @override
  String greeting(String name) {
    return 'Dobrý deň, $name!';
  }

  @override
  String get ready => 'Pripravený';

  @override
  String get onSite => 'Na mieste';

  @override
  String get overrideBadge => 'Výnimka';

  @override
  String get startShift => 'Začať výkaz';

  @override
  String get stopShift => 'Ukončiť výkaz';

  @override
  String get todayTotal => 'Dnes spolu';

  @override
  String get pickJob => 'Vyberte zákazku';

  @override
  String get noAssignedActiveJob =>
      'Nie ste priradení k žiadnej aktívnej zákazke';

  @override
  String get outsideGeofenceTitle => 'Mimo geofence';

  @override
  String get outsideGeofenceBody =>
      'Nie ste na mieste zákazky. Uveďte dôvod a manažér bude informovaný.';

  @override
  String get overrideReasonLabel => 'Dôvod výnimky';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get startWithOverride => 'Začať s výnimkou';

  @override
  String get locationServicesOff => 'Služby určovania polohy sú vypnuté';

  @override
  String get locationDenied => 'Prístup k polohe bol odmietnutý';

  @override
  String get locationDeniedForever =>
      'Prístup k polohe bol natrvalo odmietnutý — povoľte ho v nastaveniach';

  @override
  String get jobsTitle => 'Zákazky';

  @override
  String get newJob => 'Nová zákazka';

  @override
  String get noJobs => 'Žiadne zákazky';

  @override
  String get createJob => 'Vytvoriť zákazku';

  @override
  String plannedHours(String hours) {
    return 'Plán: $hours h';
  }

  @override
  String get editJob => 'Upraviť zákazku';

  @override
  String get jobName => 'Názov zákazky *';

  @override
  String get requiredField => 'Povinné pole';

  @override
  String get description => 'Popis';

  @override
  String get address => 'Adresa';

  @override
  String get latitude => 'Zemepisná šírka (lat)';

  @override
  String get longitude => 'Zemepisná dĺžka (lon)';

  @override
  String get geofenceRadius => 'Polomer geofence (m)';

  @override
  String get enterNumber => 'Zadajte číslo';

  @override
  String get estimatedHours => 'Odhadované hodiny';

  @override
  String get status => 'Stav';

  @override
  String get statusActive => 'Aktívna';

  @override
  String get statusPaused => 'Pozastavená';

  @override
  String get statusCompleted => 'Dokončená';

  @override
  String get statusArchived => 'Archív';

  @override
  String get saveChanges => 'Uložiť zmeny';

  @override
  String get jobFallbackTitle => 'Zákazka';

  @override
  String get info => 'Informácie';

  @override
  String get manager => 'Manažér';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Odhad hodín';

  @override
  String get addressUnset => 'Nezadaná';

  @override
  String get assignments => 'Priradenia';

  @override
  String get add => 'Pridať';

  @override
  String errorWith(String error) {
    return 'Chyba: $error';
  }

  @override
  String get noAssignedMembers => 'Žiadni priradení členovia';

  @override
  String get tasks => 'Úlohy';

  @override
  String get noTasks => 'Žiadne úlohy';

  @override
  String get rosterTitle => 'Môj tím';

  @override
  String get noTeamMembers => 'Nemáte žiadnych členov v tíme';

  @override
  String get askAdminAssign => 'Požiadajte administrátora o priradenie členov';

  @override
  String get reportsTitle => 'Reporty';

  @override
  String get change => 'Zmeniť';

  @override
  String get noReportData => 'Žiadne údaje za vybrané obdobie';

  @override
  String totalLabel(String hours) {
    return 'Spolu: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h h $m min';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n záznamov',
      few: '$n záznamy',
      one: '$n záznam',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Správa používateľov';

  @override
  String get roleMember => 'Člen';

  @override
  String get roleManager => 'Manažér';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrátor';
}
