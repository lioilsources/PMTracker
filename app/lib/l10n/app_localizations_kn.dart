// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'ಸಮಯ';

  @override
  String get navJobs => 'ಕೆಲಸಗಳು';

  @override
  String get navRoster => 'ತಂಡ';

  @override
  String get navReports => 'ವರದಿಗಳು';

  @override
  String get navAdmin => 'ಅಡ್ಮಿನ್';

  @override
  String get retry => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get loginSubtitle => 'ಕೆಲಸಗಳ ಮೇಲೆ ಸಮಯ ದಾಖಲಾತಿ';

  @override
  String get emailLabel => 'ಇಮೇಲ್';

  @override
  String get emailInvalid => 'ಮಾನ್ಯ ಇಮೇಲ್ ನಮೂದಿಸಿ';

  @override
  String get passwordLabel => 'ಪಾಸ್‌ವರ್ಡ್';

  @override
  String get passwordMin => 'ಕನಿಷ್ಠ 6 ಅಕ್ಷರಗಳು';

  @override
  String get signIn => 'ಸೈನ್ ಇನ್';

  @override
  String get trackingTitle => 'ಸಮಯ ದಾಖಲಾತಿ';

  @override
  String greeting(String name) {
    return 'ನಮಸ್ಕಾರ, $name!';
  }

  @override
  String get ready => 'ಸಿದ್ಧ';

  @override
  String get onSite => 'ಸ್ಥಳದಲ್ಲಿ';

  @override
  String get overrideBadge => 'ವಿನಾಯಿತಿ';

  @override
  String get startShift => 'ದಾಖಲಾತಿ ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get stopShift => 'ದಾಖಲಾತಿ ಮುಗಿಸಿ';

  @override
  String get todayTotal => 'ಇಂದಿನ ಒಟ್ಟು';

  @override
  String get pickJob => 'ಕೆಲಸ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get noAssignedActiveJob => 'ನಿಮಗೆ ಯಾವುದೇ ಸಕ್ರಿಯ ಕೆಲಸ ನಿಯೋಜಿಸಿಲ್ಲ';

  @override
  String get outsideGeofenceTitle => 'ಜಿಯೋಫೆನ್ಸ್ ಹೊರಗೆ';

  @override
  String get outsideGeofenceBody =>
      'ನೀವು ಕೆಲಸದ ಸ್ಥಳದಲ್ಲಿಲ್ಲ. ಕಾರಣ ತಿಳಿಸಿ, ಮ್ಯಾನೇಜರ್‌ಗೆ ತಿಳಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get overrideReasonLabel => 'ವಿನಾಯಿತಿಯ ಕಾರಣ';

  @override
  String get cancel => 'ರದ್ದುಮಾಡಿ';

  @override
  String get startWithOverride => 'ವಿನಾಯಿತಿಯೊಂದಿಗೆ ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get locationServicesOff => 'ಸ್ಥಳ ಸೇವೆಗಳು ಆಫ್ ಆಗಿವೆ';

  @override
  String get locationDenied => 'ಸ್ಥಳದ ಪ್ರವೇಶ ನಿರಾಕರಿಸಲಾಗಿದೆ';

  @override
  String get locationDeniedForever =>
      'ಸ್ಥಳದ ಪ್ರವೇಶ ಶಾಶ್ವತವಾಗಿ ನಿರಾಕರಿಸಲಾಗಿದೆ — ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ ಅನುಮತಿಸಿ';

  @override
  String get jobsTitle => 'ಕೆಲಸಗಳು';

  @override
  String get newJob => 'ಹೊಸ ಕೆಲಸ';

  @override
  String get noJobs => 'ಯಾವುದೇ ಕೆಲಸಗಳಿಲ್ಲ';

  @override
  String get createJob => 'ಕೆಲಸ ರಚಿಸಿ';

  @override
  String plannedHours(String hours) {
    return '$hours ಗಂಟೆ ಯೋಜಿತ';
  }

  @override
  String get editJob => 'ಕೆಲಸ ತಿದ್ದಿ';

  @override
  String get jobName => 'ಕೆಲಸದ ಹೆಸರು *';

  @override
  String get requiredField => 'ಕಡ್ಡಾಯ ಕ್ಷೇತ್ರ';

  @override
  String get description => 'ವಿವರಣೆ';

  @override
  String get address => 'ವಿಳಾಸ';

  @override
  String get latitude => 'ಅಕ್ಷಾಂಶ (lat)';

  @override
  String get longitude => 'ರೇಖಾಂಶ (lon)';

  @override
  String get geofenceRadius => 'ಜಿಯೋಫೆನ್ಸ್ ತ್ರಿಜ್ಯ (ಮೀ)';

  @override
  String get enterNumber => 'ಸಂಖ್ಯೆ ನಮೂದಿಸಿ';

  @override
  String get estimatedHours => 'ಅಂದಾಜು ಗಂಟೆಗಳು';

  @override
  String get status => 'ಸ್ಥಿತಿ';

  @override
  String get statusActive => 'ಸಕ್ರಿಯ';

  @override
  String get statusPaused => 'ತಾತ್ಕಾಲಿಕ ನಿಲುಗಡೆ';

  @override
  String get statusCompleted => 'ಪೂರ್ಣಗೊಂಡಿದೆ';

  @override
  String get statusArchived => 'ಆರ್ಕೈವ್';

  @override
  String get saveChanges => 'ಬದಲಾವಣೆ ಉಳಿಸಿ';

  @override
  String get jobFallbackTitle => 'ಕೆಲಸ';

  @override
  String get info => 'ಮಾಹಿತಿ';

  @override
  String get manager => 'ಮ್ಯಾನೇಜರ್';

  @override
  String get geofence => 'ಜಿಯೋಫೆನ್ಸ್';

  @override
  String get estimatedHoursShort => 'ಅಂದಾಜು ಗಂಟೆಗಳು';

  @override
  String get addressUnset => 'ನಮೂದಿಸಿಲ್ಲ';

  @override
  String get assignments => 'ನಿಯೋಜನೆಗಳು';

  @override
  String get add => 'ಸೇರಿಸಿ';

  @override
  String errorWith(String error) {
    return 'ದೋಷ: $error';
  }

  @override
  String get noAssignedMembers => 'ನಿಯೋಜಿತ ಸದಸ್ಯರಿಲ್ಲ';

  @override
  String get tasks => 'ಕಾರ್ಯಗಳು';

  @override
  String get noTasks => 'ಯಾವುದೇ ಕಾರ್ಯಗಳಿಲ್ಲ';

  @override
  String get rosterTitle => 'ನನ್ನ ತಂಡ';

  @override
  String get noTeamMembers => 'ನಿಮ್ಮ ತಂಡದಲ್ಲಿ ಸದಸ್ಯರಿಲ್ಲ';

  @override
  String get askAdminAssign => 'ಸದಸ್ಯರನ್ನು ನಿಯೋಜಿಸಲು ಅಡ್ಮಿನ್‌ಗೆ ಕೇಳಿ';

  @override
  String get reportsTitle => 'ವರದಿಗಳು';

  @override
  String get change => 'ಬದಲಿಸಿ';

  @override
  String get noReportData => 'ಆಯ್ದ ಅವಧಿಗೆ ಯಾವುದೇ ಡೇಟಾ ಇಲ್ಲ';

  @override
  String totalLabel(String hours) {
    return 'ಒಟ್ಟು: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h ಗಂ $m ನಿ';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ದಾಖಲೆಗಳು',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'ಬಳಕೆದಾರ ನಿರ್ವಹಣೆ';

  @override
  String get roleMember => 'ಸದಸ್ಯ';

  @override
  String get roleManager => 'ಮ್ಯಾನೇಜರ್';

  @override
  String get roleAdmin => 'ಅಡ್ಮಿನ್';

  @override
  String get roleAdminFull => 'ನಿರ್ವಾಹಕ';
}
