// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Registro';

  @override
  String get navJobs => 'Trabajos';

  @override
  String get navRoster => 'Equipo';

  @override
  String get navReports => 'Informes';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Reintentar';

  @override
  String get loginSubtitle => 'Registro del tiempo en los trabajos';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailInvalid => 'Introduce un correo válido';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordMin => 'Mínimo 6 caracteres';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get trackingTitle => 'Registro de tiempo';

  @override
  String greeting(String name) {
    return '¡Hola, $name!';
  }

  @override
  String get ready => 'Listo';

  @override
  String get onSite => 'En obra';

  @override
  String get overrideBadge => 'Excepción';

  @override
  String get startShift => 'Iniciar registro';

  @override
  String get stopShift => 'Terminar registro';

  @override
  String get todayTotal => 'Total de hoy';

  @override
  String get pickJob => 'Elige un trabajo';

  @override
  String get noAssignedActiveJob => 'No tienes asignado ningún trabajo activo';

  @override
  String get outsideGeofenceTitle => 'Fuera del geovallado';

  @override
  String get outsideGeofenceBody =>
      'No estás en el lugar del trabajo. Indica el motivo y se informará al responsable.';

  @override
  String get overrideReasonLabel => 'Motivo de la excepción';

  @override
  String get cancel => 'Cancelar';

  @override
  String get startWithOverride => 'Iniciar con excepción';

  @override
  String get locationServicesOff =>
      'Los servicios de ubicación están desactivados';

  @override
  String get locationDenied => 'Acceso a la ubicación denegado';

  @override
  String get locationDeniedForever =>
      'Acceso a la ubicación denegado de forma permanente — permítelo en los ajustes';

  @override
  String get jobsTitle => 'Trabajos';

  @override
  String get newJob => 'Nuevo trabajo';

  @override
  String get noJobs => 'Ningún trabajo';

  @override
  String get createJob => 'Crear trabajo';

  @override
  String plannedHours(String hours) {
    return '$hours h previstas';
  }

  @override
  String get editJob => 'Editar trabajo';

  @override
  String get jobName => 'Nombre del trabajo *';

  @override
  String get requiredField => 'Campo obligatorio';

  @override
  String get description => 'Descripción';

  @override
  String get address => 'Dirección';

  @override
  String get latitude => 'Latitud (lat)';

  @override
  String get longitude => 'Longitud (lon)';

  @override
  String get geofenceRadius => 'Radio del geovallado (m)';

  @override
  String get enterNumber => 'Introduce un número';

  @override
  String get estimatedHours => 'Horas estimadas';

  @override
  String get status => 'Estado';

  @override
  String get statusActive => 'Activo';

  @override
  String get statusPaused => 'En pausa';

  @override
  String get statusCompleted => 'Completado';

  @override
  String get statusArchived => 'Archivado';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get jobFallbackTitle => 'Trabajo';

  @override
  String get info => 'Información';

  @override
  String get manager => 'Responsable';

  @override
  String get geofence => 'Geovallado';

  @override
  String get estimatedHoursShort => 'Horas estimadas';

  @override
  String get addressUnset => 'No indicada';

  @override
  String get assignments => 'Asignaciones';

  @override
  String get add => 'Añadir';

  @override
  String errorWith(String error) {
    return 'Error: $error';
  }

  @override
  String get noAssignedMembers => 'Ningún miembro asignado';

  @override
  String get tasks => 'Tareas';

  @override
  String get noTasks => 'Ninguna tarea';

  @override
  String get rosterTitle => 'Mi equipo';

  @override
  String get noTeamMembers => 'No tienes miembros en tu equipo';

  @override
  String get askAdminAssign => 'Pide a un administrador que asigne miembros';

  @override
  String get reportsTitle => 'Informes';

  @override
  String get change => 'Cambiar';

  @override
  String get noReportData => 'No hay datos para el periodo seleccionado';

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
      other: '$n registros',
      one: '$n registro',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gestión de usuarios';

  @override
  String get roleMember => 'Miembro';

  @override
  String get roleManager => 'Responsable';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrador';
}
