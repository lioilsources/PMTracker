// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Tid';

  @override
  String get navJobs => 'Opgaver';

  @override
  String get navRoster => 'Team';

  @override
  String get navReports => 'Rapporter';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Prøv igen';

  @override
  String get loginSubtitle => 'Tidsregistrering på opgaver';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Angiv en gyldig e-mail';

  @override
  String get passwordLabel => 'Adgangskode';

  @override
  String get passwordMin => 'Mindst 6 tegn';

  @override
  String get signIn => 'Log ind';

  @override
  String get trackingTitle => 'Tidsregistrering';

  @override
  String greeting(String name) {
    return 'Hej, $name!';
  }

  @override
  String get ready => 'Klar';

  @override
  String get onSite => 'På stedet';

  @override
  String get overrideBadge => 'Undtagelse';

  @override
  String get startShift => 'Start registrering';

  @override
  String get stopShift => 'Stop registrering';

  @override
  String get todayTotal => 'I alt i dag';

  @override
  String get pickJob => 'Vælg en opgave';

  @override
  String get noAssignedActiveJob => 'Du er ikke tildelt nogen aktiv opgave';

  @override
  String get outsideGeofenceTitle => 'Uden for geofence';

  @override
  String get outsideGeofenceBody =>
      'Du er ikke på opgavens placering. Angiv en begrundelse, så får din leder besked.';

  @override
  String get overrideReasonLabel => 'Begrundelse for undtagelse';

  @override
  String get cancel => 'Annuller';

  @override
  String get startWithOverride => 'Start med undtagelse';

  @override
  String get locationServicesOff => 'Lokaliseringstjenester er slået fra';

  @override
  String get locationDenied => 'Adgang til placering afvist';

  @override
  String get locationDeniedForever =>
      'Adgang til placering er afvist permanent — tillad den i indstillingerne';

  @override
  String get jobsTitle => 'Opgaver';

  @override
  String get newJob => 'Ny opgave';

  @override
  String get noJobs => 'Ingen opgaver';

  @override
  String get createJob => 'Opret opgave';

  @override
  String plannedHours(String hours) {
    return '$hours t planlagt';
  }

  @override
  String get editJob => 'Rediger opgave';

  @override
  String get jobName => 'Opgavens navn *';

  @override
  String get requiredField => 'Obligatorisk felt';

  @override
  String get description => 'Beskrivelse';

  @override
  String get address => 'Adresse';

  @override
  String get latitude => 'Breddegrad (lat)';

  @override
  String get longitude => 'Længdegrad (lon)';

  @override
  String get geofenceRadius => 'Geofence-radius (m)';

  @override
  String get enterNumber => 'Angiv et tal';

  @override
  String get estimatedHours => 'Anslåede timer';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusPaused => 'På pause';

  @override
  String get statusCompleted => 'Afsluttet';

  @override
  String get statusArchived => 'Arkiveret';

  @override
  String get saveChanges => 'Gem ændringer';

  @override
  String get jobFallbackTitle => 'Opgave';

  @override
  String get info => 'Oplysninger';

  @override
  String get manager => 'Leder';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Anslåede timer';

  @override
  String get addressUnset => 'Ikke angivet';

  @override
  String get assignments => 'Tildelinger';

  @override
  String get add => 'Tilføj';

  @override
  String errorWith(String error) {
    return 'Fejl: $error';
  }

  @override
  String get noAssignedMembers => 'Ingen tildelte medlemmer';

  @override
  String get tasks => 'Delopgaver';

  @override
  String get noTasks => 'Ingen delopgaver';

  @override
  String get rosterTitle => 'Mit team';

  @override
  String get noTeamMembers => 'Du har ingen medlemmer på dit team';

  @override
  String get askAdminAssign => 'Bed en administrator om at tildele medlemmer';

  @override
  String get reportsTitle => 'Rapporter';

  @override
  String get change => 'Ændr';

  @override
  String get noReportData => 'Ingen data for den valgte periode';

  @override
  String totalLabel(String hours) {
    return 'I alt: $hours';
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
  String get adminTitle => 'Brugeradministration';

  @override
  String get roleMember => 'Medlem';

  @override
  String get roleManager => 'Leder';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrator';
}
