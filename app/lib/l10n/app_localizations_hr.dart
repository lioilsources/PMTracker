// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Evidencija';

  @override
  String get navJobs => 'Poslovi';

  @override
  String get navRoster => 'Tim';

  @override
  String get navReports => 'Izvještaji';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Pokušaj ponovno';

  @override
  String get loginSubtitle => 'Evidencija vremena na poslovima';

  @override
  String get emailLabel => 'E-pošta';

  @override
  String get emailInvalid => 'Unesite ispravnu e-poštu';

  @override
  String get passwordLabel => 'Lozinka';

  @override
  String get passwordMin => 'Najmanje 6 znakova';

  @override
  String get signIn => 'Prijava';

  @override
  String get trackingTitle => 'Evidencija vremena';

  @override
  String greeting(String name) {
    return 'Dobar dan, $name!';
  }

  @override
  String get ready => 'Spremno';

  @override
  String get onSite => 'Na lokaciji';

  @override
  String get overrideBadge => 'Iznimka';

  @override
  String get startShift => 'Započni evidenciju';

  @override
  String get stopShift => 'Završi evidenciju';

  @override
  String get todayTotal => 'Ukupno danas';

  @override
  String get pickJob => 'Odaberite posao';

  @override
  String get noAssignedActiveJob => 'Nije vam dodijeljen nijedan aktivni posao';

  @override
  String get outsideGeofenceTitle => 'Izvan geofencea';

  @override
  String get outsideGeofenceBody =>
      'Niste na lokaciji posla. Navedite razlog i voditelj će biti obaviješten.';

  @override
  String get overrideReasonLabel => 'Razlog iznimke';

  @override
  String get cancel => 'Odustani';

  @override
  String get startWithOverride => 'Započni s iznimkom';

  @override
  String get locationServicesOff => 'Usluge lokacije su isključene';

  @override
  String get locationDenied => 'Pristup lokaciji odbijen';

  @override
  String get locationDeniedForever =>
      'Pristup lokaciji trajno odbijen — dopustite ga u postavkama';

  @override
  String get jobsTitle => 'Poslovi';

  @override
  String get newJob => 'Novi posao';

  @override
  String get noJobs => 'Nema poslova';

  @override
  String get createJob => 'Stvori posao';

  @override
  String plannedHours(String hours) {
    return 'Planirano: $hours h';
  }

  @override
  String get editJob => 'Uredi posao';

  @override
  String get jobName => 'Naziv posla *';

  @override
  String get requiredField => 'Obavezno polje';

  @override
  String get description => 'Opis';

  @override
  String get address => 'Adresa';

  @override
  String get latitude => 'Zemljopisna širina (lat)';

  @override
  String get longitude => 'Zemljopisna dužina (lon)';

  @override
  String get geofenceRadius => 'Polumjer geofencea (m)';

  @override
  String get enterNumber => 'Unesite broj';

  @override
  String get estimatedHours => 'Procijenjeni sati';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Aktivan';

  @override
  String get statusPaused => 'Pauziran';

  @override
  String get statusCompleted => 'Dovršen';

  @override
  String get statusArchived => 'Arhiviran';

  @override
  String get saveChanges => 'Spremi promjene';

  @override
  String get jobFallbackTitle => 'Posao';

  @override
  String get info => 'Informacije';

  @override
  String get manager => 'Voditelj';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Procijenjeni sati';

  @override
  String get addressUnset => 'Nije navedena';

  @override
  String get assignments => 'Dodjele';

  @override
  String get add => 'Dodaj';

  @override
  String errorWith(String error) {
    return 'Pogreška: $error';
  }

  @override
  String get noAssignedMembers => 'Nema dodijeljenih članova';

  @override
  String get tasks => 'Zadaci';

  @override
  String get noTasks => 'Nema zadataka';

  @override
  String get rosterTitle => 'Moj tim';

  @override
  String get noTeamMembers => 'Nemate članova u timu';

  @override
  String get askAdminAssign => 'Zamolite administratora da dodijeli članove';

  @override
  String get reportsTitle => 'Izvještaji';

  @override
  String get change => 'Promijeni';

  @override
  String get noReportData => 'Nema podataka za odabrano razdoblje';

  @override
  String totalLabel(String hours) {
    return 'Ukupno: $hours';
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
      other: '$n zapisa',
      few: '$n zapisa',
      one: '$n zapis',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Upravljanje korisnicima';

  @override
  String get roleMember => 'Član';

  @override
  String get roleManager => 'Voditelj';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrator';
}
