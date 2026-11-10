// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'సమయం';

  @override
  String get navJobs => 'పనులు';

  @override
  String get navRoster => 'బృందం';

  @override
  String get navReports => 'నివేదికలు';

  @override
  String get navAdmin => 'అడ్మిన్';

  @override
  String get retry => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get loginSubtitle => 'పనులపై సమయ నమోదు';

  @override
  String get emailLabel => 'ఈమెయిల్';

  @override
  String get emailInvalid => 'సరైన ఈమెయిల్ ఇవ్వండి';

  @override
  String get passwordLabel => 'పాస్‌వర్డ్';

  @override
  String get passwordMin => 'కనీసం 6 అక్షరాలు';

  @override
  String get signIn => 'సైన్ ఇన్';

  @override
  String get trackingTitle => 'సమయ నమోదు';

  @override
  String greeting(String name) {
    return 'నమస్తే, $name!';
  }

  @override
  String get ready => 'సిద్ధం';

  @override
  String get onSite => 'పని స్థలంలో';

  @override
  String get overrideBadge => 'మినహాయింపు';

  @override
  String get startShift => 'నమోదు ప్రారంభించండి';

  @override
  String get stopShift => 'నమోదు ముగించండి';

  @override
  String get todayTotal => 'ఈ రోజు మొత్తం';

  @override
  String get pickJob => 'పనిని ఎంచుకోండి';

  @override
  String get noAssignedActiveJob => 'మీకు ఏ క్రియాశీల పని కేటాయించబడలేదు';

  @override
  String get outsideGeofenceTitle => 'జియోఫెన్స్ వెలుపల';

  @override
  String get outsideGeofenceBody =>
      'మీరు పని స్థలంలో లేరు. కారణం చెప్పండి, మేనేజర్‌కు తెలియజేయబడుతుంది.';

  @override
  String get overrideReasonLabel => 'మినహాయింపు కారణం';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get startWithOverride => 'మినహాయింపుతో ప్రారంభించండి';

  @override
  String get locationServicesOff => 'లొకేషన్ సేవలు ఆఫ్‌లో ఉన్నాయి';

  @override
  String get locationDenied => 'లొకేషన్ యాక్సెస్ నిరాకరించబడింది';

  @override
  String get locationDeniedForever =>
      'లొకేషన్ యాక్సెస్ శాశ్వతంగా నిరాకరించబడింది — సెట్టింగ్స్‌లో అనుమతించండి';

  @override
  String get jobsTitle => 'పనులు';

  @override
  String get newJob => 'కొత్త పని';

  @override
  String get noJobs => 'పనులు లేవు';

  @override
  String get createJob => 'పనిని సృష్టించండి';

  @override
  String plannedHours(String hours) {
    return '$hours గం. ప్రణాళిక';
  }

  @override
  String get editJob => 'పనిని సవరించండి';

  @override
  String get jobName => 'పని పేరు *';

  @override
  String get requiredField => 'తప్పనిసరి ఫీల్డ్';

  @override
  String get description => 'వివరణ';

  @override
  String get address => 'చిరునామా';

  @override
  String get latitude => 'అక్షాంశం (lat)';

  @override
  String get longitude => 'రేఖాంశం (lon)';

  @override
  String get geofenceRadius => 'జియోఫెన్స్ వ్యాసార్థం (మీ)';

  @override
  String get enterNumber => 'సంఖ్యను నమోదు చేయండి';

  @override
  String get estimatedHours => 'అంచనా గంటలు';

  @override
  String get status => 'స్థితి';

  @override
  String get statusActive => 'క్రియాశీలం';

  @override
  String get statusPaused => 'నిలిపివేయబడింది';

  @override
  String get statusCompleted => 'పూర్తయింది';

  @override
  String get statusArchived => 'ఆర్కైవ్ చేయబడింది';

  @override
  String get saveChanges => 'మార్పులను సేవ్ చేయండి';

  @override
  String get jobFallbackTitle => 'పని';

  @override
  String get info => 'సమాచారం';

  @override
  String get manager => 'మేనేజర్';

  @override
  String get geofence => 'జియోఫెన్స్';

  @override
  String get estimatedHoursShort => 'అంచనా గంటలు';

  @override
  String get addressUnset => 'ఇవ్వలేదు';

  @override
  String get assignments => 'కేటాయింపులు';

  @override
  String get add => 'జోడించండి';

  @override
  String errorWith(String error) {
    return 'లోపం: $error';
  }

  @override
  String get noAssignedMembers => 'కేటాయించిన సభ్యులు లేరు';

  @override
  String get tasks => 'పనుల జాబితా';

  @override
  String get noTasks => 'పనులు లేవు';

  @override
  String get rosterTitle => 'నా బృందం';

  @override
  String get noTeamMembers => 'మీ బృందంలో సభ్యులు లేరు';

  @override
  String get askAdminAssign => 'సభ్యులను కేటాయించమని అడ్మిన్‌ను కోరండి';

  @override
  String get reportsTitle => 'నివేదికలు';

  @override
  String get change => 'మార్చండి';

  @override
  String get noReportData => 'ఎంచుకున్న వ్యవధికి డేటా లేదు';

  @override
  String totalLabel(String hours) {
    return 'మొత్తం: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h గం $m ని';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n నమోదులు',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'వినియోగదారుల నిర్వహణ';

  @override
  String get roleMember => 'సభ్యుడు';

  @override
  String get roleManager => 'మేనేజర్';

  @override
  String get roleAdmin => 'అడ్మిన్';

  @override
  String get roleAdminFull => 'నిర్వాహకుడు';
}
