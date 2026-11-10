// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Tid';

  @override
  String get navJobs => 'Uppdrag';

  @override
  String get navRoster => 'Team';

  @override
  String get navReports => 'Rapporter';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Försök igen';

  @override
  String get loginSubtitle => 'Tidrapportering på uppdrag';

  @override
  String get emailLabel => 'E-post';

  @override
  String get emailInvalid => 'Ange en giltig e-postadress';

  @override
  String get passwordLabel => 'Lösenord';

  @override
  String get passwordMin => 'Minst 6 tecken';

  @override
  String get signIn => 'Logga in';

  @override
  String get trackingTitle => 'Tidrapportering';

  @override
  String greeting(String name) {
    return 'Hej, $name!';
  }

  @override
  String get ready => 'Redo';

  @override
  String get onSite => 'På plats';

  @override
  String get overrideBadge => 'Undantag';

  @override
  String get startShift => 'Starta tidrapportering';

  @override
  String get stopShift => 'Avsluta tidrapportering';

  @override
  String get todayTotal => 'Totalt idag';

  @override
  String get pickJob => 'Välj ett uppdrag';

  @override
  String get noAssignedActiveJob => 'Du har inget aktivt uppdrag tilldelat';

  @override
  String get outsideGeofenceTitle => 'Utanför geofence';

  @override
  String get outsideGeofenceBody =>
      'Du är inte på uppdragsplatsen. Ange en orsak så får din chef besked.';

  @override
  String get overrideReasonLabel => 'Orsak till undantaget';

  @override
  String get cancel => 'Avbryt';

  @override
  String get startWithOverride => 'Starta med undantag';

  @override
  String get locationServicesOff => 'Platstjänster är avstängda';

  @override
  String get locationDenied => 'Åtkomst till plats nekad';

  @override
  String get locationDeniedForever =>
      'Åtkomst till plats nekad permanent — tillåt den i inställningarna';

  @override
  String get jobsTitle => 'Uppdrag';

  @override
  String get newJob => 'Nytt uppdrag';

  @override
  String get noJobs => 'Inga uppdrag';

  @override
  String get createJob => 'Skapa uppdrag';

  @override
  String plannedHours(String hours) {
    return '$hours h planerat';
  }

  @override
  String get editJob => 'Redigera uppdrag';

  @override
  String get jobName => 'Uppdragsnamn *';

  @override
  String get requiredField => 'Obligatoriskt fält';

  @override
  String get description => 'Beskrivning';

  @override
  String get address => 'Adress';

  @override
  String get latitude => 'Latitud (lat)';

  @override
  String get longitude => 'Longitud (lon)';

  @override
  String get geofenceRadius => 'Geofence-radie (m)';

  @override
  String get enterNumber => 'Ange ett tal';

  @override
  String get estimatedHours => 'Beräknade timmar';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Aktivt';

  @override
  String get statusPaused => 'Pausat';

  @override
  String get statusCompleted => 'Slutfört';

  @override
  String get statusArchived => 'Arkiverat';

  @override
  String get saveChanges => 'Spara ändringar';

  @override
  String get jobFallbackTitle => 'Uppdrag';

  @override
  String get info => 'Information';

  @override
  String get manager => 'Chef';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Beräknade timmar';

  @override
  String get addressUnset => 'Ej angiven';

  @override
  String get assignments => 'Tilldelningar';

  @override
  String get add => 'Lägg till';

  @override
  String errorWith(String error) {
    return 'Fel: $error';
  }

  @override
  String get noAssignedMembers => 'Inga tilldelade medlemmar';

  @override
  String get tasks => 'Uppgifter';

  @override
  String get noTasks => 'Inga uppgifter';

  @override
  String get rosterTitle => 'Mitt team';

  @override
  String get noTeamMembers => 'Du har inga medlemmar i teamet';

  @override
  String get askAdminAssign => 'Be en administratör tilldela medlemmar';

  @override
  String get reportsTitle => 'Rapporter';

  @override
  String get change => 'Ändra';

  @override
  String get noReportData => 'Inga data för vald period';

  @override
  String totalLabel(String hours) {
    return 'Totalt: $hours';
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
      other: '$n poster',
      one: '$n post',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Användarhantering';

  @override
  String get roleMember => 'Medlem';

  @override
  String get roleManager => 'Chef';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administratör';
}
