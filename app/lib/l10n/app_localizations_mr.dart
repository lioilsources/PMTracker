// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'वेळ';

  @override
  String get navJobs => 'कामे';

  @override
  String get navRoster => 'टीम';

  @override
  String get navReports => 'अहवाल';

  @override
  String get navAdmin => 'अॅडमिन';

  @override
  String get retry => 'पुन्हा प्रयत्न करा';

  @override
  String get loginSubtitle => 'कामांवरील वेळेची नोंद';

  @override
  String get emailLabel => 'ईमेल';

  @override
  String get emailInvalid => 'वैध ईमेल टाका';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get passwordMin => 'किमान 6 अक्षरे';

  @override
  String get signIn => 'साइन इन';

  @override
  String get trackingTitle => 'वेळेची नोंद';

  @override
  String greeting(String name) {
    return 'नमस्कार, $name!';
  }

  @override
  String get ready => 'तयार';

  @override
  String get onSite => 'साइटवर';

  @override
  String get overrideBadge => 'अपवाद';

  @override
  String get startShift => 'नोंद सुरू करा';

  @override
  String get stopShift => 'नोंद थांबवा';

  @override
  String get todayTotal => 'आजचा एकूण';

  @override
  String get pickJob => 'काम निवडा';

  @override
  String get noAssignedActiveJob => 'तुम्हाला कोणतेही सक्रिय काम सोपवलेले नाही';

  @override
  String get outsideGeofenceTitle => 'जिओफेन्सच्या बाहेर';

  @override
  String get outsideGeofenceBody =>
      'तुम्ही कामाच्या ठिकाणी नाही. कारण सांगा, मॅनेजरला कळवले जाईल.';

  @override
  String get overrideReasonLabel => 'अपवादाचे कारण';

  @override
  String get cancel => 'रद्द करा';

  @override
  String get startWithOverride => 'अपवादासह सुरू करा';

  @override
  String get locationServicesOff => 'लोकेशन सेवा बंद आहेत';

  @override
  String get locationDenied => 'लोकेशनचा प्रवेश नाकारला';

  @override
  String get locationDeniedForever =>
      'लोकेशनचा प्रवेश कायमचा नाकारला — सेटिंग्जमध्ये परवानगी द्या';

  @override
  String get jobsTitle => 'कामे';

  @override
  String get newJob => 'नवीन काम';

  @override
  String get noJobs => 'कोणतीही कामे नाहीत';

  @override
  String get createJob => 'काम तयार करा';

  @override
  String plannedHours(String hours) {
    return '$hours तास नियोजित';
  }

  @override
  String get editJob => 'काम संपादित करा';

  @override
  String get jobName => 'कामाचे नाव *';

  @override
  String get requiredField => 'आवश्यक रकाना';

  @override
  String get description => 'वर्णन';

  @override
  String get address => 'पत्ता';

  @override
  String get latitude => 'अक्षांश (lat)';

  @override
  String get longitude => 'रेखांश (lon)';

  @override
  String get geofenceRadius => 'जिओफेन्स त्रिज्या (मी)';

  @override
  String get enterNumber => 'संख्या टाका';

  @override
  String get estimatedHours => 'अंदाजे तास';

  @override
  String get status => 'स्थिती';

  @override
  String get statusActive => 'सक्रिय';

  @override
  String get statusPaused => 'थांबवलेले';

  @override
  String get statusCompleted => 'पूर्ण';

  @override
  String get statusArchived => 'संग्रहित';

  @override
  String get saveChanges => 'बदल जतन करा';

  @override
  String get jobFallbackTitle => 'काम';

  @override
  String get info => 'माहिती';

  @override
  String get manager => 'मॅनेजर';

  @override
  String get geofence => 'जिओफेन्स';

  @override
  String get estimatedHoursShort => 'अंदाजे तास';

  @override
  String get addressUnset => 'दिलेला नाही';

  @override
  String get assignments => 'नेमणुका';

  @override
  String get add => 'जोडा';

  @override
  String errorWith(String error) {
    return 'त्रुटी: $error';
  }

  @override
  String get noAssignedMembers => 'नेमलेले सदस्य नाहीत';

  @override
  String get tasks => 'कार्ये';

  @override
  String get noTasks => 'कोणतीही कार्ये नाहीत';

  @override
  String get rosterTitle => 'माझी टीम';

  @override
  String get noTeamMembers => 'तुमच्या टीममध्ये सदस्य नाहीत';

  @override
  String get askAdminAssign => 'सदस्य नेमण्यासाठी अॅडमिनला सांगा';

  @override
  String get reportsTitle => 'अहवाल';

  @override
  String get change => 'बदला';

  @override
  String get noReportData => 'निवडलेल्या कालावधीसाठी डेटा नाही';

  @override
  String totalLabel(String hours) {
    return 'एकूण: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h तास $m मि';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n नोंदी',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'वापरकर्ता व्यवस्थापन';

  @override
  String get roleMember => 'सदस्य';

  @override
  String get roleManager => 'मॅनेजर';

  @override
  String get roleAdmin => 'अॅडमिन';

  @override
  String get roleAdminFull => 'प्रशासक';
}
