// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Tempo';

  @override
  String get navJobs => 'Commesse';

  @override
  String get navRoster => 'Team';

  @override
  String get navReports => 'Report';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Riprova';

  @override
  String get loginSubtitle => 'Registrazione del tempo sulle commesse';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Inserisci un\'e-mail valida';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordMin => 'Minimo 6 caratteri';

  @override
  String get signIn => 'Accedi';

  @override
  String get trackingTitle => 'Registrazione del tempo';

  @override
  String greeting(String name) {
    return 'Buongiorno, $name!';
  }

  @override
  String get ready => 'Pronto';

  @override
  String get onSite => 'In sede';

  @override
  String get overrideBadge => 'Eccezione';

  @override
  String get startShift => 'Avvia registrazione';

  @override
  String get stopShift => 'Termina registrazione';

  @override
  String get todayTotal => 'Totale di oggi';

  @override
  String get pickJob => 'Scegli una commessa';

  @override
  String get noAssignedActiveJob => 'Non hai nessuna commessa attiva assegnata';

  @override
  String get outsideGeofenceTitle => 'Fuori dal geofence';

  @override
  String get outsideGeofenceBody =>
      'Non sei sul luogo della commessa. Indica il motivo e il responsabile verrà informato.';

  @override
  String get overrideReasonLabel => 'Motivo dell\'eccezione';

  @override
  String get cancel => 'Annulla';

  @override
  String get startWithOverride => 'Avvia con eccezione';

  @override
  String get locationServicesOff =>
      'I servizi di localizzazione sono disattivati';

  @override
  String get locationDenied => 'Accesso alla posizione negato';

  @override
  String get locationDeniedForever =>
      'Accesso alla posizione negato in modo permanente — consentilo nelle impostazioni';

  @override
  String get jobsTitle => 'Commesse';

  @override
  String get newJob => 'Nuova commessa';

  @override
  String get noJobs => 'Nessuna commessa';

  @override
  String get createJob => 'Crea commessa';

  @override
  String plannedHours(String hours) {
    return '$hours h previste';
  }

  @override
  String get editJob => 'Modifica commessa';

  @override
  String get jobName => 'Nome della commessa *';

  @override
  String get requiredField => 'Campo obbligatorio';

  @override
  String get description => 'Descrizione';

  @override
  String get address => 'Indirizzo';

  @override
  String get latitude => 'Latitudine (lat)';

  @override
  String get longitude => 'Longitudine (lon)';

  @override
  String get geofenceRadius => 'Raggio del geofence (m)';

  @override
  String get enterNumber => 'Inserisci un numero';

  @override
  String get estimatedHours => 'Ore stimate';

  @override
  String get status => 'Stato';

  @override
  String get statusActive => 'Attiva';

  @override
  String get statusPaused => 'In pausa';

  @override
  String get statusCompleted => 'Completata';

  @override
  String get statusArchived => 'Archiviata';

  @override
  String get saveChanges => 'Salva le modifiche';

  @override
  String get jobFallbackTitle => 'Commessa';

  @override
  String get info => 'Informazioni';

  @override
  String get manager => 'Responsabile';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Ore stimate';

  @override
  String get addressUnset => 'Non indicato';

  @override
  String get assignments => 'Assegnazioni';

  @override
  String get add => 'Aggiungi';

  @override
  String errorWith(String error) {
    return 'Errore: $error';
  }

  @override
  String get noAssignedMembers => 'Nessun membro assegnato';

  @override
  String get tasks => 'Attività';

  @override
  String get noTasks => 'Nessuna attività';

  @override
  String get rosterTitle => 'Il mio team';

  @override
  String get noTeamMembers => 'Non hai membri nel team';

  @override
  String get askAdminAssign =>
      'Chiedi a un amministratore di assegnare dei membri';

  @override
  String get reportsTitle => 'Report';

  @override
  String get change => 'Cambia';

  @override
  String get noReportData => 'Nessun dato per il periodo selezionato';

  @override
  String totalLabel(String hours) {
    return 'Totale: $hours';
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
      other: '$n registrazioni',
      one: '$n registrazione',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gestione utenti';

  @override
  String get roleMember => 'Membro';

  @override
  String get roleManager => 'Responsabile';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Amministratore';
}
