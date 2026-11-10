// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => '근무 기록';

  @override
  String get navJobs => '작업';

  @override
  String get navRoster => '팀';

  @override
  String get navReports => '리포트';

  @override
  String get navAdmin => '관리';

  @override
  String get retry => '다시 시도';

  @override
  String get loginSubtitle => '작업별 근무 시간 기록';

  @override
  String get emailLabel => '이메일';

  @override
  String get emailInvalid => '올바른 이메일을 입력하세요';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get passwordMin => '6자 이상';

  @override
  String get signIn => '로그인';

  @override
  String get trackingTitle => '근무 시간 기록';

  @override
  String greeting(String name) {
    return '$name님, 안녕하세요!';
  }

  @override
  String get ready => '준비됨';

  @override
  String get onSite => '현장에 있음';

  @override
  String get overrideBadge => '예외';

  @override
  String get startShift => '기록 시작';

  @override
  String get stopShift => '기록 종료';

  @override
  String get todayTotal => '오늘 합계';

  @override
  String get pickJob => '작업을 선택하세요';

  @override
  String get noAssignedActiveJob => '배정된 진행 중인 작업이 없습니다';

  @override
  String get outsideGeofenceTitle => '지오펜스 밖입니다';

  @override
  String get outsideGeofenceBody => '작업 현장에 있지 않습니다. 사유를 입력하면 매니저에게 알려집니다.';

  @override
  String get overrideReasonLabel => '예외 사유';

  @override
  String get cancel => '취소';

  @override
  String get startWithOverride => '예외로 시작';

  @override
  String get locationServicesOff => '위치 서비스가 꺼져 있습니다';

  @override
  String get locationDenied => '위치 접근이 거부되었습니다';

  @override
  String get locationDeniedForever => '위치 접근이 영구적으로 거부되었습니다. 설정에서 허용해 주세요';

  @override
  String get jobsTitle => '작업';

  @override
  String get newJob => '새 작업';

  @override
  String get noJobs => '작업이 없습니다';

  @override
  String get createJob => '작업 만들기';

  @override
  String plannedHours(String hours) {
    return '계획 $hours시간';
  }

  @override
  String get editJob => '작업 수정';

  @override
  String get jobName => '작업 이름 *';

  @override
  String get requiredField => '필수 항목입니다';

  @override
  String get description => '설명';

  @override
  String get address => '주소';

  @override
  String get latitude => '위도 (lat)';

  @override
  String get longitude => '경도 (lon)';

  @override
  String get geofenceRadius => '지오펜스 반경 (m)';

  @override
  String get enterNumber => '숫자를 입력하세요';

  @override
  String get estimatedHours => '예상 시간';

  @override
  String get status => '상태';

  @override
  String get statusActive => '진행 중';

  @override
  String get statusPaused => '일시 중지';

  @override
  String get statusCompleted => '완료';

  @override
  String get statusArchived => '보관됨';

  @override
  String get saveChanges => '변경 사항 저장';

  @override
  String get jobFallbackTitle => '작업';

  @override
  String get info => '정보';

  @override
  String get manager => '매니저';

  @override
  String get geofence => '지오펜스';

  @override
  String get estimatedHoursShort => '예상 시간';

  @override
  String get addressUnset => '입력되지 않음';

  @override
  String get assignments => '배정';

  @override
  String get add => '추가';

  @override
  String errorWith(String error) {
    return '오류: $error';
  }

  @override
  String get noAssignedMembers => '배정된 멤버가 없습니다';

  @override
  String get tasks => '할 일';

  @override
  String get noTasks => '할 일이 없습니다';

  @override
  String get rosterTitle => '내 팀';

  @override
  String get noTeamMembers => '팀에 멤버가 없습니다';

  @override
  String get askAdminAssign => '관리자에게 멤버 배정을 요청하세요';

  @override
  String get reportsTitle => '리포트';

  @override
  String get change => '변경';

  @override
  String get noReportData => '선택한 기간에 데이터가 없습니다';

  @override
  String totalLabel(String hours) {
    return '합계: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h시간 $m분';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '기록 $n건',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => '사용자 관리';

  @override
  String get roleMember => '멤버';

  @override
  String get roleManager => '매니저';

  @override
  String get roleAdmin => '관리자';

  @override
  String get roleAdminFull => '관리자';
}
