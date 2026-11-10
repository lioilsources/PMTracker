// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Zeit';

  @override
  String get navJobs => 'Aufträge';

  @override
  String get navRoster => 'Team';

  @override
  String get navReports => 'Berichte';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get loginSubtitle => 'Zeiterfassung auf Aufträgen';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get emailInvalid => 'Gültige E-Mail-Adresse eingeben';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get passwordMin => 'Mindestens 6 Zeichen';

  @override
  String get signIn => 'Anmelden';

  @override
  String get trackingTitle => 'Zeiterfassung';

  @override
  String greeting(String name) {
    return 'Guten Tag, $name!';
  }

  @override
  String get ready => 'Bereit';

  @override
  String get onSite => 'Vor Ort';

  @override
  String get overrideBadge => 'Ausnahme';

  @override
  String get startShift => 'Erfassung starten';

  @override
  String get stopShift => 'Erfassung beenden';

  @override
  String get todayTotal => 'Heute gesamt';

  @override
  String get pickJob => 'Auftrag auswählen';

  @override
  String get noAssignedActiveJob => 'Dir ist kein aktiver Auftrag zugewiesen';

  @override
  String get outsideGeofenceTitle => 'Außerhalb des Geofence';

  @override
  String get outsideGeofenceBody =>
      'Du bist nicht am Einsatzort. Nenne einen Grund, dann wird dein Vorgesetzter informiert.';

  @override
  String get overrideReasonLabel => 'Grund für die Ausnahme';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get startWithOverride => 'Mit Ausnahme starten';

  @override
  String get locationServicesOff => 'Ortungsdienste sind ausgeschaltet';

  @override
  String get locationDenied => 'Zugriff auf den Standort verweigert';

  @override
  String get locationDeniedForever =>
      'Zugriff auf den Standort dauerhaft verweigert — in den Einstellungen erlauben';

  @override
  String get jobsTitle => 'Aufträge';

  @override
  String get newJob => 'Neuer Auftrag';

  @override
  String get noJobs => 'Keine Aufträge';

  @override
  String get createJob => 'Auftrag anlegen';

  @override
  String plannedHours(String hours) {
    return '$hours Std. geplant';
  }

  @override
  String get editJob => 'Auftrag bearbeiten';

  @override
  String get jobName => 'Auftragsname *';

  @override
  String get requiredField => 'Pflichtfeld';

  @override
  String get description => 'Beschreibung';

  @override
  String get address => 'Adresse';

  @override
  String get latitude => 'Breitengrad (lat)';

  @override
  String get longitude => 'Längengrad (lon)';

  @override
  String get geofenceRadius => 'Geofence-Radius (m)';

  @override
  String get enterNumber => 'Zahl eingeben';

  @override
  String get estimatedHours => 'Geschätzte Stunden';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Aktiv';

  @override
  String get statusPaused => 'Pausiert';

  @override
  String get statusCompleted => 'Abgeschlossen';

  @override
  String get statusArchived => 'Archiviert';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get jobFallbackTitle => 'Auftrag';

  @override
  String get info => 'Informationen';

  @override
  String get manager => 'Vorgesetzter';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Geschätzte Stunden';

  @override
  String get addressUnset => 'Nicht angegeben';

  @override
  String get assignments => 'Zuweisungen';

  @override
  String get add => 'Hinzufügen';

  @override
  String errorWith(String error) {
    return 'Fehler: $error';
  }

  @override
  String get noAssignedMembers => 'Keine zugewiesenen Mitglieder';

  @override
  String get tasks => 'Aufgaben';

  @override
  String get noTasks => 'Keine Aufgaben';

  @override
  String get rosterTitle => 'Mein Team';

  @override
  String get noTeamMembers => 'Du hast keine Teammitglieder';

  @override
  String get askAdminAssign =>
      'Bitte einen Administrator, Mitglieder zuzuweisen';

  @override
  String get reportsTitle => 'Berichte';

  @override
  String get change => 'Ändern';

  @override
  String get noReportData => 'Keine Daten für den gewählten Zeitraum';

  @override
  String totalLabel(String hours) {
    return 'Gesamt: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h Std. $m Min.';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n Einträge',
      one: '$n Eintrag',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Benutzerverwaltung';

  @override
  String get roleMember => 'Mitglied';

  @override
  String get roleManager => 'Vorgesetzter';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrator';
}
