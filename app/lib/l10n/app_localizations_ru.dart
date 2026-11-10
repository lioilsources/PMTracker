// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Учёт';

  @override
  String get navJobs => 'Заказы';

  @override
  String get navRoster => 'Команда';

  @override
  String get navReports => 'Отчёты';

  @override
  String get navAdmin => 'Админ';

  @override
  String get retry => 'Повторить';

  @override
  String get loginSubtitle => 'Учёт времени по заказам';

  @override
  String get emailLabel => 'Эл. почта';

  @override
  String get emailInvalid => 'Введите корректный адрес эл. почты';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get passwordMin => 'Не менее 6 символов';

  @override
  String get signIn => 'Войти';

  @override
  String get trackingTitle => 'Учёт рабочего времени';

  @override
  String greeting(String name) {
    return 'Здравствуйте, $name!';
  }

  @override
  String get ready => 'Готово';

  @override
  String get onSite => 'На месте';

  @override
  String get overrideBadge => 'Исключение';

  @override
  String get startShift => 'Начать учёт';

  @override
  String get stopShift => 'Завершить учёт';

  @override
  String get todayTotal => 'Сегодня всего';

  @override
  String get pickJob => 'Выберите заказ';

  @override
  String get noAssignedActiveJob => 'Вам не назначен ни один активный заказ';

  @override
  String get outsideGeofenceTitle => 'Вне геозоны';

  @override
  String get outsideGeofenceBody =>
      'Вы не на месте выполнения заказа. Укажите причину, и руководитель будет уведомлён.';

  @override
  String get overrideReasonLabel => 'Причина исключения';

  @override
  String get cancel => 'Отмена';

  @override
  String get startWithOverride => 'Начать с исключением';

  @override
  String get locationServicesOff => 'Службы геолокации отключены';

  @override
  String get locationDenied => 'Доступ к геолокации отклонён';

  @override
  String get locationDeniedForever =>
      'Доступ к геолокации отклонён навсегда — разрешите его в настройках';

  @override
  String get jobsTitle => 'Заказы';

  @override
  String get newJob => 'Новый заказ';

  @override
  String get noJobs => 'Заказов нет';

  @override
  String get createJob => 'Создать заказ';

  @override
  String plannedHours(String hours) {
    return 'План: $hours ч';
  }

  @override
  String get editJob => 'Изменить заказ';

  @override
  String get jobName => 'Название заказа *';

  @override
  String get requiredField => 'Обязательное поле';

  @override
  String get description => 'Описание';

  @override
  String get address => 'Адрес';

  @override
  String get latitude => 'Широта (lat)';

  @override
  String get longitude => 'Долгота (lon)';

  @override
  String get geofenceRadius => 'Радиус геозоны (м)';

  @override
  String get enterNumber => 'Введите число';

  @override
  String get estimatedHours => 'Ориентировочно часов';

  @override
  String get status => 'Статус';

  @override
  String get statusActive => 'Активен';

  @override
  String get statusPaused => 'Приостановлен';

  @override
  String get statusCompleted => 'Завершён';

  @override
  String get statusArchived => 'В архиве';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get jobFallbackTitle => 'Заказ';

  @override
  String get info => 'Информация';

  @override
  String get manager => 'Руководитель';

  @override
  String get geofence => 'Геозона';

  @override
  String get estimatedHoursShort => 'Ориентировочно часов';

  @override
  String get addressUnset => 'Не указан';

  @override
  String get assignments => 'Назначения';

  @override
  String get add => 'Добавить';

  @override
  String errorWith(String error) {
    return 'Ошибка: $error';
  }

  @override
  String get noAssignedMembers => 'Назначенных участников нет';

  @override
  String get tasks => 'Задачи';

  @override
  String get noTasks => 'Задач нет';

  @override
  String get rosterTitle => 'Моя команда';

  @override
  String get noTeamMembers => 'В вашей команде нет участников';

  @override
  String get askAdminAssign => 'Попросите администратора назначить участников';

  @override
  String get reportsTitle => 'Отчёты';

  @override
  String get change => 'Изменить';

  @override
  String get noReportData => 'Нет данных за выбранный период';

  @override
  String totalLabel(String hours) {
    return 'Всего: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h ч $m мин';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n записи',
      many: '$n записей',
      few: '$n записи',
      one: '$n запись',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Управление пользователями';

  @override
  String get roleMember => 'Участник';

  @override
  String get roleManager => 'Руководитель';

  @override
  String get roleAdmin => 'Админ';

  @override
  String get roleAdminFull => 'Администратор';
}
