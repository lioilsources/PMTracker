// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class AppLocalizationsOr extends AppLocalizations {
  AppLocalizationsOr([String locale = 'or']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'ସମୟ';

  @override
  String get navJobs => 'କାମ';

  @override
  String get navRoster => 'ଦଳ';

  @override
  String get navReports => 'ରିପୋର୍ଟ';

  @override
  String get navAdmin => 'ଆଡମିନ୍';

  @override
  String get retry => 'ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ';

  @override
  String get loginSubtitle => 'କାମରେ ସମୟର ହିସାବ';

  @override
  String get emailLabel => 'ଇମେଲ୍';

  @override
  String get emailInvalid => 'ବୈଧ ଇମେଲ୍ ଦିଅନ୍ତୁ';

  @override
  String get passwordLabel => 'ପାସୱାର୍ଡ';

  @override
  String get passwordMin => 'ଅତିକମରେ 6ଟି ଅକ୍ଷର';

  @override
  String get signIn => 'ସାଇନ୍ ଇନ୍';

  @override
  String get trackingTitle => 'ସମୟ ରେକର୍ଡ';

  @override
  String greeting(String name) {
    return 'ନମସ୍କାର, $name!';
  }

  @override
  String get ready => 'ପ୍ରସ୍ତୁତ';

  @override
  String get onSite => 'କାମ ସ୍ଥାନରେ';

  @override
  String get overrideBadge => 'ବ୍ୟତିକ୍ରମ';

  @override
  String get startShift => 'ରେକର୍ଡ ଆରମ୍ଭ କରନ୍ତୁ';

  @override
  String get stopShift => 'ରେକର୍ଡ ଶେଷ କରନ୍ତୁ';

  @override
  String get todayTotal => 'ଆଜିର ମୋଟ';

  @override
  String get pickJob => 'ଏକ କାମ ବାଛନ୍ତୁ';

  @override
  String get noAssignedActiveJob => 'ଆପଣଙ୍କୁ କୌଣସି ସକ୍ରିୟ କାମ ଦିଆଯାଇନାହିଁ';

  @override
  String get outsideGeofenceTitle => 'ଜିଓଫେନ୍ସ୍ ବାହାରେ';

  @override
  String get outsideGeofenceBody =>
      'ଆପଣ କାମ ସ୍ଥାନରେ ନାହାଁନ୍ତି। କାରଣ ଲେଖନ୍ତୁ, ମ୍ୟାନେଜରଙ୍କୁ ଜଣାଯିବ।';

  @override
  String get overrideReasonLabel => 'ବ୍ୟତିକ୍ରମର କାରଣ';

  @override
  String get cancel => 'ବାତିଲ୍';

  @override
  String get startWithOverride => 'ବ୍ୟତିକ୍ରମ ସହ ଆରମ୍ଭ କରନ୍ତୁ';

  @override
  String get locationServicesOff => 'ଲୋକେସନ୍ ସେବା ବନ୍ଦ ଅଛି';

  @override
  String get locationDenied => 'ଲୋକେସନ୍ ଅନୁମତି ପ୍ରତ୍ୟାଖ୍ୟାତ';

  @override
  String get locationDeniedForever =>
      'ଲୋକେସନ୍ ଅନୁମତି ସବୁଦିନ ପାଇଁ ପ୍ରତ୍ୟାଖ୍ୟାତ — ସେଟିଂସ୍‌ରେ ଅନୁମତି ଦିଅନ୍ତୁ';

  @override
  String get jobsTitle => 'କାମ';

  @override
  String get newJob => 'ନୂଆ କାମ';

  @override
  String get noJobs => 'କୌଣସି କାମ ନାହିଁ';

  @override
  String get createJob => 'କାମ ତିଆରି କରନ୍ତୁ';

  @override
  String plannedHours(String hours) {
    return '$hours ଘଣ୍ଟା ଯୋଜିତ';
  }

  @override
  String get editJob => 'କାମ ସମ୍ପାଦନ';

  @override
  String get jobName => 'କାମର ନାମ *';

  @override
  String get requiredField => 'ଆବଶ୍ୟକ ଘର';

  @override
  String get description => 'ବିବରଣୀ';

  @override
  String get address => 'ଠିକଣା';

  @override
  String get latitude => 'ଅକ୍ଷାଂଶ (lat)';

  @override
  String get longitude => 'ଦ୍ରାଘିମା (lon)';

  @override
  String get geofenceRadius => 'ଜିଓଫେନ୍ସ୍ ବ୍ୟାସାର୍ଦ୍ଧ (ମି)';

  @override
  String get enterNumber => 'ଏକ ସଂଖ୍ୟା ଦିଅନ୍ତୁ';

  @override
  String get estimatedHours => 'ଆନୁମାନିକ ଘଣ୍ଟା';

  @override
  String get status => 'ସ୍ଥିତି';

  @override
  String get statusActive => 'ସକ୍ରିୟ';

  @override
  String get statusPaused => 'ସ୍ଥଗିତ';

  @override
  String get statusCompleted => 'ସମ୍ପୂର୍ଣ୍ଣ';

  @override
  String get statusArchived => 'ଆର୍କାଇଭ୍';

  @override
  String get saveChanges => 'ପରିବର୍ତ୍ତନ ସଞ୍ଚୟ କରନ୍ତୁ';

  @override
  String get jobFallbackTitle => 'କାମ';

  @override
  String get info => 'ସୂଚନା';

  @override
  String get manager => 'ମ୍ୟାନେଜର୍';

  @override
  String get geofence => 'ଜିଓଫେନ୍ସ୍';

  @override
  String get estimatedHoursShort => 'ଆନୁମାନିକ ଘଣ୍ଟା';

  @override
  String get addressUnset => 'ଦିଆଯାଇନାହିଁ';

  @override
  String get assignments => 'ନିୟୋଜନ';

  @override
  String get add => 'ଯୋଡ଼ନ୍ତୁ';

  @override
  String errorWith(String error) {
    return 'ତ୍ରୁଟି: $error';
  }

  @override
  String get noAssignedMembers => 'କୌଣସି ନିୟୋଜିତ ସଦସ୍ୟ ନାହାଁନ୍ତି';

  @override
  String get tasks => 'କାର୍ଯ୍ୟ';

  @override
  String get noTasks => 'କୌଣସି କାର୍ଯ୍ୟ ନାହିଁ';

  @override
  String get rosterTitle => 'ମୋ ଦଳ';

  @override
  String get noTeamMembers => 'ଆପଣଙ୍କ ଦଳରେ କୌଣସି ସଦସ୍ୟ ନାହାଁନ୍ତି';

  @override
  String get askAdminAssign => 'ସଦସ୍ୟ ନିୟୋଜନ ପାଇଁ ଆଡମିନ୍‌ଙ୍କୁ କୁହନ୍ତୁ';

  @override
  String get reportsTitle => 'ରିପୋର୍ଟ';

  @override
  String get change => 'ବଦଳାନ୍ତୁ';

  @override
  String get noReportData => 'ବଛାଯାଇଥିବା ଅବଧି ପାଇଁ କୌଣସି ତଥ୍ୟ ନାହିଁ';

  @override
  String totalLabel(String hours) {
    return 'ମୋଟ: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h ଘ $m ମି';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$nଟି ଏଣ୍ଟ୍ରି',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'ଉପଯୋଗକର୍ତ୍ତା ପରିଚାଳନା';

  @override
  String get roleMember => 'ସଦସ୍ୟ';

  @override
  String get roleManager => 'ମ୍ୟାନେଜର୍';

  @override
  String get roleAdmin => 'ଆଡମିନ୍';

  @override
  String get roleAdminFull => 'ପ୍ରଶାସକ';
}
