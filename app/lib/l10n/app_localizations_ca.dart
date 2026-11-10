// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Registre';

  @override
  String get navJobs => 'Treballs';

  @override
  String get navRoster => 'Equip';

  @override
  String get navReports => 'Informes';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Torna-ho a provar';

  @override
  String get loginSubtitle => 'Registre del temps als treballs';

  @override
  String get emailLabel => 'Correu electrònic';

  @override
  String get emailInvalid => 'Introdueix un correu vàlid';

  @override
  String get passwordLabel => 'Contrasenya';

  @override
  String get passwordMin => 'Mínim 6 caràcters';

  @override
  String get signIn => 'Inicia la sessió';

  @override
  String get trackingTitle => 'Registre de temps';

  @override
  String greeting(String name) {
    return 'Hola, $name!';
  }

  @override
  String get ready => 'Preparat';

  @override
  String get onSite => 'A l\'obra';

  @override
  String get overrideBadge => 'Excepció';

  @override
  String get startShift => 'Inicia el registre';

  @override
  String get stopShift => 'Acaba el registre';

  @override
  String get todayTotal => 'Total d\'avui';

  @override
  String get pickJob => 'Tria un treball';

  @override
  String get noAssignedActiveJob => 'No tens assignat cap treball actiu';

  @override
  String get outsideGeofenceTitle => 'Fora de la geovalla';

  @override
  String get outsideGeofenceBody =>
      'No ets al lloc del treball. Indica\'n el motiu i s\'informarà el responsable.';

  @override
  String get overrideReasonLabel => 'Motiu de l\'excepció';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get startWithOverride => 'Inicia amb excepció';

  @override
  String get locationServicesOff => 'Els serveis d\'ubicació estan desactivats';

  @override
  String get locationDenied => 'Accés a la ubicació denegat';

  @override
  String get locationDeniedForever =>
      'Accés a la ubicació denegat permanentment — permet-lo als ajustos';

  @override
  String get jobsTitle => 'Treballs';

  @override
  String get newJob => 'Treball nou';

  @override
  String get noJobs => 'Cap treball';

  @override
  String get createJob => 'Crea un treball';

  @override
  String plannedHours(String hours) {
    return '$hours h previstes';
  }

  @override
  String get editJob => 'Edita el treball';

  @override
  String get jobName => 'Nom del treball *';

  @override
  String get requiredField => 'Camp obligatori';

  @override
  String get description => 'Descripció';

  @override
  String get address => 'Adreça';

  @override
  String get latitude => 'Latitud (lat)';

  @override
  String get longitude => 'Longitud (lon)';

  @override
  String get geofenceRadius => 'Radi de la geovalla (m)';

  @override
  String get enterNumber => 'Introdueix un número';

  @override
  String get estimatedHours => 'Hores estimades';

  @override
  String get status => 'Estat';

  @override
  String get statusActive => 'Actiu';

  @override
  String get statusPaused => 'En pausa';

  @override
  String get statusCompleted => 'Completat';

  @override
  String get statusArchived => 'Arxivat';

  @override
  String get saveChanges => 'Desa els canvis';

  @override
  String get jobFallbackTitle => 'Treball';

  @override
  String get info => 'Informació';

  @override
  String get manager => 'Responsable';

  @override
  String get geofence => 'Geovalla';

  @override
  String get estimatedHoursShort => 'Hores estimades';

  @override
  String get addressUnset => 'No indicada';

  @override
  String get assignments => 'Assignacions';

  @override
  String get add => 'Afegeix';

  @override
  String errorWith(String error) {
    return 'Error: $error';
  }

  @override
  String get noAssignedMembers => 'Cap membre assignat';

  @override
  String get tasks => 'Tasques';

  @override
  String get noTasks => 'Cap tasca';

  @override
  String get rosterTitle => 'El meu equip';

  @override
  String get noTeamMembers => 'No tens cap membre a l\'equip';

  @override
  String get askAdminAssign => 'Demana a un administrador que assigni membres';

  @override
  String get reportsTitle => 'Informes';

  @override
  String get change => 'Canvia';

  @override
  String get noReportData => 'No hi ha dades per al període seleccionat';

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
      other: '$n registres',
      one: '$n registre',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gestió d\'usuaris';

  @override
  String get roleMember => 'Membre';

  @override
  String get roleManager => 'Responsable';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrador';
}
