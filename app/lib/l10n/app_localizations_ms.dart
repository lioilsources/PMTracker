// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Masa';

  @override
  String get navJobs => 'Kerja';

  @override
  String get navRoster => 'Pasukan';

  @override
  String get navReports => 'Laporan';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Cuba lagi';

  @override
  String get loginSubtitle => 'Rekod masa pada kerja';

  @override
  String get emailLabel => 'E-mel';

  @override
  String get emailInvalid => 'Masukkan e-mel yang sah';

  @override
  String get passwordLabel => 'Kata laluan';

  @override
  String get passwordMin => 'Sekurang-kurangnya 6 aksara';

  @override
  String get signIn => 'Log masuk';

  @override
  String get trackingTitle => 'Rekod masa';

  @override
  String greeting(String name) {
    return 'Hai, $name!';
  }

  @override
  String get ready => 'Sedia';

  @override
  String get onSite => 'Di tapak';

  @override
  String get overrideBadge => 'Pengecualian';

  @override
  String get startShift => 'Mula merekod';

  @override
  String get stopShift => 'Tamat rekod';

  @override
  String get todayTotal => 'Jumlah hari ini';

  @override
  String get pickJob => 'Pilih kerja';

  @override
  String get noAssignedActiveJob =>
      'Anda tidak ditugaskan kepada sebarang kerja aktif';

  @override
  String get outsideGeofenceTitle => 'Di luar geofence';

  @override
  String get outsideGeofenceBody =>
      'Anda tidak berada di tapak kerja. Nyatakan sebab dan pengurus akan dimaklumkan.';

  @override
  String get overrideReasonLabel => 'Sebab pengecualian';

  @override
  String get cancel => 'Batal';

  @override
  String get startWithOverride => 'Mula dengan pengecualian';

  @override
  String get locationServicesOff => 'Perkhidmatan lokasi dimatikan';

  @override
  String get locationDenied => 'Akses lokasi ditolak';

  @override
  String get locationDeniedForever =>
      'Akses lokasi ditolak secara kekal — benarkan dalam tetapan';

  @override
  String get jobsTitle => 'Kerja';

  @override
  String get newJob => 'Kerja baharu';

  @override
  String get noJobs => 'Tiada kerja';

  @override
  String get createJob => 'Cipta kerja';

  @override
  String plannedHours(String hours) {
    return '$hours j dirancang';
  }

  @override
  String get editJob => 'Sunting kerja';

  @override
  String get jobName => 'Nama kerja *';

  @override
  String get requiredField => 'Medan wajib';

  @override
  String get description => 'Penerangan';

  @override
  String get address => 'Alamat';

  @override
  String get latitude => 'Latitud (lat)';

  @override
  String get longitude => 'Longitud (lon)';

  @override
  String get geofenceRadius => 'Jejari geofence (m)';

  @override
  String get enterNumber => 'Masukkan nombor';

  @override
  String get estimatedHours => 'Anggaran jam';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Aktif';

  @override
  String get statusPaused => 'Dijeda';

  @override
  String get statusCompleted => 'Selesai';

  @override
  String get statusArchived => 'Diarkibkan';

  @override
  String get saveChanges => 'Simpan perubahan';

  @override
  String get jobFallbackTitle => 'Kerja';

  @override
  String get info => 'Maklumat';

  @override
  String get manager => 'Pengurus';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Anggaran jam';

  @override
  String get addressUnset => 'Tidak dinyatakan';

  @override
  String get assignments => 'Tugasan';

  @override
  String get add => 'Tambah';

  @override
  String errorWith(String error) {
    return 'Ralat: $error';
  }

  @override
  String get noAssignedMembers => 'Tiada ahli yang ditugaskan';

  @override
  String get tasks => 'Tugas';

  @override
  String get noTasks => 'Tiada tugas';

  @override
  String get rosterTitle => 'Pasukan saya';

  @override
  String get noTeamMembers => 'Anda tiada ahli dalam pasukan';

  @override
  String get askAdminAssign => 'Minta pentadbir menugaskan ahli';

  @override
  String get reportsTitle => 'Laporan';

  @override
  String get change => 'Tukar';

  @override
  String get noReportData => 'Tiada data untuk tempoh yang dipilih';

  @override
  String totalLabel(String hours) {
    return 'Jumlah: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h j $m min';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n rekod',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Pengurusan pengguna';

  @override
  String get roleMember => 'Ahli';

  @override
  String get roleManager => 'Pengurus';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Pentadbir';
}
