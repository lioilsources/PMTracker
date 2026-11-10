// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'സമയം';

  @override
  String get navJobs => 'ജോലികൾ';

  @override
  String get navRoster => 'ടീം';

  @override
  String get navReports => 'റിപ്പോർട്ടുകൾ';

  @override
  String get navAdmin => 'അഡ്മിൻ';

  @override
  String get retry => 'വീണ്ടും ശ്രമിക്കുക';

  @override
  String get loginSubtitle => 'ജോലികളിലെ സമയ രേഖപ്പെടുത്തൽ';

  @override
  String get emailLabel => 'ഇമെയിൽ';

  @override
  String get emailInvalid => 'സാധുവായ ഇമെയിൽ നൽകുക';

  @override
  String get passwordLabel => 'പാസ്‌വേഡ്';

  @override
  String get passwordMin => 'കുറഞ്ഞത് 6 അക്ഷരം';

  @override
  String get signIn => 'സൈൻ ഇൻ';

  @override
  String get trackingTitle => 'സമയ രേഖപ്പെടുത്തൽ';

  @override
  String greeting(String name) {
    return 'നമസ്കാരം, $name!';
  }

  @override
  String get ready => 'തയ്യാർ';

  @override
  String get onSite => 'സ്ഥലത്ത്';

  @override
  String get overrideBadge => 'ഒഴിവാക്കൽ';

  @override
  String get startShift => 'രേഖപ്പെടുത്തൽ തുടങ്ങുക';

  @override
  String get stopShift => 'രേഖപ്പെടുത്തൽ അവസാനിപ്പിക്കുക';

  @override
  String get todayTotal => 'ഇന്നത്തെ ആകെ';

  @override
  String get pickJob => 'ഒരു ജോലി തിരഞ്ഞെടുക്കുക';

  @override
  String get noAssignedActiveJob =>
      'നിങ്ങൾക്ക് സജീവമായ ജോലിയൊന്നും നൽകിയിട്ടില്ല';

  @override
  String get outsideGeofenceTitle => 'ജിയോഫെൻസിന് പുറത്ത്';

  @override
  String get outsideGeofenceBody =>
      'നിങ്ങൾ ജോലിസ്ഥലത്തല്ല. കാരണം നൽകൂ, മാനേജരെ അറിയിക്കും.';

  @override
  String get overrideReasonLabel => 'ഒഴിവാക്കലിന്റെ കാരണം';

  @override
  String get cancel => 'റദ്ദാക്കുക';

  @override
  String get startWithOverride => 'ഒഴിവാക്കലോടെ തുടങ്ങുക';

  @override
  String get locationServicesOff => 'ലൊക്കേഷൻ സേവനങ്ങൾ ഓഫാണ്';

  @override
  String get locationDenied => 'ലൊക്കേഷൻ ആക്സസ് നിരസിച്ചു';

  @override
  String get locationDeniedForever =>
      'ലൊക്കേഷൻ ആക്സസ് സ്ഥിരമായി നിരസിച്ചു — ക്രമീകരണത്തിൽ അനുവദിക്കുക';

  @override
  String get jobsTitle => 'ജോലികൾ';

  @override
  String get newJob => 'പുതിയ ജോലി';

  @override
  String get noJobs => 'ജോലികളൊന്നുമില്ല';

  @override
  String get createJob => 'ജോലി സൃഷ്ടിക്കുക';

  @override
  String plannedHours(String hours) {
    return '$hours മണിക്കൂർ ആസൂത്രണം';
  }

  @override
  String get editJob => 'ജോലി എഡിറ്റ് ചെയ്യുക';

  @override
  String get jobName => 'ജോലിയുടെ പേര് *';

  @override
  String get requiredField => 'നിർബന്ധിത ഫീൽഡ്';

  @override
  String get description => 'വിവരണം';

  @override
  String get address => 'വിലാസം';

  @override
  String get latitude => 'അക്ഷാംശം (lat)';

  @override
  String get longitude => 'രേഖാംശം (lon)';

  @override
  String get geofenceRadius => 'ജിയോഫെൻസ് ആരം (മീ)';

  @override
  String get enterNumber => 'ഒരു സംഖ്യ നൽകുക';

  @override
  String get estimatedHours => 'കണക്കാക്കിയ മണിക്കൂർ';

  @override
  String get status => 'നില';

  @override
  String get statusActive => 'സജീവം';

  @override
  String get statusPaused => 'താൽക്കാലികമായി നിർത്തി';

  @override
  String get statusCompleted => 'പൂർത്തിയായി';

  @override
  String get statusArchived => 'ആർക്കൈവ് ചെയ്തു';

  @override
  String get saveChanges => 'മാറ്റങ്ങൾ സംരക്ഷിക്കുക';

  @override
  String get jobFallbackTitle => 'ജോലി';

  @override
  String get info => 'വിവരങ്ങൾ';

  @override
  String get manager => 'മാനേജർ';

  @override
  String get geofence => 'ജിയോഫെൻസ്';

  @override
  String get estimatedHoursShort => 'കണക്കാക്കിയ മണിക്കൂർ';

  @override
  String get addressUnset => 'നൽകിയിട്ടില്ല';

  @override
  String get assignments => 'നിയോഗങ്ങൾ';

  @override
  String get add => 'ചേർക്കുക';

  @override
  String errorWith(String error) {
    return 'പിശക്: $error';
  }

  @override
  String get noAssignedMembers => 'നിയോഗിച്ച അംഗങ്ങളില്ല';

  @override
  String get tasks => 'ചുമതലകൾ';

  @override
  String get noTasks => 'ചുമതലകളൊന്നുമില്ല';

  @override
  String get rosterTitle => 'എന്റെ ടീം';

  @override
  String get noTeamMembers => 'നിങ്ങളുടെ ടീമിൽ അംഗങ്ങളില്ല';

  @override
  String get askAdminAssign =>
      'അംഗങ്ങളെ നിയോഗിക്കാൻ അഡ്മിനിസ്ട്രേറ്ററോട് ആവശ്യപ്പെടുക';

  @override
  String get reportsTitle => 'റിപ്പോർട്ടുകൾ';

  @override
  String get change => 'മാറ്റുക';

  @override
  String get noReportData => 'തിരഞ്ഞെടുത്ത കാലയളവിൽ ഡാറ്റയില്ല';

  @override
  String totalLabel(String hours) {
    return 'ആകെ: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h മ $m മി';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n രേഖകൾ',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'ഉപയോക്തൃ മാനേജ്മെന്റ്';

  @override
  String get roleMember => 'അംഗം';

  @override
  String get roleManager => 'മാനേജർ';

  @override
  String get roleAdmin => 'അഡ്മിൻ';

  @override
  String get roleAdminFull => 'അഡ്മിനിസ്ട്രേറ്റർ';
}
