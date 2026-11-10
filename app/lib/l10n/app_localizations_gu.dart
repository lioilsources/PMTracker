// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'સમય';

  @override
  String get navJobs => 'કામ';

  @override
  String get navRoster => 'ટીમ';

  @override
  String get navReports => 'રિપોર્ટ';

  @override
  String get navAdmin => 'એડમિન';

  @override
  String get retry => 'ફરી પ્રયત્ન કરો';

  @override
  String get loginSubtitle => 'કામ પર સમયની નોંધ';

  @override
  String get emailLabel => 'ઇમેઇલ';

  @override
  String get emailInvalid => 'માન્ય ઇમેઇલ દાખલ કરો';

  @override
  String get passwordLabel => 'પાસવર્ડ';

  @override
  String get passwordMin => 'ઓછામાં ઓછા 6 અક્ષર';

  @override
  String get signIn => 'સાઇન ઇન';

  @override
  String get trackingTitle => 'સમય નોંધ';

  @override
  String greeting(String name) {
    return 'નમસ્તે, $name!';
  }

  @override
  String get ready => 'તૈયાર';

  @override
  String get onSite => 'સ્થળ પર';

  @override
  String get overrideBadge => 'અપવાદ';

  @override
  String get startShift => 'નોંધ શરૂ કરો';

  @override
  String get stopShift => 'નોંધ પૂરી કરો';

  @override
  String get todayTotal => 'આજનો કુલ સમય';

  @override
  String get pickJob => 'કામ પસંદ કરો';

  @override
  String get noAssignedActiveJob => 'તમને કોઈ સક્રિય કામ સોંપાયું નથી';

  @override
  String get outsideGeofenceTitle => 'જિયોફેન્સની બહાર';

  @override
  String get outsideGeofenceBody =>
      'તમે કામના સ્થળે નથી. કારણ લખો, મેનેજરને જાણ કરવામાં આવશે.';

  @override
  String get overrideReasonLabel => 'અપવાદનું કારણ';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get startWithOverride => 'અપવાદ સાથે શરૂ કરો';

  @override
  String get locationServicesOff => 'લોકેશન સેવાઓ બંધ છે';

  @override
  String get locationDenied => 'લોકેશનની પરવાનગી નકારી';

  @override
  String get locationDeniedForever =>
      'લોકેશનની પરવાનગી કાયમ માટે નકારી — સેટિંગ્સમાં મંજૂરી આપો';

  @override
  String get jobsTitle => 'કામ';

  @override
  String get newJob => 'નવું કામ';

  @override
  String get noJobs => 'કોઈ કામ નથી';

  @override
  String get createJob => 'કામ બનાવો';

  @override
  String plannedHours(String hours) {
    return '$hours કલાક આયોજિત';
  }

  @override
  String get editJob => 'કામ સુધારો';

  @override
  String get jobName => 'કામનું નામ *';

  @override
  String get requiredField => 'ફરજિયાત ખાનું';

  @override
  String get description => 'વર્ણન';

  @override
  String get address => 'સરનામું';

  @override
  String get latitude => 'અક્ષાંશ (lat)';

  @override
  String get longitude => 'રેખાંશ (lon)';

  @override
  String get geofenceRadius => 'જિયોફેન્સ ત્રિજ્યા (મી)';

  @override
  String get enterNumber => 'સંખ્યા દાખલ કરો';

  @override
  String get estimatedHours => 'અંદાજિત કલાક';

  @override
  String get status => 'સ્થિતિ';

  @override
  String get statusActive => 'સક્રિય';

  @override
  String get statusPaused => 'થોભાવેલું';

  @override
  String get statusCompleted => 'પૂર્ણ';

  @override
  String get statusArchived => 'આર્કાઇવ';

  @override
  String get saveChanges => 'ફેરફાર સાચવો';

  @override
  String get jobFallbackTitle => 'કામ';

  @override
  String get info => 'માહિતી';

  @override
  String get manager => 'મેનેજર';

  @override
  String get geofence => 'જિયોફેન્સ';

  @override
  String get estimatedHoursShort => 'અંદાજિત કલાક';

  @override
  String get addressUnset => 'આપ્યું નથી';

  @override
  String get assignments => 'સોંપણીઓ';

  @override
  String get add => 'ઉમેરો';

  @override
  String errorWith(String error) {
    return 'ભૂલ: $error';
  }

  @override
  String get noAssignedMembers => 'કોઈ સોંપાયેલ સભ્ય નથી';

  @override
  String get tasks => 'કાર્યો';

  @override
  String get noTasks => 'કોઈ કાર્ય નથી';

  @override
  String get rosterTitle => 'મારી ટીમ';

  @override
  String get noTeamMembers => 'તમારી ટીમમાં કોઈ સભ્ય નથી';

  @override
  String get askAdminAssign => 'સભ્યો સોંપવા એડમિનને કહો';

  @override
  String get reportsTitle => 'રિપોર્ટ';

  @override
  String get change => 'બદલો';

  @override
  String get noReportData => 'પસંદ કરેલા સમયગાળા માટે કોઈ ડેટા નથી';

  @override
  String totalLabel(String hours) {
    return 'કુલ: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h કલાક $m મિનિટ';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n નોંધ',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'વપરાશકર્તા સંચાલન';

  @override
  String get roleMember => 'સભ્ય';

  @override
  String get roleManager => 'મેનેજર';

  @override
  String get roleAdmin => 'એડમિન';

  @override
  String get roleAdminFull => 'સંચાલક';
}
