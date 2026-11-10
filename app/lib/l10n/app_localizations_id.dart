// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Waktu';

  @override
  String get navJobs => 'Pekerjaan';

  @override
  String get navRoster => 'Tim';

  @override
  String get navReports => 'Laporan';

  @override
  String get navAdmin => 'Admin';

  @override
  String get retry => 'Coba lagi';

  @override
  String get loginSubtitle => 'Pencatatan waktu pada pekerjaan';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailInvalid => 'Masukkan email yang valid';

  @override
  String get passwordLabel => 'Kata sandi';

  @override
  String get passwordMin => 'Minimal 6 karakter';

  @override
  String get signIn => 'Masuk';

  @override
  String get trackingTitle => 'Pencatatan waktu';

  @override
  String greeting(String name) {
    return 'Halo, $name!';
  }

  @override
  String get ready => 'Siap';

  @override
  String get onSite => 'Di lokasi';

  @override
  String get overrideBadge => 'Pengecualian';

  @override
  String get startShift => 'Mulai pencatatan';

  @override
  String get stopShift => 'Akhiri pencatatan';

  @override
  String get todayTotal => 'Total hari ini';

  @override
  String get pickJob => 'Pilih pekerjaan';

  @override
  String get noAssignedActiveJob =>
      'Anda belum ditugaskan ke pekerjaan aktif mana pun';

  @override
  String get outsideGeofenceTitle => 'Di luar geofence';

  @override
  String get outsideGeofenceBody =>
      'Anda tidak berada di lokasi pekerjaan. Tulis alasannya dan manajer akan diberi tahu.';

  @override
  String get overrideReasonLabel => 'Alasan pengecualian';

  @override
  String get cancel => 'Batal';

  @override
  String get startWithOverride => 'Mulai dengan pengecualian';

  @override
  String get locationServicesOff => 'Layanan lokasi dimatikan';

  @override
  String get locationDenied => 'Akses lokasi ditolak';

  @override
  String get locationDeniedForever =>
      'Akses lokasi ditolak permanen — izinkan di pengaturan';

  @override
  String get jobsTitle => 'Pekerjaan';

  @override
  String get newJob => 'Pekerjaan baru';

  @override
  String get noJobs => 'Belum ada pekerjaan';

  @override
  String get createJob => 'Buat pekerjaan';

  @override
  String plannedHours(String hours) {
    return 'Rencana $hours jam';
  }

  @override
  String get editJob => 'Ubah pekerjaan';

  @override
  String get jobName => 'Nama pekerjaan *';

  @override
  String get requiredField => 'Wajib diisi';

  @override
  String get description => 'Deskripsi';

  @override
  String get address => 'Alamat';

  @override
  String get latitude => 'Lintang (lat)';

  @override
  String get longitude => 'Bujur (lon)';

  @override
  String get geofenceRadius => 'Radius geofence (m)';

  @override
  String get enterNumber => 'Masukkan angka';

  @override
  String get estimatedHours => 'Perkiraan jam';

  @override
  String get status => 'Status';

  @override
  String get statusActive => 'Aktif';

  @override
  String get statusPaused => 'Dijeda';

  @override
  String get statusCompleted => 'Selesai';

  @override
  String get statusArchived => 'Diarsipkan';

  @override
  String get saveChanges => 'Simpan perubahan';

  @override
  String get jobFallbackTitle => 'Pekerjaan';

  @override
  String get info => 'Informasi';

  @override
  String get manager => 'Manajer';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Perkiraan jam';

  @override
  String get addressUnset => 'Belum diisi';

  @override
  String get assignments => 'Penugasan';

  @override
  String get add => 'Tambah';

  @override
  String errorWith(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get noAssignedMembers => 'Belum ada anggota yang ditugaskan';

  @override
  String get tasks => 'Tugas';

  @override
  String get noTasks => 'Belum ada tugas';

  @override
  String get rosterTitle => 'Tim saya';

  @override
  String get noTeamMembers => 'Anda tidak punya anggota tim';

  @override
  String get askAdminAssign => 'Minta administrator untuk menugaskan anggota';

  @override
  String get reportsTitle => 'Laporan';

  @override
  String get change => 'Ubah';

  @override
  String get noReportData => 'Tidak ada data untuk periode yang dipilih';

  @override
  String totalLabel(String hours) {
    return 'Total: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h j $m mnt';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n catatan',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Manajemen pengguna';

  @override
  String get roleMember => 'Anggota';

  @override
  String get roleManager => 'Manajer';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleAdminFull => 'Administrator';
}
