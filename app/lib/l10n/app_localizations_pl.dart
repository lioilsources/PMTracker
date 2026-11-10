// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Czas';

  @override
  String get navJobs => 'Zlecenia';

  @override
  String get navRoster => 'Zespół';

  @override
  String get navReports => 'Raporty';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get loginSubtitle => 'Ewidencja czasu na zleceniach';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailInvalid => 'Podaj prawidłowy adres e-mail';

  @override
  String get passwordLabel => 'Hasło';

  @override
  String get passwordMin => 'Co najmniej 6 znaków';

  @override
  String get signIn => 'Zaloguj się';

  @override
  String get trackingTitle => 'Ewidencja czasu pracy';

  @override
  String greeting(String name) {
    return 'Dzień dobry, $name!';
  }

  @override
  String get ready => 'Gotowy';

  @override
  String get onSite => 'Na miejscu';

  @override
  String get overrideBadge => 'Wyjątek';

  @override
  String get startShift => 'Rozpocznij ewidencję';

  @override
  String get stopShift => 'Zakończ ewidencję';

  @override
  String get todayTotal => 'Dziś łącznie';

  @override
  String get pickJob => 'Wybierz zlecenie';

  @override
  String get noAssignedActiveJob =>
      'Nie masz przypisanego żadnego aktywnego zlecenia';

  @override
  String get outsideGeofenceTitle => 'Poza geofence';

  @override
  String get outsideGeofenceBody =>
      'Nie jesteś na miejscu zlecenia. Podaj powód, a przełożony zostanie powiadomiony.';

  @override
  String get overrideReasonLabel => 'Powód wyjątku';

  @override
  String get cancel => 'Anuluj';

  @override
  String get startWithOverride => 'Rozpocznij z wyjątkiem';

  @override
  String get locationServicesOff => 'Usługi lokalizacji są wyłączone';

  @override
  String get locationDenied => 'Odmowa dostępu do lokalizacji';

  @override
  String get locationDeniedForever =>
      'Trwała odmowa dostępu do lokalizacji — zezwól w ustawieniach';

  @override
  String get jobsTitle => 'Zlecenia';

  @override
  String get newJob => 'Nowe zlecenie';

  @override
  String get noJobs => 'Brak zleceń';

  @override
  String get createJob => 'Utwórz zlecenie';

  @override
  String plannedHours(String hours) {
    return 'Plan: $hours godz.';
  }

  @override
  String get editJob => 'Edytuj zlecenie';

  @override
  String get jobName => 'Nazwa zlecenia *';

  @override
  String get requiredField => 'Pole wymagane';

  @override
  String get description => 'Opis';

  @override
  String get address => 'Adres';

  @override
  String get latitude => 'Szerokość geograficzna (lat)';

  @override
  String get longitude => 'Długość geograficzna (lon)';

  @override
  String get geofenceRadius => 'Promień geofence (m)';

  @override
  String get enterNumber => 'Podaj liczbę';

  @override
  String get estimatedHours => 'Szacowane godziny';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Aktywne';

  @override
  String get statusPaused => 'Wstrzymane';

  @override
  String get statusCompleted => 'Zakończone';

  @override
  String get statusArchived => 'Zarchiwizowane';

  @override
  String get saveChanges => 'Zapisz zmiany';

  @override
  String get jobFallbackTitle => 'Zlecenie';

  @override
  String get info => 'Informacje';

  @override
  String get manager => 'Przełożony';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Szacowane godziny';

  @override
  String get addressUnset => 'Nie podano';

  @override
  String get assignments => 'Przypisania';

  @override
  String get add => 'Dodaj';

  @override
  String errorWith(String error) {
    return 'Błąd: $error';
  }

  @override
  String get noAssignedMembers => 'Brak przypisanych członków';

  @override
  String get tasks => 'Zadania';

  @override
  String get noTasks => 'Brak zadań';

  @override
  String get rosterTitle => 'Mój zespół';

  @override
  String get noTeamMembers => 'Nie masz członków w zespole';

  @override
  String get askAdminAssign => 'Poproś administratora o przypisanie członków';

  @override
  String get reportsTitle => 'Raporty';

  @override
  String get change => 'Zmień';

  @override
  String get noReportData => 'Brak danych dla wybranego okresu';

  @override
  String totalLabel(String hours) {
    return 'Łącznie: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h godz. $m min';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n wpisu',
      many: '$n wpisów',
      few: '$n wpisy',
      one: '$n wpis',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Zarządzanie użytkownikami';

  @override
  String get roleMember => 'Członek';

  @override
  String get roleManager => 'Przełożony';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrator';
}
