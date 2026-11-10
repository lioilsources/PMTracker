// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'समय';

  @override
  String get navJobs => 'काम';

  @override
  String get navRoster => 'टीम';

  @override
  String get navReports => 'रिपोर्ट';

  @override
  String get navAdmin => 'एडमिन';

  @override
  String get retry => 'फिर कोशिश करें';

  @override
  String get loginSubtitle => 'कामों पर समय का हिसाब';

  @override
  String get emailLabel => 'ईमेल';

  @override
  String get emailInvalid => 'मान्य ईमेल दर्ज करें';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get passwordMin => 'कम से कम 6 अक्षर';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get trackingTitle => 'समय दर्ज करना';

  @override
  String greeting(String name) {
    return 'नमस्ते, $name!';
  }

  @override
  String get ready => 'तैयार';

  @override
  String get onSite => 'साइट पर';

  @override
  String get overrideBadge => 'अपवाद';

  @override
  String get startShift => 'दर्ज करना शुरू करें';

  @override
  String get stopShift => 'दर्ज करना बंद करें';

  @override
  String get todayTotal => 'आज कुल';

  @override
  String get pickJob => 'काम चुनें';

  @override
  String get noAssignedActiveJob => 'आपको कोई सक्रिय काम नहीं सौंपा गया है';

  @override
  String get outsideGeofenceTitle => 'जियोफ़ेंस के बाहर';

  @override
  String get outsideGeofenceBody =>
      'आप काम की जगह पर नहीं हैं। कारण बताएँ, मैनेजर को सूचित किया जाएगा।';

  @override
  String get overrideReasonLabel => 'अपवाद का कारण';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get startWithOverride => 'अपवाद के साथ शुरू करें';

  @override
  String get locationServicesOff => 'लोकेशन सेवाएँ बंद हैं';

  @override
  String get locationDenied => 'लोकेशन की अनुमति अस्वीकृत';

  @override
  String get locationDeniedForever =>
      'लोकेशन की अनुमति हमेशा के लिए अस्वीकृत — सेटिंग में अनुमति दें';

  @override
  String get jobsTitle => 'काम';

  @override
  String get newJob => 'नया काम';

  @override
  String get noJobs => 'कोई काम नहीं';

  @override
  String get createJob => 'काम बनाएँ';

  @override
  String plannedHours(String hours) {
    return '$hours घंटे नियोजित';
  }

  @override
  String get editJob => 'काम संपादित करें';

  @override
  String get jobName => 'काम का नाम *';

  @override
  String get requiredField => 'आवश्यक फ़ील्ड';

  @override
  String get description => 'विवरण';

  @override
  String get address => 'पता';

  @override
  String get latitude => 'अक्षांश (lat)';

  @override
  String get longitude => 'देशांतर (lon)';

  @override
  String get geofenceRadius => 'जियोफ़ेंस त्रिज्या (मी)';

  @override
  String get enterNumber => 'संख्या दर्ज करें';

  @override
  String get estimatedHours => 'अनुमानित घंटे';

  @override
  String get status => 'स्थिति';

  @override
  String get statusActive => 'सक्रिय';

  @override
  String get statusPaused => 'रुका हुआ';

  @override
  String get statusCompleted => 'पूर्ण';

  @override
  String get statusArchived => 'संग्रहीत';

  @override
  String get saveChanges => 'बदलाव सहेजें';

  @override
  String get jobFallbackTitle => 'काम';

  @override
  String get info => 'जानकारी';

  @override
  String get manager => 'मैनेजर';

  @override
  String get geofence => 'जियोफ़ेंस';

  @override
  String get estimatedHoursShort => 'अनुमानित घंटे';

  @override
  String get addressUnset => 'नहीं दिया गया';

  @override
  String get assignments => 'असाइनमेंट';

  @override
  String get add => 'जोड़ें';

  @override
  String errorWith(String error) {
    return 'त्रुटि: $error';
  }

  @override
  String get noAssignedMembers => 'कोई असाइन किए गए सदस्य नहीं';

  @override
  String get tasks => 'कार्य';

  @override
  String get noTasks => 'कोई कार्य नहीं';

  @override
  String get rosterTitle => 'मेरी टीम';

  @override
  String get noTeamMembers => 'आपकी टीम में कोई सदस्य नहीं है';

  @override
  String get askAdminAssign => 'सदस्य असाइन करने के लिए एडमिन से कहें';

  @override
  String get reportsTitle => 'रिपोर्ट';

  @override
  String get change => 'बदलें';

  @override
  String get noReportData => 'चुनी हुई अवधि के लिए कोई डेटा नहीं';

  @override
  String totalLabel(String hours) {
    return 'कुल: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h घं $m मि';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n प्रविष्टियाँ',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'उपयोगकर्ता प्रबंधन';

  @override
  String get roleMember => 'सदस्य';

  @override
  String get roleManager => 'मैनेजर';

  @override
  String get roleAdmin => 'एडमिन';

  @override
  String get roleAdminFull => 'प्रशासक';
}
