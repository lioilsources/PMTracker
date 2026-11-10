// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Χρόνος';

  @override
  String get navJobs => 'Εργασίες';

  @override
  String get navRoster => 'Ομάδα';

  @override
  String get navReports => 'Αναφορές';

  @override
  String get navAdmin => 'Διαχείριση';

  @override
  String get retry => 'Δοκιμάστε ξανά';

  @override
  String get loginSubtitle => 'Καταγραφή χρόνου στις εργασίες';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailInvalid => 'Εισάγετε έγκυρο email';

  @override
  String get passwordLabel => 'Κωδικός πρόσβασης';

  @override
  String get passwordMin => 'Τουλάχιστον 6 χαρακτήρες';

  @override
  String get signIn => 'Σύνδεση';

  @override
  String get trackingTitle => 'Καταγραφή χρόνου';

  @override
  String greeting(String name) {
    return 'Γεια σας, $name!';
  }

  @override
  String get ready => 'Έτοιμος';

  @override
  String get onSite => 'Στο χώρο';

  @override
  String get overrideBadge => 'Εξαίρεση';

  @override
  String get startShift => 'Έναρξη καταγραφής';

  @override
  String get stopShift => 'Λήξη καταγραφής';

  @override
  String get todayTotal => 'Σύνολο σήμερα';

  @override
  String get pickJob => 'Επιλέξτε εργασία';

  @override
  String get noAssignedActiveJob =>
      'Δεν σας έχει ανατεθεί καμία ενεργή εργασία';

  @override
  String get outsideGeofenceTitle => 'Εκτός γεωφράκτη';

  @override
  String get outsideGeofenceBody =>
      'Δεν βρίσκεστε στον χώρο της εργασίας. Δώστε έναν λόγο και ο υπεύθυνος θα ενημερωθεί.';

  @override
  String get overrideReasonLabel => 'Λόγος εξαίρεσης';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get startWithOverride => 'Έναρξη με εξαίρεση';

  @override
  String get locationServicesOff =>
      'Οι υπηρεσίες τοποθεσίας είναι απενεργοποιημένες';

  @override
  String get locationDenied => 'Η πρόσβαση στην τοποθεσία απορρίφθηκε';

  @override
  String get locationDeniedForever =>
      'Η πρόσβαση στην τοποθεσία απορρίφθηκε μόνιμα — επιτρέψτε την στις ρυθμίσεις';

  @override
  String get jobsTitle => 'Εργασίες';

  @override
  String get newJob => 'Νέα εργασία';

  @override
  String get noJobs => 'Καμία εργασία';

  @override
  String get createJob => 'Δημιουργία εργασίας';

  @override
  String plannedHours(String hours) {
    return '$hours ώρ. προγραμματισμένες';
  }

  @override
  String get editJob => 'Επεξεργασία εργασίας';

  @override
  String get jobName => 'Όνομα εργασίας *';

  @override
  String get requiredField => 'Υποχρεωτικό πεδίο';

  @override
  String get description => 'Περιγραφή';

  @override
  String get address => 'Διεύθυνση';

  @override
  String get latitude => 'Γεωγραφικό πλάτος (lat)';

  @override
  String get longitude => 'Γεωγραφικό μήκος (lon)';

  @override
  String get geofenceRadius => 'Ακτίνα γεωφράκτη (μ)';

  @override
  String get enterNumber => 'Εισάγετε αριθμό';

  @override
  String get estimatedHours => 'Εκτιμώμενες ώρες';

  @override
  String get status => 'Κατάσταση';

  @override
  String get statusActive => 'Ενεργή';

  @override
  String get statusPaused => 'Σε παύση';

  @override
  String get statusCompleted => 'Ολοκληρωμένη';

  @override
  String get statusArchived => 'Αρχειοθετημένη';

  @override
  String get saveChanges => 'Αποθήκευση αλλαγών';

  @override
  String get jobFallbackTitle => 'Εργασία';

  @override
  String get info => 'Πληροφορίες';

  @override
  String get manager => 'Υπεύθυνος';

  @override
  String get geofence => 'Γεωφράκτης';

  @override
  String get estimatedHoursShort => 'Εκτιμώμενες ώρες';

  @override
  String get addressUnset => 'Δεν έχει οριστεί';

  @override
  String get assignments => 'Αναθέσεις';

  @override
  String get add => 'Προσθήκη';

  @override
  String errorWith(String error) {
    return 'Σφάλμα: $error';
  }

  @override
  String get noAssignedMembers => 'Δεν υπάρχουν μέλη με ανάθεση';

  @override
  String get tasks => 'Εργασίες προς εκτέλεση';

  @override
  String get noTasks => 'Καμία εργασία προς εκτέλεση';

  @override
  String get rosterTitle => 'Η ομάδα μου';

  @override
  String get noTeamMembers => 'Δεν έχετε μέλη στην ομάδα σας';

  @override
  String get askAdminAssign => 'Ζητήστε από έναν διαχειριστή να αναθέσει μέλη';

  @override
  String get reportsTitle => 'Αναφορές';

  @override
  String get change => 'Αλλαγή';

  @override
  String get noReportData => 'Δεν υπάρχουν δεδομένα για την επιλεγμένη περίοδο';

  @override
  String totalLabel(String hours) {
    return 'Σύνολο: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h ώρ. $m λεπτά';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n εγγραφές',
      one: '$n εγγραφή',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Διαχείριση χρηστών';

  @override
  String get roleMember => 'Μέλος';

  @override
  String get roleManager => 'Υπεύθυνος';

  @override
  String get roleAdmin => 'Διαχειριστής';

  @override
  String get roleAdminFull => 'Διαχειριστής συστήματος';
}
