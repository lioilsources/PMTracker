// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Time';

  @override
  String get navJobs => 'Jobs';

  @override
  String get navRoster => 'Roster';

  @override
  String get navReports => 'Reports';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Try again';

  @override
  String get loginSubtitle => 'Time tracking on jobs';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordMin => 'At least 6 characters';

  @override
  String get signIn => 'Sign in';

  @override
  String get trackingTitle => 'Time tracking';

  @override
  String greeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get ready => 'Ready';

  @override
  String get onSite => 'On site';

  @override
  String get overrideBadge => 'Override';

  @override
  String get startShift => 'Start tracking';

  @override
  String get stopShift => 'Stop tracking';

  @override
  String get todayTotal => 'Total today';

  @override
  String get pickJob => 'Choose a job';

  @override
  String get noAssignedActiveJob => 'You are not assigned to any active job';

  @override
  String get outsideGeofenceTitle => 'Outside the geofence';

  @override
  String get outsideGeofenceBody =>
      'You are not at the job site. Give a reason and your manager will be informed.';

  @override
  String get overrideReasonLabel => 'Override reason';

  @override
  String get cancel => 'Cancel';

  @override
  String get startWithOverride => 'Start with override';

  @override
  String get locationServicesOff => 'Location services are turned off';

  @override
  String get locationDenied => 'Location access denied';

  @override
  String get locationDeniedForever =>
      'Location access permanently denied — allow it in settings';

  @override
  String get jobsTitle => 'Jobs';

  @override
  String get newJob => 'New job';

  @override
  String get noJobs => 'No jobs';

  @override
  String get createJob => 'Create job';

  @override
  String plannedHours(String hours) {
    return '$hours h planned';
  }

  @override
  String get editJob => 'Edit job';

  @override
  String get jobName => 'Job name *';

  @override
  String get requiredField => 'Required field';

  @override
  String get description => 'Description';

  @override
  String get address => 'Address';

  @override
  String get latitude => 'Latitude (lat)';

  @override
  String get longitude => 'Longitude (lon)';

  @override
  String get geofenceRadius => 'Geofence radius (m)';

  @override
  String get enterNumber => 'Enter a number';

  @override
  String get estimatedHours => 'Estimated hours';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Active';

  @override
  String get statusPaused => 'Paused';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusArchived => 'Archived';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get jobFallbackTitle => 'Job';

  @override
  String get info => 'Information';

  @override
  String get manager => 'Manager';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Estimated hours';

  @override
  String get addressUnset => 'Not set';

  @override
  String get assignments => 'Assignments';

  @override
  String get add => 'Add';

  @override
  String errorWith(String error) {
    return 'Error: $error';
  }

  @override
  String get noAssignedMembers => 'No assigned members';

  @override
  String get tasks => 'Tasks';

  @override
  String get noTasks => 'No tasks';

  @override
  String get rosterTitle => 'My team';

  @override
  String get noTeamMembers => 'You have no team members';

  @override
  String get askAdminAssign => 'Ask an administrator to assign members';

  @override
  String get reportsTitle => 'Reports';

  @override
  String get change => 'Change';

  @override
  String get noReportData => 'No data for the selected period';

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
      other: '$n entries',
      one: '$n entry',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'User management';

  @override
  String get roleMember => 'Member';

  @override
  String get roleManager => 'Manager';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrator';
}
