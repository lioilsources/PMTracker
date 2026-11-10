// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => 'Chấm công';

  @override
  String get navJobs => 'Công việc';

  @override
  String get navRoster => 'Nhóm';

  @override
  String get navReports => 'Báo cáo';

  @override
  String get navAdmin => 'Quản trị';

  @override
  String get retry => 'Thử lại';

  @override
  String get loginSubtitle => 'Ghi nhận thời gian theo công việc';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailInvalid => 'Nhập email hợp lệ';

  @override
  String get passwordLabel => 'Mật khẩu';

  @override
  String get passwordMin => 'Tối thiểu 6 ký tự';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get trackingTitle => 'Chấm công';

  @override
  String greeting(String name) {
    return 'Xin chào, $name!';
  }

  @override
  String get ready => 'Sẵn sàng';

  @override
  String get onSite => 'Tại hiện trường';

  @override
  String get overrideBadge => 'Ngoại lệ';

  @override
  String get startShift => 'Bắt đầu chấm công';

  @override
  String get stopShift => 'Kết thúc chấm công';

  @override
  String get todayTotal => 'Tổng hôm nay';

  @override
  String get pickJob => 'Chọn công việc';

  @override
  String get noAssignedActiveJob =>
      'Bạn chưa được giao công việc đang hoạt động nào';

  @override
  String get outsideGeofenceTitle => 'Ngoài vùng geofence';

  @override
  String get outsideGeofenceBody =>
      'Bạn không ở địa điểm làm việc. Hãy nêu lý do, quản lý sẽ được thông báo.';

  @override
  String get overrideReasonLabel => 'Lý do ngoại lệ';

  @override
  String get cancel => 'Hủy';

  @override
  String get startWithOverride => 'Bắt đầu với ngoại lệ';

  @override
  String get locationServicesOff => 'Dịch vụ vị trí đang tắt';

  @override
  String get locationDenied => 'Quyền truy cập vị trí bị từ chối';

  @override
  String get locationDeniedForever =>
      'Quyền truy cập vị trí bị từ chối vĩnh viễn — hãy cho phép trong cài đặt';

  @override
  String get jobsTitle => 'Công việc';

  @override
  String get newJob => 'Công việc mới';

  @override
  String get noJobs => 'Chưa có công việc';

  @override
  String get createJob => 'Tạo công việc';

  @override
  String plannedHours(String hours) {
    return 'Dự kiến $hours giờ';
  }

  @override
  String get editJob => 'Sửa công việc';

  @override
  String get jobName => 'Tên công việc *';

  @override
  String get requiredField => 'Trường bắt buộc';

  @override
  String get description => 'Mô tả';

  @override
  String get address => 'Địa chỉ';

  @override
  String get latitude => 'Vĩ độ (lat)';

  @override
  String get longitude => 'Kinh độ (lon)';

  @override
  String get geofenceRadius => 'Bán kính geofence (m)';

  @override
  String get enterNumber => 'Nhập một số';

  @override
  String get estimatedHours => 'Số giờ ước tính';

  @override
  String get status => 'Trạng thái';

  @override
  String get statusActive => 'Đang hoạt động';

  @override
  String get statusPaused => 'Tạm dừng';

  @override
  String get statusCompleted => 'Hoàn thành';

  @override
  String get statusArchived => 'Đã lưu trữ';

  @override
  String get saveChanges => 'Lưu thay đổi';

  @override
  String get jobFallbackTitle => 'Công việc';

  @override
  String get info => 'Thông tin';

  @override
  String get manager => 'Quản lý';

  @override
  String get geofence => 'Geofence';

  @override
  String get estimatedHoursShort => 'Giờ ước tính';

  @override
  String get addressUnset => 'Chưa nhập';

  @override
  String get assignments => 'Phân công';

  @override
  String get add => 'Thêm';

  @override
  String errorWith(String error) {
    return 'Lỗi: $error';
  }

  @override
  String get noAssignedMembers => 'Chưa có thành viên được phân công';

  @override
  String get tasks => 'Nhiệm vụ';

  @override
  String get noTasks => 'Chưa có nhiệm vụ';

  @override
  String get rosterTitle => 'Nhóm của tôi';

  @override
  String get noTeamMembers => 'Nhóm của bạn chưa có thành viên';

  @override
  String get askAdminAssign => 'Hãy nhờ quản trị viên phân công thành viên';

  @override
  String get reportsTitle => 'Báo cáo';

  @override
  String get change => 'Đổi';

  @override
  String get noReportData => 'Không có dữ liệu cho khoảng thời gian đã chọn';

  @override
  String totalLabel(String hours) {
    return 'Tổng: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h giờ $m phút';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n bản ghi',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'Quản lý người dùng';

  @override
  String get roleMember => 'Thành viên';

  @override
  String get roleManager => 'Quản lý';

  @override
  String get roleAdmin => 'Quản trị';

  @override
  String get roleAdminFull => 'Quản trị viên';
}
