// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Pontaj';

  @override
  String get navJobs => 'Lucrări';

  @override
  String get navRoster => 'Echipă';

  @override
  String get navReports => 'Rapoarte';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Încearcă din nou';

  @override
  String get loginSubtitle => 'Evidența timpului pe lucrări';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Introdu o adresă de e-mail validă';

  @override
  String get passwordLabel => 'Parolă';

  @override
  String get passwordMin => 'Minimum 6 caractere';

  @override
  String get signIn => 'Autentificare';

  @override
  String get trackingTitle => 'Pontaj';

  @override
  String greeting(String name) {
    return 'Bună ziua, $name!';
  }

  @override
  String get ready => 'Pregătit';

  @override
  String get onSite => 'La fața locului';

  @override
  String get overrideBadge => 'Excepție';

  @override
  String get startShift => 'Începe pontajul';

  @override
  String get stopShift => 'Încheie pontajul';

  @override
  String get todayTotal => 'Total azi';

  @override
  String get pickJob => 'Alege o lucrare';

  @override
  String get noAssignedActiveJob => 'Nu ai nicio lucrare activă alocată';

  @override
  String get outsideGeofenceTitle => 'În afara geofence-ului';

  @override
  String get outsideGeofenceBody =>
      'Nu ești la locul lucrării. Indică motivul și managerul va fi informat.';

  @override
  String get overrideReasonLabel => 'Motivul excepției';

  @override
  String get cancel => 'Anulează';

  @override
  String get startWithOverride => 'Începe cu excepție';

  @override
  String get locationServicesOff => 'Serviciile de localizare sunt dezactivate';

  @override
  String get locationDenied => 'Accesul la locație a fost refuzat';

  @override
  String get locationDeniedForever =>
      'Accesul la locație a fost refuzat definitiv — permite-l din setări';

  @override
  String get jobsTitle => 'Lucrări';

  @override
  String get newJob => 'Lucrare nouă';

  @override
  String get noJobs => 'Nicio lucrare';

  @override
  String get createJob => 'Creează lucrare';

  @override
  String plannedHours(String hours) {
    return '$hours h planificate';
  }

  @override
  String get editJob => 'Editează lucrarea';

  @override
  String get jobName => 'Numele lucrării *';

  @override
  String get requiredField => 'Câmp obligatoriu';

  @override
  String get description => 'Descriere';

  @override
  String get address => 'Adresă';

  @override
  String get latitude => 'Latitudine (lat)';

  @override
  String get longitude => 'Longitudine (lon)';

  @override
  String get geofenceRadius => 'Raza geofence-ului (m)';

  @override
  String get enterNumber => 'Introdu un număr';

  @override
  String get estimatedHours => 'Ore estimate';

  @override
  String get status => 'Stare';

  @override
  String get statusActive => 'Activă';

  @override
  String get statusPaused => 'În pauză';

  @override
  String get statusCompleted => 'Finalizată';

  @override
  String get statusArchived => 'Arhivată';

  @override
  String get saveChanges => 'Salvează modificările';

  @override
  String get jobFallbackTitle => 'Lucrare';

  @override
  String get info => 'Informații';

  @override
  String get manager => 'Manager';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Ore estimate';

  @override
  String get addressUnset => 'Nespecificată';

  @override
  String get assignments => 'Alocări';

  @override
  String get add => 'Adaugă';

  @override
  String errorWith(String error) {
    return 'Eroare: $error';
  }

  @override
  String get noAssignedMembers => 'Niciun membru alocat';

  @override
  String get tasks => 'Sarcini';

  @override
  String get noTasks => 'Nicio sarcină';

  @override
  String get rosterTitle => 'Echipa mea';

  @override
  String get noTeamMembers => 'Nu ai membri în echipă';

  @override
  String get askAdminAssign => 'Roagă un administrator să aloce membri';

  @override
  String get reportsTitle => 'Rapoarte';

  @override
  String get change => 'Schimbă';

  @override
  String get noReportData => 'Nu există date pentru perioada selectată';

  @override
  String totalLabel(String hours) {
    return 'Total: $hours';
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
      other: '$n de înregistrări',
      few: '$n înregistrări',
      one: '$n înregistrare',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gestionarea utilizatorilor';

  @override
  String get roleMember => 'Membru';

  @override
  String get roleManager => 'Manager';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrator';
}
