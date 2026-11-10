// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'وقت';

  @override
  String get navJobs => 'کام';

  @override
  String get navRoster => 'ٹیم';

  @override
  String get navReports => 'رپورٹیں';

  @override
  String get navAdmin => 'ایڈمن';

  @override
  String get retry => 'دوبارہ کوشش کریں';

  @override
  String get loginSubtitle => 'کاموں پر وقت کا اندراج';

  @override
  String get emailLabel => 'ای میل';

  @override
  String get emailInvalid => 'درست ای میل درج کریں';

  @override
  String get passwordLabel => 'پاس ورڈ';

  @override
  String get passwordMin => 'کم از کم 6 حروف';

  @override
  String get signIn => 'سائن اِن کریں';

  @override
  String get trackingTitle => 'وقت کا اندراج';

  @override
  String greeting(String name) {
    return 'السلام علیکم، $name!';
  }

  @override
  String get ready => 'تیار';

  @override
  String get onSite => 'موقع پر';

  @override
  String get overrideBadge => 'استثنا';

  @override
  String get startShift => 'اندراج شروع کریں';

  @override
  String get stopShift => 'اندراج ختم کریں';

  @override
  String get todayTotal => 'آج کا کل';

  @override
  String get pickJob => 'کام منتخب کریں';

  @override
  String get noAssignedActiveJob => 'آپ کو کوئی فعال کام تفویض نہیں کیا گیا';

  @override
  String get outsideGeofenceTitle => 'جیو فینس سے باہر';

  @override
  String get outsideGeofenceBody =>
      'آپ کام کی جگہ پر نہیں ہیں۔ وجہ بتائیں، مینیجر کو مطلع کیا جائے گا۔';

  @override
  String get overrideReasonLabel => 'استثنا کی وجہ';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get startWithOverride => 'استثنا کے ساتھ شروع کریں';

  @override
  String get locationServicesOff => 'مقام کی خدمات بند ہیں';

  @override
  String get locationDenied => 'مقام تک رسائی مسترد کر دی گئی';

  @override
  String get locationDeniedForever =>
      'مقام تک رسائی مستقل طور پر مسترد کر دی گئی — ترتیبات میں اجازت دیں';

  @override
  String get jobsTitle => 'کام';

  @override
  String get newJob => 'نیا کام';

  @override
  String get noJobs => 'کوئی کام نہیں';

  @override
  String get createJob => 'کام بنائیں';

  @override
  String plannedHours(String hours) {
    return '$hours گھنٹے منصوبہ بند';
  }

  @override
  String get editJob => 'کام میں ترمیم کریں';

  @override
  String get jobName => 'کام کا نام *';

  @override
  String get requiredField => 'لازمی خانہ';

  @override
  String get description => 'تفصیل';

  @override
  String get address => 'پتہ';

  @override
  String get latitude => 'عرض بلد (lat)';

  @override
  String get longitude => 'طول بلد (lon)';

  @override
  String get geofenceRadius => 'جیو فینس رداس (میٹر)';

  @override
  String get enterNumber => 'نمبر درج کریں';

  @override
  String get estimatedHours => 'تخمینی گھنٹے';

  @override
  String get status => 'حالت';

  @override
  String get statusActive => 'فعال';

  @override
  String get statusPaused => 'روکا ہوا';

  @override
  String get statusCompleted => 'مکمل';

  @override
  String get statusArchived => 'آرکائیو';

  @override
  String get saveChanges => 'تبدیلیاں محفوظ کریں';

  @override
  String get jobFallbackTitle => 'کام';

  @override
  String get info => 'معلومات';

  @override
  String get manager => 'مینیجر';

  @override
  String get geofence => 'جیو فینس';

  @override
  String get estimatedHoursShort => 'تخمینی گھنٹے';

  @override
  String get addressUnset => 'درج نہیں';

  @override
  String get assignments => 'تفویضات';

  @override
  String get add => 'شامل کریں';

  @override
  String errorWith(String error) {
    return 'خرابی: $error';
  }

  @override
  String get noAssignedMembers => 'کوئی تفویض کردہ رکن نہیں';

  @override
  String get tasks => 'کام کی فہرست';

  @override
  String get noTasks => 'کوئی کام نہیں';

  @override
  String get rosterTitle => 'میری ٹیم';

  @override
  String get noTeamMembers => 'آپ کی ٹیم میں کوئی رکن نہیں';

  @override
  String get askAdminAssign => 'ارکان تفویض کرنے کے لیے ایڈمن سے کہیں';

  @override
  String get reportsTitle => 'رپورٹیں';

  @override
  String get change => 'تبدیل کریں';

  @override
  String get noReportData => 'منتخب مدت کے لیے کوئی ڈیٹا نہیں';

  @override
  String totalLabel(String hours) {
    return 'کل: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h گھ $m منٹ';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n اندراجات',
      one: '$n اندراج',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'صارفین کا نظم';

  @override
  String get roleMember => 'رکن';

  @override
  String get roleManager => 'مینیجر';

  @override
  String get roleAdmin => 'ایڈمن';

  @override
  String get roleAdminFull => 'منتظم';
}
