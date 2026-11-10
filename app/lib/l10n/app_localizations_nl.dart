// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Tijd';

  @override
  String get navJobs => 'Opdrachten';

  @override
  String get navRoster => 'Team';

  @override
  String get navReports => 'Rapporten';

  @override
  String get navAdmin => 'Beheer';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get loginSubtitle => 'Tijdregistratie op opdrachten';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Voer een geldig e-mailadres in';

  @override
  String get passwordLabel => 'Wachtwoord';

  @override
  String get passwordMin => 'Minimaal 6 tekens';

  @override
  String get signIn => 'Inloggen';

  @override
  String get trackingTitle => 'Tijdregistratie';

  @override
  String greeting(String name) {
    return 'Hallo, $name!';
  }

  @override
  String get ready => 'Klaar';

  @override
  String get onSite => 'Ter plaatse';

  @override
  String get overrideBadge => 'Uitzondering';

  @override
  String get startShift => 'Registratie starten';

  @override
  String get stopShift => 'Registratie stoppen';

  @override
  String get todayTotal => 'Totaal vandaag';

  @override
  String get pickJob => 'Kies een opdracht';

  @override
  String get noAssignedActiveJob =>
      'Je bent aan geen enkele actieve opdracht toegewezen';

  @override
  String get outsideGeofenceTitle => 'Buiten de geofence';

  @override
  String get outsideGeofenceBody =>
      'Je bent niet op de locatie van de opdracht. Geef een reden op, dan wordt je leidinggevende op de hoogte gebracht.';

  @override
  String get overrideReasonLabel => 'Reden van de uitzondering';

  @override
  String get cancel => 'Annuleren';

  @override
  String get startWithOverride => 'Starten met uitzondering';

  @override
  String get locationServicesOff => 'Locatievoorzieningen staan uit';

  @override
  String get locationDenied => 'Toegang tot locatie geweigerd';

  @override
  String get locationDeniedForever =>
      'Toegang tot locatie permanent geweigerd — sta het toe in de instellingen';

  @override
  String get jobsTitle => 'Opdrachten';

  @override
  String get newJob => 'Nieuwe opdracht';

  @override
  String get noJobs => 'Geen opdrachten';

  @override
  String get createJob => 'Opdracht aanmaken';

  @override
  String plannedHours(String hours) {
    return '$hours u gepland';
  }

  @override
  String get editJob => 'Opdracht bewerken';

  @override
  String get jobName => 'Naam van de opdracht *';

  @override
  String get requiredField => 'Verplicht veld';

  @override
  String get description => 'Beschrijving';

  @override
  String get address => 'Adres';

  @override
  String get latitude => 'Breedtegraad (lat)';

  @override
  String get longitude => 'Lengtegraad (lon)';

  @override
  String get geofenceRadius => 'Geofence-straal (m)';

  @override
  String get enterNumber => 'Voer een getal in';

  @override
  String get estimatedHours => 'Geschatte uren';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Actief';

  @override
  String get statusPaused => 'Gepauzeerd';

  @override
  String get statusCompleted => 'Voltooid';

  @override
  String get statusArchived => 'Gearchiveerd';

  @override
  String get saveChanges => 'Wijzigingen opslaan';

  @override
  String get jobFallbackTitle => 'Opdracht';

  @override
  String get info => 'Informatie';

  @override
  String get manager => 'Leidinggevende';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Geschatte uren';

  @override
  String get addressUnset => 'Niet opgegeven';

  @override
  String get assignments => 'Toewijzingen';

  @override
  String get add => 'Toevoegen';

  @override
  String errorWith(String error) {
    return 'Fout: $error';
  }

  @override
  String get noAssignedMembers => 'Geen toegewezen leden';

  @override
  String get tasks => 'Taken';

  @override
  String get noTasks => 'Geen taken';

  @override
  String get rosterTitle => 'Mijn team';

  @override
  String get noTeamMembers => 'Je hebt geen teamleden';

  @override
  String get askAdminAssign => 'Vraag een beheerder om leden toe te wijzen';

  @override
  String get reportsTitle => 'Rapporten';

  @override
  String get change => 'Wijzigen';

  @override
  String get noReportData => 'Geen gegevens voor de gekozen periode';

  @override
  String totalLabel(String hours) {
    return 'Totaal: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h u $m min';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n registraties',
      one: '$n registratie',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gebruikersbeheer';

  @override
  String get roleMember => 'Lid';

  @override
  String get roleManager => 'Leidinggevende';

  @override
  String get roleAdmin => 'Beheerder';

  @override
  String get roleAdminFull => 'Beheerder';
}
