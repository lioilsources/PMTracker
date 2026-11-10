// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Evidenca';

  @override
  String get navJobs => 'Naročila';

  @override
  String get navRoster => 'Ekipa';

  @override
  String get navReports => 'Poročila';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Poskusi znova';

  @override
  String get loginSubtitle => 'Evidenca časa na naročilih';

  @override
  String get emailLabel => 'E-pošta';

  @override
  String get emailInvalid => 'Vnesite veljaven e-poštni naslov';

  @override
  String get passwordLabel => 'Geslo';

  @override
  String get passwordMin => 'Vsaj 6 znakov';

  @override
  String get signIn => 'Prijava';

  @override
  String get trackingTitle => 'Evidenca delovnega časa';

  @override
  String greeting(String name) {
    return 'Dober dan, $name!';
  }

  @override
  String get ready => 'Pripravljen';

  @override
  String get onSite => 'Na lokaciji';

  @override
  String get overrideBadge => 'Izjema';

  @override
  String get startShift => 'Začni evidenco';

  @override
  String get stopShift => 'Končaj evidenco';

  @override
  String get todayTotal => 'Danes skupaj';

  @override
  String get pickJob => 'Izberite naročilo';

  @override
  String get noAssignedActiveJob =>
      'Nimate dodeljenega nobenega aktivnega naročila';

  @override
  String get outsideGeofenceTitle => 'Zunaj geofencea';

  @override
  String get outsideGeofenceBody =>
      'Niste na lokaciji naročila. Navedite razlog in vodja bo obveščen.';

  @override
  String get overrideReasonLabel => 'Razlog za izjemo';

  @override
  String get cancel => 'Prekliči';

  @override
  String get startWithOverride => 'Začni z izjemo';

  @override
  String get locationServicesOff => 'Lokacijske storitve so izklopljene';

  @override
  String get locationDenied => 'Dostop do lokacije zavrnjen';

  @override
  String get locationDeniedForever =>
      'Dostop do lokacije je trajno zavrnjen — dovolite ga v nastavitvah';

  @override
  String get jobsTitle => 'Naročila';

  @override
  String get newJob => 'Novo naročilo';

  @override
  String get noJobs => 'Ni naročil';

  @override
  String get createJob => 'Ustvari naročilo';

  @override
  String plannedHours(String hours) {
    return 'Načrt: $hours h';
  }

  @override
  String get editJob => 'Uredi naročilo';

  @override
  String get jobName => 'Ime naročila *';

  @override
  String get requiredField => 'Obvezno polje';

  @override
  String get description => 'Opis';

  @override
  String get address => 'Naslov';

  @override
  String get latitude => 'Zemljepisna širina (lat)';

  @override
  String get longitude => 'Zemljepisna dolžina (lon)';

  @override
  String get geofenceRadius => 'Polmer geofencea (m)';

  @override
  String get enterNumber => 'Vnesite število';

  @override
  String get estimatedHours => 'Ocenjene ure';

  @override
  String get status => 'Stanje';

  @override
  String get statusActive => 'Aktivno';

  @override
  String get statusPaused => 'Zaustavljeno';

  @override
  String get statusCompleted => 'Dokončano';

  @override
  String get statusArchived => 'Arhivirano';

  @override
  String get saveChanges => 'Shrani spremembe';

  @override
  String get jobFallbackTitle => 'Naročilo';

  @override
  String get info => 'Informacije';

  @override
  String get manager => 'Vodja';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Ocenjene ure';

  @override
  String get addressUnset => 'Ni navedeno';

  @override
  String get assignments => 'Dodelitve';

  @override
  String get add => 'Dodaj';

  @override
  String errorWith(String error) {
    return 'Napaka: $error';
  }

  @override
  String get noAssignedMembers => 'Ni dodeljenih članov';

  @override
  String get tasks => 'Naloge';

  @override
  String get noTasks => 'Ni nalog';

  @override
  String get rosterTitle => 'Moja ekipa';

  @override
  String get noTeamMembers => 'V ekipi nimate članov';

  @override
  String get askAdminAssign => 'Prosite skrbnika, naj dodeli člane';

  @override
  String get reportsTitle => 'Poročila';

  @override
  String get change => 'Spremeni';

  @override
  String get noReportData => 'Ni podatkov za izbrano obdobje';

  @override
  String totalLabel(String hours) {
    return 'Skupaj: $hours';
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
      other: '$n vnosov',
      few: '$n vnosi',
      two: '$n vnosa',
      one: '$n vnos',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Upravljanje uporabnikov';

  @override
  String get roleMember => 'Član';

  @override
  String get roleManager => 'Vodja';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Skrbnik';
}
