// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Облік';

  @override
  String get navJobs => 'Замовлення';

  @override
  String get navRoster => 'Команда';

  @override
  String get navReports => 'Звіти';

  @override
  String get navAdmin => 'Адмін';

  @override
  String get retry => 'Спробувати знову';

  @override
  String get loginSubtitle => 'Облік часу за замовленнями';

  @override
  String get emailLabel => 'Ел. пошта';

  @override
  String get emailInvalid => 'Введіть дійсну адресу ел. пошти';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get passwordMin => 'Щонайменше 6 символів';

  @override
  String get signIn => 'Увійти';

  @override
  String get trackingTitle => 'Облік робочого часу';

  @override
  String greeting(String name) {
    return 'Добрий день, $name!';
  }

  @override
  String get ready => 'Готово';

  @override
  String get onSite => 'На місці';

  @override
  String get overrideBadge => 'Виняток';

  @override
  String get startShift => 'Почати облік';

  @override
  String get stopShift => 'Завершити облік';

  @override
  String get todayTotal => 'Сьогодні разом';

  @override
  String get pickJob => 'Оберіть замовлення';

  @override
  String get noAssignedActiveJob =>
      'Вам не призначено жодного активного замовлення';

  @override
  String get outsideGeofenceTitle => 'Поза геозоною';

  @override
  String get outsideGeofenceBody =>
      'Ви не на місці виконання замовлення. Вкажіть причину, і керівника буде повідомлено.';

  @override
  String get overrideReasonLabel => 'Причина винятку';

  @override
  String get cancel => 'Скасувати';

  @override
  String get startWithOverride => 'Почати з винятком';

  @override
  String get locationServicesOff => 'Служби геолокації вимкнено';

  @override
  String get locationDenied => 'Доступ до геолокації відхилено';

  @override
  String get locationDeniedForever =>
      'Доступ до геолокації відхилено назавжди — дозвольте його в налаштуваннях';

  @override
  String get jobsTitle => 'Замовлення';

  @override
  String get newJob => 'Нове замовлення';

  @override
  String get noJobs => 'Замовлень немає';

  @override
  String get createJob => 'Створити замовлення';

  @override
  String plannedHours(String hours) {
    return 'План: $hours год';
  }

  @override
  String get editJob => 'Редагувати замовлення';

  @override
  String get jobName => 'Назва замовлення *';

  @override
  String get requiredField => 'Обов\'язкове поле';

  @override
  String get description => 'Опис';

  @override
  String get address => 'Адреса';

  @override
  String get latitude => 'Широта (lat)';

  @override
  String get longitude => 'Довгота (lon)';

  @override
  String get geofenceRadius => 'Радіус геозони (м)';

  @override
  String get enterNumber => 'Введіть число';

  @override
  String get estimatedHours => 'Орієнтовно годин';

  @override
  String get status => 'Статус';

  @override
  String get statusActive => 'Активне';

  @override
  String get statusPaused => 'Призупинено';

  @override
  String get statusCompleted => 'Завершено';

  @override
  String get statusArchived => 'В архіві';

  @override
  String get saveChanges => 'Зберегти зміни';

  @override
  String get jobFallbackTitle => 'Замовлення';

  @override
  String get info => 'Інформація';

  @override
  String get manager => 'Керівник';

  @override
  String get geofence => 'Геозона';

  @override
  String get estimatedHoursShort => 'Орієнтовно годин';

  @override
  String get addressUnset => 'Не вказано';

  @override
  String get assignments => 'Призначення';

  @override
  String get add => 'Додати';

  @override
  String errorWith(String error) {
    return 'Помилка: $error';
  }

  @override
  String get noAssignedMembers => 'Призначених учасників немає';

  @override
  String get tasks => 'Завдання';

  @override
  String get noTasks => 'Завдань немає';

  @override
  String get rosterTitle => 'Моя команда';

  @override
  String get noTeamMembers => 'У вашій команді немає учасників';

  @override
  String get askAdminAssign => 'Попросіть адміністратора призначити учасників';

  @override
  String get reportsTitle => 'Звіти';

  @override
  String get change => 'Змінити';

  @override
  String get noReportData => 'Немає даних за вибраний період';

  @override
  String totalLabel(String hours) {
    return 'Разом: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h год $m хв';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n запису',
      many: '$n записів',
      few: '$n записи',
      one: '$n запис',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Керування користувачами';

  @override
  String get roleMember => 'Учасник';

  @override
  String get roleManager => 'Керівник';

  @override
  String get roleAdmin => 'Адмін';

  @override
  String get roleAdminFull => 'Адміністратор';
}
