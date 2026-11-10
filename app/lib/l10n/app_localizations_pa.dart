// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'ਸਮਾਂ';

  @override
  String get navJobs => 'ਕੰਮ';

  @override
  String get navRoster => 'ਟੀਮ';

  @override
  String get navReports => 'ਰਿਪੋਰਟਾਂ';

  @override
  String get navAdmin => 'ਐਡਮਿਨ';

  @override
  String get retry => 'ਮੁੜ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get loginSubtitle => 'ਕੰਮਾਂ ਉੱਤੇ ਸਮੇਂ ਦਾ ਹਿਸਾਬ';

  @override
  String get emailLabel => 'ਈਮੇਲ';

  @override
  String get emailInvalid => 'ਜਾਇਜ਼ ਈਮੇਲ ਦਾਖਲ ਕਰੋ';

  @override
  String get passwordLabel => 'ਪਾਸਵਰਡ';

  @override
  String get passwordMin => 'ਘੱਟੋ-ਘੱਟ 6 ਅੱਖਰ';

  @override
  String get signIn => 'ਸਾਈਨ ਇਨ ਕਰੋ';

  @override
  String get trackingTitle => 'ਸਮੇਂ ਦੀ ਦਰਜ';

  @override
  String greeting(String name) {
    return 'ਸਤਿ ਸ੍ਰੀ ਅਕਾਲ, $name!';
  }

  @override
  String get ready => 'ਤਿਆਰ';

  @override
  String get onSite => 'ਮੌਕੇ ਉੱਤੇ';

  @override
  String get overrideBadge => 'ਅਪਵਾਦ';

  @override
  String get startShift => 'ਦਰਜ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get stopShift => 'ਦਰਜ ਖ਼ਤਮ ਕਰੋ';

  @override
  String get todayTotal => 'ਅੱਜ ਦਾ ਕੁੱਲ';

  @override
  String get pickJob => 'ਕੰਮ ਚੁਣੋ';

  @override
  String get noAssignedActiveJob => 'ਤੁਹਾਨੂੰ ਕੋਈ ਸਰਗਰਮ ਕੰਮ ਨਹੀਂ ਸੌਂਪਿਆ ਗਿਆ';

  @override
  String get outsideGeofenceTitle => 'ਜੀਓਫੈਂਸ ਤੋਂ ਬਾਹਰ';

  @override
  String get outsideGeofenceBody =>
      'ਤੁਸੀਂ ਕੰਮ ਵਾਲੀ ਥਾਂ ਉੱਤੇ ਨਹੀਂ ਹੋ। ਕਾਰਨ ਦੱਸੋ, ਮੈਨੇਜਰ ਨੂੰ ਸੂਚਿਤ ਕੀਤਾ ਜਾਵੇਗਾ।';

  @override
  String get overrideReasonLabel => 'ਅਪਵਾਦ ਦਾ ਕਾਰਨ';

  @override
  String get cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get startWithOverride => 'ਅਪਵਾਦ ਨਾਲ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get locationServicesOff => 'ਲੋਕੇਸ਼ਨ ਸੇਵਾਵਾਂ ਬੰਦ ਹਨ';

  @override
  String get locationDenied => 'ਲੋਕੇਸ਼ਨ ਦੀ ਇਜਾਜ਼ਤ ਰੱਦ ਕੀਤੀ ਗਈ';

  @override
  String get locationDeniedForever =>
      'ਲੋਕੇਸ਼ਨ ਦੀ ਇਜਾਜ਼ਤ ਹਮੇਸ਼ਾ ਲਈ ਰੱਦ ਕੀਤੀ ਗਈ — ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਇਜਾਜ਼ਤ ਦਿਓ';

  @override
  String get jobsTitle => 'ਕੰਮ';

  @override
  String get newJob => 'ਨਵਾਂ ਕੰਮ';

  @override
  String get noJobs => 'ਕੋਈ ਕੰਮ ਨਹੀਂ';

  @override
  String get createJob => 'ਕੰਮ ਬਣਾਓ';

  @override
  String plannedHours(String hours) {
    return '$hours ਘੰਟੇ ਯੋਜਨਾਬੱਧ';
  }

  @override
  String get editJob => 'ਕੰਮ ਸੋਧੋ';

  @override
  String get jobName => 'ਕੰਮ ਦਾ ਨਾਂ *';

  @override
  String get requiredField => 'ਲਾਜ਼ਮੀ ਖਾਨਾ';

  @override
  String get description => 'ਵੇਰਵਾ';

  @override
  String get address => 'ਪਤਾ';

  @override
  String get latitude => 'ਅਕਸ਼ਾਂਸ਼ (lat)';

  @override
  String get longitude => 'ਦੇਸ਼ਾਂਤਰ (lon)';

  @override
  String get geofenceRadius => 'ਜੀਓਫੈਂਸ ਅਰਧ-ਵਿਆਸ (ਮੀ)';

  @override
  String get enterNumber => 'ਇੱਕ ਨੰਬਰ ਦਾਖਲ ਕਰੋ';

  @override
  String get estimatedHours => 'ਅੰਦਾਜ਼ਨ ਘੰਟੇ';

  @override
  String get status => 'ਸਥਿਤੀ';

  @override
  String get statusActive => 'ਸਰਗਰਮ';

  @override
  String get statusPaused => 'ਰੋਕਿਆ ਹੋਇਆ';

  @override
  String get statusCompleted => 'ਮੁਕੰਮਲ';

  @override
  String get statusArchived => 'ਆਰਕਾਈਵ';

  @override
  String get saveChanges => 'ਤਬਦੀਲੀਆਂ ਸੰਭਾਲੋ';

  @override
  String get jobFallbackTitle => 'ਕੰਮ';

  @override
  String get info => 'ਜਾਣਕਾਰੀ';

  @override
  String get manager => 'ਮੈਨੇਜਰ';

  @override
  String get geofence => 'ਜੀਓਫੈਂਸ';

  @override
  String get estimatedHoursShort => 'ਅੰਦਾਜ਼ਨ ਘੰਟੇ';

  @override
  String get addressUnset => 'ਦਿੱਤਾ ਨਹੀਂ ਗਿਆ';

  @override
  String get assignments => 'ਸੌਂਪਣੀਆਂ';

  @override
  String get add => 'ਜੋੜੋ';

  @override
  String errorWith(String error) {
    return 'ਗਲਤੀ: $error';
  }

  @override
  String get noAssignedMembers => 'ਕੋਈ ਸੌਂਪੇ ਮੈਂਬਰ ਨਹੀਂ';

  @override
  String get tasks => 'ਕਾਰਜ';

  @override
  String get noTasks => 'ਕੋਈ ਕਾਰਜ ਨਹੀਂ';

  @override
  String get rosterTitle => 'ਮੇਰੀ ਟੀਮ';

  @override
  String get noTeamMembers => 'ਤੁਹਾਡੀ ਟੀਮ ਵਿੱਚ ਕੋਈ ਮੈਂਬਰ ਨਹੀਂ';

  @override
  String get askAdminAssign => 'ਮੈਂਬਰ ਸੌਂਪਣ ਲਈ ਐਡਮਿਨ ਨੂੰ ਕਹੋ';

  @override
  String get reportsTitle => 'ਰਿਪੋਰਟਾਂ';

  @override
  String get change => 'ਬਦਲੋ';

  @override
  String get noReportData => 'ਚੁਣੇ ਸਮੇਂ ਲਈ ਕੋਈ ਡੇਟਾ ਨਹੀਂ';

  @override
  String totalLabel(String hours) {
    return 'ਕੁੱਲ: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h ਘੰ $m ਮਿੰ';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n ਦਰਜ',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'ਵਰਤੋਂਕਾਰ ਪ੍ਰਬੰਧ';

  @override
  String get roleMember => 'ਮੈਂਬਰ';

  @override
  String get roleManager => 'ਮੈਨੇਜਰ';

  @override
  String get roleAdmin => 'ਐਡਮਿਨ';

  @override
  String get roleAdminFull => 'ਪ੍ਰਸ਼ਾਸਕ';
}
