// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'דיווח';

  @override
  String get navJobs => 'עבודות';

  @override
  String get navRoster => 'צוות';

  @override
  String get navReports => 'דוחות';

  @override
  String get navAdmin => 'ניהול';

  @override
  String get retry => 'נסו שוב';

  @override
  String get loginSubtitle => 'רישום שעות עבודה בפרויקטים';

  @override
  String get emailLabel => 'אימייל';

  @override
  String get emailInvalid => 'הזינו כתובת אימייל תקינה';

  @override
  String get passwordLabel => 'סיסמה';

  @override
  String get passwordMin => 'לפחות 6 תווים';

  @override
  String get signIn => 'התחברות';

  @override
  String get trackingTitle => 'דיווח שעות';

  @override
  String greeting(String name) {
    return 'שלום, $name!';
  }

  @override
  String get ready => 'מוכן';

  @override
  String get onSite => 'באתר';

  @override
  String get overrideBadge => 'חריגה';

  @override
  String get startShift => 'התחלת דיווח';

  @override
  String get stopShift => 'סיום דיווח';

  @override
  String get todayTotal => 'סה״כ להיום';

  @override
  String get pickJob => 'בחרו עבודה';

  @override
  String get noAssignedActiveJob => 'לא הוקצתה לכם עבודה פעילה';

  @override
  String get outsideGeofenceTitle => 'מחוץ לגדר הווירטואלית';

  @override
  String get outsideGeofenceBody =>
      'אינכם באתר העבודה. ציינו סיבה והמנהל יקבל הודעה.';

  @override
  String get overrideReasonLabel => 'סיבת החריגה';

  @override
  String get cancel => 'ביטול';

  @override
  String get startWithOverride => 'התחלה עם חריגה';

  @override
  String get locationServicesOff => 'שירותי המיקום כבויים';

  @override
  String get locationDenied => 'הגישה למיקום נדחתה';

  @override
  String get locationDeniedForever =>
      'הגישה למיקום נדחתה לצמיתות — אפשרו אותה בהגדרות';

  @override
  String get jobsTitle => 'עבודות';

  @override
  String get newJob => 'עבודה חדשה';

  @override
  String get noJobs => 'אין עבודות';

  @override
  String get createJob => 'יצירת עבודה';

  @override
  String plannedHours(String hours) {
    return 'מתוכננות: $hours שעות';
  }

  @override
  String get editJob => 'עריכת עבודה';

  @override
  String get jobName => 'שם העבודה *';

  @override
  String get requiredField => 'שדה חובה';

  @override
  String get description => 'תיאור';

  @override
  String get address => 'כתובת';

  @override
  String get latitude => 'קו רוחב (lat)';

  @override
  String get longitude => 'קו אורך (lon)';

  @override
  String get geofenceRadius => 'רדיוס הגדר הווירטואלית (מ׳)';

  @override
  String get enterNumber => 'הזינו מספר';

  @override
  String get estimatedHours => 'שעות משוערות';

  @override
  String get status => 'סטטוס';

  @override
  String get statusActive => 'פעילה';

  @override
  String get statusPaused => 'מושהית';

  @override
  String get statusCompleted => 'הושלמה';

  @override
  String get statusArchived => 'בארכיון';

  @override
  String get saveChanges => 'שמירת שינויים';

  @override
  String get jobFallbackTitle => 'עבודה';

  @override
  String get info => 'מידע';

  @override
  String get manager => 'מנהל';

  @override
  String get geofence => 'גדר וירטואלית';

  @override
  String get estimatedHoursShort => 'שעות משוערות';

  @override
  String get addressUnset => 'לא צוין';

  @override
  String get assignments => 'שיבוצים';

  @override
  String get add => 'הוספה';

  @override
  String errorWith(String error) {
    return 'שגיאה: $error';
  }

  @override
  String get noAssignedMembers => 'אין חברים משובצים';

  @override
  String get tasks => 'משימות';

  @override
  String get noTasks => 'אין משימות';

  @override
  String get rosterTitle => 'הצוות שלי';

  @override
  String get noTeamMembers => 'אין לכם חברי צוות';

  @override
  String get askAdminAssign => 'בקשו ממנהל מערכת לשבץ חברים';

  @override
  String get reportsTitle => 'דוחות';

  @override
  String get change => 'שינוי';

  @override
  String get noReportData => 'אין נתונים לתקופה שנבחרה';

  @override
  String totalLabel(String hours) {
    return 'סה״כ: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h שע׳ $m דק׳';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n רשומות',
      two: 'שתי רשומות',
      one: 'רשומה אחת',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'ניהול משתמשים';

  @override
  String get roleMember => 'חבר';

  @override
  String get roleManager => 'מנהל';

  @override
  String get roleAdmin => 'מנהל מערכת';

  @override
  String get roleAdminFull => 'מנהל מערכת';
}
