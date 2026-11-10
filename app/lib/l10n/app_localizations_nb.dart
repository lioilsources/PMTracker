// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Tid';

  @override
  String get navJobs => 'Oppdrag';

  @override
  String get navRoster => 'Team';

  @override
  String get navReports => 'Rapporter';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Prøv igjen';

  @override
  String get loginSubtitle => 'Tidsregistrering på oppdrag';

  @override
  String get emailLabel => 'E-post';

  @override
  String get emailInvalid => 'Skriv inn en gyldig e-postadresse';

  @override
  String get passwordLabel => 'Passord';

  @override
  String get passwordMin => 'Minst 6 tegn';

  @override
  String get signIn => 'Logg inn';

  @override
  String get trackingTitle => 'Tidsregistrering';

  @override
  String greeting(String name) {
    return 'Hei, $name!';
  }

  @override
  String get ready => 'Klar';

  @override
  String get onSite => 'På stedet';

  @override
  String get overrideBadge => 'Unntak';

  @override
  String get startShift => 'Start registrering';

  @override
  String get stopShift => 'Stopp registrering';

  @override
  String get todayTotal => 'Totalt i dag';

  @override
  String get pickJob => 'Velg et oppdrag';

  @override
  String get noAssignedActiveJob => 'Du er ikke tildelt noe aktivt oppdrag';

  @override
  String get outsideGeofenceTitle => 'Utenfor geofence';

  @override
  String get outsideGeofenceBody =>
      'Du er ikke på oppdragsstedet. Oppgi en grunn, så får lederen beskjed.';

  @override
  String get overrideReasonLabel => 'Grunn til unntaket';

  @override
  String get cancel => 'Avbryt';

  @override
  String get startWithOverride => 'Start med unntak';

  @override
  String get locationServicesOff => 'Stedstjenester er slått av';

  @override
  String get locationDenied => 'Tilgang til posisjon avslått';

  @override
  String get locationDeniedForever =>
      'Tilgang til posisjon er avslått permanent — tillat det i innstillingene';

  @override
  String get jobsTitle => 'Oppdrag';

  @override
  String get newJob => 'Nytt oppdrag';

  @override
  String get noJobs => 'Ingen oppdrag';

  @override
  String get createJob => 'Opprett oppdrag';

  @override
  String plannedHours(String hours) {
    return '$hours t planlagt';
  }

  @override
  String get editJob => 'Rediger oppdrag';

  @override
  String get jobName => 'Oppdragsnavn *';

  @override
  String get requiredField => 'Obligatorisk felt';

  @override
  String get description => 'Beskrivelse';

  @override
  String get address => 'Adresse';

  @override
  String get latitude => 'Breddegrad (lat)';

  @override
  String get longitude => 'Lengdegrad (lon)';

  @override
  String get geofenceRadius => 'Geofence-radius (m)';

  @override
  String get enterNumber => 'Skriv inn et tall';

  @override
  String get estimatedHours => 'Estimerte timer';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusPaused => 'Satt på pause';

  @override
  String get statusCompleted => 'Fullført';

  @override
  String get statusArchived => 'Arkivert';

  @override
  String get saveChanges => 'Lagre endringer';

  @override
  String get jobFallbackTitle => 'Oppdrag';

  @override
  String get info => 'Informasjon';

  @override
  String get manager => 'Leder';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Estimerte timer';

  @override
  String get addressUnset => 'Ikke oppgitt';

  @override
  String get assignments => 'Tildelinger';

  @override
  String get add => 'Legg til';

  @override
  String errorWith(String error) {
    return 'Feil: $error';
  }

  @override
  String get noAssignedMembers => 'Ingen tildelte medlemmer';

  @override
  String get tasks => 'Oppgaver';

  @override
  String get noTasks => 'Ingen oppgaver';

  @override
  String get rosterTitle => 'Mitt team';

  @override
  String get noTeamMembers => 'Du har ingen medlemmer på teamet';

  @override
  String get askAdminAssign => 'Be en administrator tildele medlemmer';

  @override
  String get reportsTitle => 'Rapporter';

  @override
  String get change => 'Endre';

  @override
  String get noReportData => 'Ingen data for valgt periode';

  @override
  String totalLabel(String hours) {
    return 'Totalt: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h t $m min';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n registreringer',
      one: '$n registrering',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Brukeradministrasjon';

  @override
  String get roleMember => 'Medlem';

  @override
  String get roleManager => 'Leder';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrator';
}
