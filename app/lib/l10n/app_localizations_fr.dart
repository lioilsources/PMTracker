// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Pointage';

  @override
  String get navJobs => 'Chantiers';

  @override
  String get navRoster => 'Équipe';

  @override
  String get navReports => 'Rapports';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Réessayer';

  @override
  String get loginSubtitle => 'Suivi du temps sur les chantiers';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Saisissez une adresse e-mail valide';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordMin => '6 caractères minimum';

  @override
  String get signIn => 'Se connecter';

  @override
  String get trackingTitle => 'Suivi du temps';

  @override
  String greeting(String name) {
    return 'Bonjour $name !';
  }

  @override
  String get ready => 'Prêt';

  @override
  String get onSite => 'Sur place';

  @override
  String get overrideBadge => 'Dérogation';

  @override
  String get startShift => 'Démarrer le pointage';

  @override
  String get stopShift => 'Arrêter le pointage';

  @override
  String get todayTotal => 'Total du jour';

  @override
  String get pickJob => 'Choisissez un chantier';

  @override
  String get noAssignedActiveJob => 'Aucun chantier actif ne vous est affecté';

  @override
  String get outsideGeofenceTitle => 'Hors de la zone géographique';

  @override
  String get outsideGeofenceBody =>
      'Vous n\'êtes pas sur le lieu du chantier. Indiquez un motif et votre responsable sera informé.';

  @override
  String get overrideReasonLabel => 'Motif de la dérogation';

  @override
  String get cancel => 'Annuler';

  @override
  String get startWithOverride => 'Démarrer avec dérogation';

  @override
  String get locationServicesOff =>
      'Les services de localisation sont désactivés';

  @override
  String get locationDenied => 'Accès à la position refusé';

  @override
  String get locationDeniedForever =>
      'Accès à la position refusé définitivement — autorisez-le dans les réglages';

  @override
  String get jobsTitle => 'Chantiers';

  @override
  String get newJob => 'Nouveau chantier';

  @override
  String get noJobs => 'Aucun chantier';

  @override
  String get createJob => 'Créer un chantier';

  @override
  String plannedHours(String hours) {
    return '$hours h prévues';
  }

  @override
  String get editJob => 'Modifier le chantier';

  @override
  String get jobName => 'Nom du chantier *';

  @override
  String get requiredField => 'Champ obligatoire';

  @override
  String get description => 'Description';

  @override
  String get address => 'Adresse';

  @override
  String get latitude => 'Latitude (lat)';

  @override
  String get longitude => 'Longitude (lon)';

  @override
  String get geofenceRadius => 'Rayon de la zone (m)';

  @override
  String get enterNumber => 'Saisissez un nombre';

  @override
  String get estimatedHours => 'Heures estimées';

  @override
  String get status => 'Statut';

  @override
  String get statusActive => 'Actif';

  @override
  String get statusPaused => 'En pause';

  @override
  String get statusCompleted => 'Terminé';

  @override
  String get statusArchived => 'Archivé';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get jobFallbackTitle => 'Chantier';

  @override
  String get info => 'Informations';

  @override
  String get manager => 'Responsable';

  @override
  String get geofence => 'Zone géographique';

  @override
  String get estimatedHoursShort => 'Heures estimées';

  @override
  String get addressUnset => 'Non renseignée';

  @override
  String get assignments => 'Affectations';

  @override
  String get add => 'Ajouter';

  @override
  String errorWith(String error) {
    return 'Erreur : $error';
  }

  @override
  String get noAssignedMembers => 'Aucun membre affecté';

  @override
  String get tasks => 'Tâches';

  @override
  String get noTasks => 'Aucune tâche';

  @override
  String get rosterTitle => 'Mon équipe';

  @override
  String get noTeamMembers => 'Vous n\'avez aucun membre dans votre équipe';

  @override
  String get askAdminAssign =>
      'Demandez à un administrateur d\'affecter des membres';

  @override
  String get reportsTitle => 'Rapports';

  @override
  String get change => 'Modifier';

  @override
  String get noReportData => 'Aucune donnée pour la période choisie';

  @override
  String totalLabel(String hours) {
    return 'Total : $hours';
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
      other: '$n entrées',
      one: '$n entrée',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Gestion des utilisateurs';

  @override
  String get roleMember => 'Membre';

  @override
  String get roleManager => 'Responsable';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrateur';
}
