// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Időrögzítés';

  @override
  String get navJobs => 'Munkák';

  @override
  String get navRoster => 'Csapat';

  @override
  String get navReports => 'Riportok';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Újra';

  @override
  String get loginSubtitle => 'Munkaidő-nyilvántartás munkánként';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Adj meg érvényes e-mail-címet';

  @override
  String get passwordLabel => 'Jelszó';

  @override
  String get passwordMin => 'Legalább 6 karakter';

  @override
  String get signIn => 'Bejelentkezés';

  @override
  String get trackingTitle => 'Időrögzítés';

  @override
  String greeting(String name) {
    return 'Jó napot, $name!';
  }

  @override
  String get ready => 'Kész';

  @override
  String get onSite => 'Helyszínen';

  @override
  String get overrideBadge => 'Kivétel';

  @override
  String get startShift => 'Rögzítés indítása';

  @override
  String get stopShift => 'Rögzítés befejezése';

  @override
  String get todayTotal => 'Ma összesen';

  @override
  String get pickJob => 'Válassz munkát';

  @override
  String get noAssignedActiveJob => 'Nincs hozzád rendelve aktív munka';

  @override
  String get outsideGeofenceTitle => 'A geofence-en kívül';

  @override
  String get outsideGeofenceBody =>
      'Nem vagy a munka helyszínén. Add meg az okot, a vezetőt értesítjük.';

  @override
  String get overrideReasonLabel => 'A kivétel oka';

  @override
  String get cancel => 'Mégse';

  @override
  String get startWithOverride => 'Indítás kivétellel';

  @override
  String get locationServicesOff => 'A helymeghatározás ki van kapcsolva';

  @override
  String get locationDenied => 'A helyhozzáférés megtagadva';

  @override
  String get locationDeniedForever =>
      'A helyhozzáférés végleg megtagadva — engedélyezd a beállításokban';

  @override
  String get jobsTitle => 'Munkák';

  @override
  String get newJob => 'Új munka';

  @override
  String get noJobs => 'Nincs munka';

  @override
  String get createJob => 'Munka létrehozása';

  @override
  String plannedHours(String hours) {
    return '$hours óra tervezve';
  }

  @override
  String get editJob => 'Munka szerkesztése';

  @override
  String get jobName => 'A munka neve *';

  @override
  String get requiredField => 'Kötelező mező';

  @override
  String get description => 'Leírás';

  @override
  String get address => 'Cím';

  @override
  String get latitude => 'Szélességi fok (lat)';

  @override
  String get longitude => 'Hosszúsági fok (lon)';

  @override
  String get geofenceRadius => 'Geofence sugara (m)';

  @override
  String get enterNumber => 'Adj meg egy számot';

  @override
  String get estimatedHours => 'Becsült órák';

  @override
  String get status => 'Állapot';

  @override
  String get statusActive => 'Aktív';

  @override
  String get statusPaused => 'Szüneteltetve';

  @override
  String get statusCompleted => 'Befejezve';

  @override
  String get statusArchived => 'Archivált';

  @override
  String get saveChanges => 'Módosítások mentése';

  @override
  String get jobFallbackTitle => 'Munka';

  @override
  String get info => 'Információk';

  @override
  String get manager => 'Vezető';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Becsült órák';

  @override
  String get addressUnset => 'Nincs megadva';

  @override
  String get assignments => 'Hozzárendelések';

  @override
  String get add => 'Hozzáadás';

  @override
  String errorWith(String error) {
    return 'Hiba: $error';
  }

  @override
  String get noAssignedMembers => 'Nincs hozzárendelt tag';

  @override
  String get tasks => 'Feladatok';

  @override
  String get noTasks => 'Nincs feladat';

  @override
  String get rosterTitle => 'Csapatom';

  @override
  String get noTeamMembers => 'Nincs tag a csapatodban';

  @override
  String get askAdminAssign =>
      'Kérj meg egy adminisztrátort a tagok hozzárendelésére';

  @override
  String get reportsTitle => 'Riportok';

  @override
  String get change => 'Módosítás';

  @override
  String get noReportData => 'A kiválasztott időszakra nincs adat';

  @override
  String totalLabel(String hours) {
    return 'Összesen: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h ó $m p';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n bejegyzés',
      one: '$n bejegyzés',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Felhasználókezelés';

  @override
  String get roleMember => 'Tag';

  @override
  String get roleManager => 'Vezető';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Adminisztrátor';
}
