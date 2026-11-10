// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Kayıt';

  @override
  String get navJobs => 'İşler';

  @override
  String get navRoster => 'Ekip';

  @override
  String get navReports => 'Raporlar';

  @override
  String get navAdmin => 'Yönetim';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get loginSubtitle => 'İşlerde zaman takibi';

  @override
  String get emailLabel => 'E-posta';

  @override
  String get emailInvalid => 'Geçerli bir e-posta girin';

  @override
  String get passwordLabel => 'Parola';

  @override
  String get passwordMin => 'En az 6 karakter';

  @override
  String get signIn => 'Giriş yap';

  @override
  String get trackingTitle => 'Zaman kaydı';

  @override
  String greeting(String name) {
    return 'Merhaba $name!';
  }

  @override
  String get ready => 'Hazır';

  @override
  String get onSite => 'Sahada';

  @override
  String get overrideBadge => 'İstisna';

  @override
  String get startShift => 'Kaydı başlat';

  @override
  String get stopShift => 'Kaydı bitir';

  @override
  String get todayTotal => 'Bugün toplam';

  @override
  String get pickJob => 'Bir iş seçin';

  @override
  String get noAssignedActiveJob => 'Size atanmış aktif bir iş yok';

  @override
  String get outsideGeofenceTitle => 'Coğrafi sınırın dışında';

  @override
  String get outsideGeofenceBody =>
      'İş sahasında değilsiniz. Bir neden belirtin, yönetici bilgilendirilecek.';

  @override
  String get overrideReasonLabel => 'İstisna nedeni';

  @override
  String get cancel => 'İptal';

  @override
  String get startWithOverride => 'İstisna ile başlat';

  @override
  String get locationServicesOff => 'Konum servisleri kapalı';

  @override
  String get locationDenied => 'Konum erişimi reddedildi';

  @override
  String get locationDeniedForever =>
      'Konum erişimi kalıcı olarak reddedildi — ayarlardan izin verin';

  @override
  String get jobsTitle => 'İşler';

  @override
  String get newJob => 'Yeni iş';

  @override
  String get noJobs => 'İş yok';

  @override
  String get createJob => 'İş oluştur';

  @override
  String plannedHours(String hours) {
    return '$hours sa planlı';
  }

  @override
  String get editJob => 'İşi düzenle';

  @override
  String get jobName => 'İş adı *';

  @override
  String get requiredField => 'Zorunlu alan';

  @override
  String get description => 'Açıklama';

  @override
  String get address => 'Adres';

  @override
  String get latitude => 'Enlem (lat)';

  @override
  String get longitude => 'Boylam (lon)';

  @override
  String get geofenceRadius => 'Coğrafi sınır yarıçapı (m)';

  @override
  String get enterNumber => 'Bir sayı girin';

  @override
  String get estimatedHours => 'Tahmini saat';

  @override
  String get status => 'Durum';

  @override
  String get statusActive => 'Aktif';

  @override
  String get statusPaused => 'Duraklatıldı';

  @override
  String get statusCompleted => 'Tamamlandı';

  @override
  String get statusArchived => 'Arşivlendi';

  @override
  String get saveChanges => 'Değişiklikleri kaydet';

  @override
  String get jobFallbackTitle => 'İş';

  @override
  String get info => 'Bilgiler';

  @override
  String get manager => 'Yönetici';

  @override
  String get geofence => 'Coğrafi sınır';

  @override
  String get estimatedHoursShort => 'Tahmini saat';

  @override
  String get addressUnset => 'Belirtilmedi';

  @override
  String get assignments => 'Atamalar';

  @override
  String get add => 'Ekle';

  @override
  String errorWith(String error) {
    return 'Hata: $error';
  }

  @override
  String get noAssignedMembers => 'Atanmış üye yok';

  @override
  String get tasks => 'Görevler';

  @override
  String get noTasks => 'Görev yok';

  @override
  String get rosterTitle => 'Ekibim';

  @override
  String get noTeamMembers => 'Ekibinizde üye yok';

  @override
  String get askAdminAssign => 'Üye atamak için bir yöneticiden isteyin';

  @override
  String get reportsTitle => 'Raporlar';

  @override
  String get change => 'Değiştir';

  @override
  String get noReportData => 'Seçilen dönem için veri yok';

  @override
  String totalLabel(String hours) {
    return 'Toplam: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h sa $m dk';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n kayıt',
      one: '$n kayıt',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Kullanıcı yönetimi';

  @override
  String get roleMember => 'Üye';

  @override
  String get roleManager => 'Yönetici';

  @override
  String get roleAdmin => 'Yönetici (admin)';

  @override
  String get roleAdminFull => 'Sistem yöneticisi';
}
