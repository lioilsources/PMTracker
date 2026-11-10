// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'ลงเวลา';

  @override
  String get navJobs => 'งาน';

  @override
  String get navRoster => 'ทีม';

  @override
  String get navReports => 'รายงาน';

  @override
  String get navAdmin => 'ผู้ดูแล';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get loginSubtitle => 'บันทึกเวลาทำงานในแต่ละงาน';

  @override
  String get emailLabel => 'อีเมล';

  @override
  String get emailInvalid => 'กรอกอีเมลที่ถูกต้อง';

  @override
  String get passwordLabel => 'รหัสผ่าน';

  @override
  String get passwordMin => 'อย่างน้อย 6 ตัวอักษร';

  @override
  String get signIn => 'เข้าสู่ระบบ';

  @override
  String get trackingTitle => 'บันทึกเวลาทำงาน';

  @override
  String greeting(String name) {
    return 'สวัสดี $name!';
  }

  @override
  String get ready => 'พร้อม';

  @override
  String get onSite => 'อยู่ที่หน้างาน';

  @override
  String get overrideBadge => 'ข้อยกเว้น';

  @override
  String get startShift => 'เริ่มบันทึกเวลา';

  @override
  String get stopShift => 'สิ้นสุดการบันทึกเวลา';

  @override
  String get todayTotal => 'รวมวันนี้';

  @override
  String get pickJob => 'เลือกงาน';

  @override
  String get noAssignedActiveJob => 'คุณไม่ได้รับมอบหมายงานที่กำลังดำเนินการ';

  @override
  String get outsideGeofenceTitle => 'อยู่นอกเขตจีโอเฟนซ์';

  @override
  String get outsideGeofenceBody =>
      'คุณไม่ได้อยู่ที่หน้างาน ระบุเหตุผลแล้วผู้จัดการจะได้รับแจ้ง';

  @override
  String get overrideReasonLabel => 'เหตุผลของข้อยกเว้น';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get startWithOverride => 'เริ่มโดยใช้ข้อยกเว้น';

  @override
  String get locationServicesOff => 'บริการตำแหน่งปิดอยู่';

  @override
  String get locationDenied => 'ปฏิเสธการเข้าถึงตำแหน่ง';

  @override
  String get locationDeniedForever =>
      'ปฏิเสธการเข้าถึงตำแหน่งถาวร — อนุญาตได้ในการตั้งค่า';

  @override
  String get jobsTitle => 'งาน';

  @override
  String get newJob => 'งานใหม่';

  @override
  String get noJobs => 'ไม่มีงาน';

  @override
  String get createJob => 'สร้างงาน';

  @override
  String plannedHours(String hours) {
    return 'วางแผน $hours ชม.';
  }

  @override
  String get editJob => 'แก้ไขงาน';

  @override
  String get jobName => 'ชื่องาน *';

  @override
  String get requiredField => 'จำเป็นต้องกรอก';

  @override
  String get description => 'รายละเอียด';

  @override
  String get address => 'ที่อยู่';

  @override
  String get latitude => 'ละติจูด (lat)';

  @override
  String get longitude => 'ลองจิจูด (lon)';

  @override
  String get geofenceRadius => 'รัศมีจีโอเฟนซ์ (ม.)';

  @override
  String get enterNumber => 'กรอกตัวเลข';

  @override
  String get estimatedHours => 'ชั่วโมงโดยประมาณ';

  @override
  String get status => 'สถานะ';

  @override
  String get statusActive => 'ดำเนินการอยู่';

  @override
  String get statusPaused => 'หยุดชั่วคราว';

  @override
  String get statusCompleted => 'เสร็จสิ้น';

  @override
  String get statusArchived => 'เก็บถาวร';

  @override
  String get saveChanges => 'บันทึกการเปลี่ยนแปลง';

  @override
  String get jobFallbackTitle => 'งาน';

  @override
  String get info => 'ข้อมูล';

  @override
  String get manager => 'ผู้จัดการ';

  @override
  String get geofence => 'จีโอเฟนซ์';

  @override
  String get estimatedHoursShort => 'ชั่วโมงโดยประมาณ';

  @override
  String get addressUnset => 'ไม่ได้ระบุ';

  @override
  String get assignments => 'การมอบหมาย';

  @override
  String get add => 'เพิ่ม';

  @override
  String errorWith(String error) {
    return 'ข้อผิดพลาด: $error';
  }

  @override
  String get noAssignedMembers => 'ไม่มีสมาชิกที่ได้รับมอบหมาย';

  @override
  String get tasks => 'งานย่อย';

  @override
  String get noTasks => 'ไม่มีงานย่อย';

  @override
  String get rosterTitle => 'ทีมของฉัน';

  @override
  String get noTeamMembers => 'คุณไม่มีสมาชิกในทีม';

  @override
  String get askAdminAssign => 'ขอให้ผู้ดูแลมอบหมายสมาชิก';

  @override
  String get reportsTitle => 'รายงาน';

  @override
  String get change => 'เปลี่ยน';

  @override
  String get noReportData => 'ไม่มีข้อมูลในช่วงเวลาที่เลือก';

  @override
  String totalLabel(String hours) {
    return 'รวม: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h ชม. $m นาที';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n รายการ',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'จัดการผู้ใช้';

  @override
  String get roleMember => 'สมาชิก';

  @override
  String get roleManager => 'ผู้จัดการ';

  @override
  String get roleAdmin => 'ผู้ดูแล';

  @override
  String get roleAdminFull => 'ผู้ดูแลระบบ';
}
