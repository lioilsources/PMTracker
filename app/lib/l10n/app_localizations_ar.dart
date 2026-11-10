// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'التسجيل';

  @override
  String get navJobs => 'المهام';

  @override
  String get navRoster => 'الفريق';

  @override
  String get navReports => 'التقارير';

  @override
  String get navAdmin => 'الإدارة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get loginSubtitle => 'تسجيل الوقت على المهام';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordMin => '6 أحرف على الأقل';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get trackingTitle => 'تسجيل الوقت';

  @override
  String greeting(String name) {
    return 'مرحبًا، $name!';
  }

  @override
  String get ready => 'جاهز';

  @override
  String get onSite => 'في الموقع';

  @override
  String get overrideBadge => 'استثناء';

  @override
  String get startShift => 'بدء التسجيل';

  @override
  String get stopShift => 'إنهاء التسجيل';

  @override
  String get todayTotal => 'إجمالي اليوم';

  @override
  String get pickJob => 'اختر مهمة';

  @override
  String get noAssignedActiveJob => 'لم تُسنَد إليك أي مهمة نشطة';

  @override
  String get outsideGeofenceTitle => 'خارج السياج الجغرافي';

  @override
  String get outsideGeofenceBody =>
      'أنت لست في موقع المهمة. اذكر السبب وسيُبلَّغ المدير.';

  @override
  String get overrideReasonLabel => 'سبب الاستثناء';

  @override
  String get cancel => 'إلغاء';

  @override
  String get startWithOverride => 'بدء مع استثناء';

  @override
  String get locationServicesOff => 'خدمات الموقع متوقفة';

  @override
  String get locationDenied => 'تم رفض الوصول إلى الموقع';

  @override
  String get locationDeniedForever =>
      'تم رفض الوصول إلى الموقع نهائيًا — فعّله من الإعدادات';

  @override
  String get jobsTitle => 'المهام';

  @override
  String get newJob => 'مهمة جديدة';

  @override
  String get noJobs => 'لا توجد مهام';

  @override
  String get createJob => 'إنشاء مهمة';

  @override
  String plannedHours(String hours) {
    return 'المخطط: $hours س';
  }

  @override
  String get editJob => 'تعديل المهمة';

  @override
  String get jobName => 'اسم المهمة *';

  @override
  String get requiredField => 'حقل مطلوب';

  @override
  String get description => 'الوصف';

  @override
  String get address => 'العنوان';

  @override
  String get latitude => 'خط العرض (lat)';

  @override
  String get longitude => 'خط الطول (lon)';

  @override
  String get geofenceRadius => 'نصف قطر السياج الجغرافي (م)';

  @override
  String get enterNumber => 'أدخل رقمًا';

  @override
  String get estimatedHours => 'الساعات المقدّرة';

  @override
  String get status => 'الحالة';

  @override
  String get statusActive => 'نشطة';

  @override
  String get statusPaused => 'متوقفة مؤقتًا';

  @override
  String get statusCompleted => 'مكتملة';

  @override
  String get statusArchived => 'مؤرشفة';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get jobFallbackTitle => 'مهمة';

  @override
  String get info => 'معلومات';

  @override
  String get manager => 'المدير';

  @override
  String get geofence => 'السياج الجغرافي';

  @override
  String get estimatedHoursShort => 'الساعات المقدّرة';

  @override
  String get addressUnset => 'غير محدد';

  @override
  String get assignments => 'المُسنَدون';

  @override
  String get add => 'إضافة';

  @override
  String errorWith(String error) {
    return 'خطأ: $error';
  }

  @override
  String get noAssignedMembers => 'لا يوجد أعضاء مُسنَدون';

  @override
  String get tasks => 'المهام الفرعية';

  @override
  String get noTasks => 'لا توجد مهام فرعية';

  @override
  String get rosterTitle => 'فريقي';

  @override
  String get noTeamMembers => 'ليس لديك أعضاء في الفريق';

  @override
  String get askAdminAssign => 'اطلب من المسؤول إسناد أعضاء';

  @override
  String get reportsTitle => 'التقارير';

  @override
  String get change => 'تغيير';

  @override
  String get noReportData => 'لا توجد بيانات للفترة المحددة';

  @override
  String totalLabel(String hours) {
    return 'الإجمالي: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h س $m د';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n سجل',
      many: '$n سجلًا',
      few: '$n سجلات',
      two: 'سجلان',
      one: 'سجل واحد',
      zero: 'لا سجلات',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'إدارة المستخدمين';

  @override
  String get roleMember => 'عضو';

  @override
  String get roleManager => 'مدير';

  @override
  String get roleAdmin => 'مسؤول';

  @override
  String get roleAdminFull => 'مسؤول النظام';
}
