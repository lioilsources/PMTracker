// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Výkaz';

  @override
  String get navJobs => 'Zakázky';

  @override
  String get navRoster => 'Roster';

  @override
  String get navReports => 'Reporty';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get loginSubtitle => 'Evidence času na zakázkách';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Zadejte platný e-mail';

  @override
  String get passwordLabel => 'Heslo';

  @override
  String get passwordMin => 'Minimum 6 znaků';

  @override
  String get signIn => 'Přihlásit se';

  @override
  String get trackingTitle => 'Výkaz práce';

  @override
  String greeting(String name) {
    return 'Dobrý den, $name!';
  }

  @override
  String get ready => 'Připraven';

  @override
  String get onSite => 'Na místě';

  @override
  String get overrideBadge => 'Override';

  @override
  String get startShift => 'Zahájit výkaz';

  @override
  String get stopShift => 'Ukončit výkaz';

  @override
  String get todayTotal => 'Dnes celkem';

  @override
  String get pickJob => 'Vyberte zakázku';

  @override
  String get noAssignedActiveJob => 'Nejste přiřazeni k žádné aktivní zakázce';

  @override
  String get outsideGeofenceTitle => 'Mimo geofence';

  @override
  String get outsideGeofenceBody =>
      'Nejste na místě zakázky. Uveďte důvod a manager bude informován.';

  @override
  String get overrideReasonLabel => 'Důvod override';

  @override
  String get cancel => 'Zrušit';

  @override
  String get startWithOverride => 'Zahájit s override';

  @override
  String get locationServicesOff => 'Lokalizační služby jsou vypnuté';

  @override
  String get locationDenied => 'Přístup k poloze odmítnut';

  @override
  String get locationDeniedForever =>
      'Přístup k poloze trvale odmítnut — povolte v nastavení';

  @override
  String get jobsTitle => 'Zakázky';

  @override
  String get newJob => 'Nová zakázka';

  @override
  String get noJobs => 'Žádné zakázky';

  @override
  String get createJob => 'Vytvořit zakázku';

  @override
  String plannedHours(String hours) {
    return '$hours h plán';
  }

  @override
  String get editJob => 'Upravit zakázku';

  @override
  String get jobName => 'Název zakázky *';

  @override
  String get requiredField => 'Povinné pole';

  @override
  String get description => 'Popis';

  @override
  String get address => 'Adresa';

  @override
  String get latitude => 'Zeměpisná šířka (lat)';

  @override
  String get longitude => 'Zeměpisná délka (lon)';

  @override
  String get geofenceRadius => 'Geofence poloměr (m)';

  @override
  String get enterNumber => 'Zadejte číslo';

  @override
  String get estimatedHours => 'Odhadované hodiny';

  @override
  String get status => 'Stav';

  @override
  String get statusActive => 'Aktivní';

  @override
  String get statusPaused => 'Pozastavena';

  @override
  String get statusCompleted => 'Dokončena';

  @override
  String get statusArchived => 'Archiv';

  @override
  String get saveChanges => 'Uložit změny';

  @override
  String get jobFallbackTitle => 'Zakázka';

  @override
  String get info => 'Informace';

  @override
  String get manager => 'Manager';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Odhad hodin';

  @override
  String get addressUnset => 'Nezadána';

  @override
  String get assignments => 'Přiřazení';

  @override
  String get add => 'Přidat';

  @override
  String errorWith(String error) {
    return 'Chyba: $error';
  }

  @override
  String get noAssignedMembers => 'Žádní přiřazení členové';

  @override
  String get tasks => 'Úkoly';

  @override
  String get noTasks => 'Žádné úkoly';

  @override
  String get rosterTitle => 'Můj tým';

  @override
  String get noTeamMembers => 'Nemáte žádné členy v týmu';

  @override
  String get askAdminAssign => 'Požádejte administrátora o přiřazení členů';

  @override
  String get reportsTitle => 'Reporty';

  @override
  String get change => 'Změnit';

  @override
  String get noReportData => 'Žádná data pro vybrané období';

  @override
  String totalLabel(String hours) {
    return 'Celkem: $hours';
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
      other: '$n záznamů',
      few: '$n záznamy',
      one: '$n záznam',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Správa uživatelů';

  @override
  String get roleMember => 'Člen';

  @override
  String get roleManager => 'Manager';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrátor';
}
