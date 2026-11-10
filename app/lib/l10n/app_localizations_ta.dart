// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'நேரம்';

  @override
  String get navJobs => 'பணிகள்';

  @override
  String get navRoster => 'குழு';

  @override
  String get navReports => 'அறிக்கைகள்';

  @override
  String get navAdmin => 'நிர்வாகம்';

  @override
  String get retry => 'மீண்டும் முயல்க';

  @override
  String get loginSubtitle => 'பணிகளில் நேரப் பதிவு';

  @override
  String get emailLabel => 'மின்னஞ்சல்';

  @override
  String get emailInvalid => 'சரியான மின்னஞ்சலை உள்ளிடுங்கள்';

  @override
  String get passwordLabel => 'கடவுச்சொல்';

  @override
  String get passwordMin => 'குறைந்தது 6 எழுத்துகள்';

  @override
  String get signIn => 'உள்நுழை';

  @override
  String get trackingTitle => 'நேரப் பதிவு';

  @override
  String greeting(String name) {
    return 'வணக்கம், $name!';
  }

  @override
  String get ready => 'தயார்';

  @override
  String get onSite => 'பணியிடத்தில்';

  @override
  String get overrideBadge => 'விதிவிலக்கு';

  @override
  String get startShift => 'பதிவைத் தொடங்கு';

  @override
  String get stopShift => 'பதிவை முடி';

  @override
  String get todayTotal => 'இன்றைய மொத்தம்';

  @override
  String get pickJob => 'ஒரு பணியைத் தேர்ந்தெடுங்கள்';

  @override
  String get noAssignedActiveJob =>
      'உங்களுக்கு செயலில் உள்ள பணி எதுவும் ஒதுக்கப்படவில்லை';

  @override
  String get outsideGeofenceTitle => 'ஜியோஃபென்ஸுக்கு வெளியே';

  @override
  String get outsideGeofenceBody =>
      'நீங்கள் பணியிடத்தில் இல்லை. காரணத்தைக் குறிப்பிடுங்கள், மேலாளருக்குத் தெரிவிக்கப்படும்.';

  @override
  String get overrideReasonLabel => 'விதிவிலக்கின் காரணம்';

  @override
  String get cancel => 'ரத்து';

  @override
  String get startWithOverride => 'விதிவிலக்குடன் தொடங்கு';

  @override
  String get locationServicesOff => 'இருப்பிட சேவைகள் அணைக்கப்பட்டுள்ளன';

  @override
  String get locationDenied => 'இருப்பிட அணுகல் மறுக்கப்பட்டது';

  @override
  String get locationDeniedForever =>
      'இருப்பிட அணுகல் நிரந்தரமாக மறுக்கப்பட்டது — அமைப்புகளில் அனுமதியுங்கள்';

  @override
  String get jobsTitle => 'பணிகள்';

  @override
  String get newJob => 'புதிய பணி';

  @override
  String get noJobs => 'பணிகள் இல்லை';

  @override
  String get createJob => 'பணியை உருவாக்கு';

  @override
  String plannedHours(String hours) {
    return '$hours மணி திட்டமிடப்பட்டது';
  }

  @override
  String get editJob => 'பணியைத் திருத்து';

  @override
  String get jobName => 'பணியின் பெயர் *';

  @override
  String get requiredField => 'கட்டாயப் புலம்';

  @override
  String get description => 'விளக்கம்';

  @override
  String get address => 'முகவரி';

  @override
  String get latitude => 'அட்சரேகை (lat)';

  @override
  String get longitude => 'தீர்க்கரேகை (lon)';

  @override
  String get geofenceRadius => 'ஜியோஃபென்ஸ் ஆரம் (மீ)';

  @override
  String get enterNumber => 'ஓர் எண்ணை உள்ளிடுங்கள்';

  @override
  String get estimatedHours => 'மதிப்பிடப்பட்ட மணிநேரம்';

  @override
  String get status => 'நிலை';

  @override
  String get statusActive => 'செயலில்';

  @override
  String get statusPaused => 'இடைநிறுத்தம்';

  @override
  String get statusCompleted => 'முடிந்தது';

  @override
  String get statusArchived => 'காப்பகம்';

  @override
  String get saveChanges => 'மாற்றங்களைச் சேமி';

  @override
  String get jobFallbackTitle => 'பணி';

  @override
  String get info => 'தகவல்';

  @override
  String get manager => 'மேலாளர்';

  @override
  String get geofence => 'ஜியோஃபென்ஸ்';

  @override
  String get estimatedHoursShort => 'மதிப்பிடப்பட்ட மணிநேரம்';

  @override
  String get addressUnset => 'குறிப்பிடப்படவில்லை';

  @override
  String get assignments => 'ஒதுக்கீடுகள்';

  @override
  String get add => 'சேர்';

  @override
  String errorWith(String error) {
    return 'பிழை: $error';
  }

  @override
  String get noAssignedMembers => 'ஒதுக்கப்பட்ட உறுப்பினர்கள் இல்லை';

  @override
  String get tasks => 'பணிகள் (பட்டியல்)';

  @override
  String get noTasks => 'பணிகள் இல்லை';

  @override
  String get rosterTitle => 'எனது குழு';

  @override
  String get noTeamMembers => 'உங்கள் குழுவில் உறுப்பினர்கள் இல்லை';

  @override
  String get askAdminAssign => 'உறுப்பினர்களை ஒதுக்க நிர்வாகியிடம் கேளுங்கள்';

  @override
  String get reportsTitle => 'அறிக்கைகள்';

  @override
  String get change => 'மாற்று';

  @override
  String get noReportData => 'தேர்ந்தெடுத்த காலத்திற்குத் தரவு இல்லை';

  @override
  String totalLabel(String hours) {
    return 'மொத்தம்: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h மணி $m நிமி';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n பதிவுகள்',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'பயனர் மேலாண்மை';

  @override
  String get roleMember => 'உறுப்பினர்';

  @override
  String get roleManager => 'மேலாளர்';

  @override
  String get roleAdmin => 'நிர்வாகி';

  @override
  String get roleAdminFull => 'நிர்வாகி';
}
