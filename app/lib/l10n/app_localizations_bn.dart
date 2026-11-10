// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'সময়';

  @override
  String get navJobs => 'কাজ';

  @override
  String get navRoster => 'টিম';

  @override
  String get navReports => 'রিপোর্ট';

  @override
  String get navAdmin => 'অ্যাডমিন';

  @override
  String get retry => 'আবার চেষ্টা করুন';

  @override
  String get loginSubtitle => 'কাজের সময়ের হিসাব';

  @override
  String get emailLabel => 'ইমেইল';

  @override
  String get emailInvalid => 'সঠিক ইমেইল দিন';

  @override
  String get passwordLabel => 'পাসওয়ার্ড';

  @override
  String get passwordMin => 'কমপক্ষে ৬টি অক্ষর';

  @override
  String get signIn => 'সাইন ইন';

  @override
  String get trackingTitle => 'সময় রেকর্ড';

  @override
  String greeting(String name) {
    return 'নমস্কার, $name!';
  }

  @override
  String get ready => 'প্রস্তুত';

  @override
  String get onSite => 'কর্মস্থলে';

  @override
  String get overrideBadge => 'ব্যতিক্রম';

  @override
  String get startShift => 'রেকর্ড শুরু করুন';

  @override
  String get stopShift => 'রেকর্ড শেষ করুন';

  @override
  String get todayTotal => 'আজ মোট';

  @override
  String get pickJob => 'একটি কাজ বেছে নিন';

  @override
  String get noAssignedActiveJob =>
      'আপনাকে কোনো সক্রিয় কাজে নিয়োগ দেওয়া হয়নি';

  @override
  String get outsideGeofenceTitle => 'জিওফেন্সের বাইরে';

  @override
  String get outsideGeofenceBody =>
      'আপনি কাজের স্থানে নেই। কারণ লিখুন, ম্যানেজারকে জানানো হবে।';

  @override
  String get overrideReasonLabel => 'ব্যতিক্রমের কারণ';

  @override
  String get cancel => 'বাতিল';

  @override
  String get startWithOverride => 'ব্যতিক্রমসহ শুরু করুন';

  @override
  String get locationServicesOff => 'লোকেশন সেবা বন্ধ আছে';

  @override
  String get locationDenied => 'লোকেশনে প্রবেশাধিকার প্রত্যাখ্যাত';

  @override
  String get locationDeniedForever =>
      'লোকেশনে প্রবেশাধিকার স্থায়ীভাবে প্রত্যাখ্যাত — সেটিংসে অনুমতি দিন';

  @override
  String get jobsTitle => 'কাজ';

  @override
  String get newJob => 'নতুন কাজ';

  @override
  String get noJobs => 'কোনো কাজ নেই';

  @override
  String get createJob => 'কাজ তৈরি করুন';

  @override
  String plannedHours(String hours) {
    return 'পরিকল্পিত $hours ঘণ্টা';
  }

  @override
  String get editJob => 'কাজ সম্পাদনা';

  @override
  String get jobName => 'কাজের নাম *';

  @override
  String get requiredField => 'আবশ্যক ঘর';

  @override
  String get description => 'বিবরণ';

  @override
  String get address => 'ঠিকানা';

  @override
  String get latitude => 'অক্ষাংশ (lat)';

  @override
  String get longitude => 'দ্রাঘিমাংশ (lon)';

  @override
  String get geofenceRadius => 'জিওফেন্সের ব্যাসার্ধ (মি)';

  @override
  String get enterNumber => 'একটি সংখ্যা দিন';

  @override
  String get estimatedHours => 'আনুমানিক ঘণ্টা';

  @override
  String get status => 'অবস্থা';

  @override
  String get statusActive => 'সক্রিয়';

  @override
  String get statusPaused => 'স্থগিত';

  @override
  String get statusCompleted => 'সম্পন্ন';

  @override
  String get statusArchived => 'আর্কাইভ';

  @override
  String get saveChanges => 'পরিবর্তন সংরক্ষণ';

  @override
  String get jobFallbackTitle => 'কাজ';

  @override
  String get info => 'তথ্য';

  @override
  String get manager => 'ম্যানেজার';

  @override
  String get geofence => 'জিওফেন্স';

  @override
  String get estimatedHoursShort => 'আনুমানিক ঘণ্টা';

  @override
  String get addressUnset => 'উল্লেখ নেই';

  @override
  String get assignments => 'নিয়োগ';

  @override
  String get add => 'যোগ করুন';

  @override
  String errorWith(String error) {
    return 'ত্রুটি: $error';
  }

  @override
  String get noAssignedMembers => 'কোনো নিয়োগপ্রাপ্ত সদস্য নেই';

  @override
  String get tasks => 'কাজের তালিকা';

  @override
  String get noTasks => 'কোনো কাজ নেই';

  @override
  String get rosterTitle => 'আমার টিম';

  @override
  String get noTeamMembers => 'আপনার টিমে কোনো সদস্য নেই';

  @override
  String get askAdminAssign => 'সদস্য নিয়োগের জন্য অ্যাডমিনকে বলুন';

  @override
  String get reportsTitle => 'রিপোর্ট';

  @override
  String get change => 'পরিবর্তন';

  @override
  String get noReportData => 'নির্বাচিত সময়ের জন্য কোনো তথ্য নেই';

  @override
  String totalLabel(String hours) {
    return 'মোট: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h ঘ $m মি';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nটি এন্ট্রি',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'ব্যবহারকারী ব্যবস্থাপনা';

  @override
  String get roleMember => 'সদস্য';

  @override
  String get roleManager => 'ম্যানেজার';

  @override
  String get roleAdmin => 'অ্যাডমিন';

  @override
  String get roleAdminFull => 'প্রশাসক';
}
