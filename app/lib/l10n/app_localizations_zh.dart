// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => '打卡';

  @override
  String get navJobs => '项目';

  @override
  String get navRoster => '团队';

  @override
  String get navReports => '报表';

  @override
  String get navAdmin => '管理';

  @override
  String get retry => '重试';

  @override
  String get loginSubtitle => '按项目记录工时';

  @override
  String get emailLabel => '电子邮箱';

  @override
  String get emailInvalid => '请输入有效的电子邮箱';

  @override
  String get passwordLabel => '密码';

  @override
  String get passwordMin => '至少 6 个字符';

  @override
  String get signIn => '登录';

  @override
  String get trackingTitle => '工时记录';

  @override
  String greeting(String name) {
    return '你好，$name！';
  }

  @override
  String get ready => '就绪';

  @override
  String get onSite => '在现场';

  @override
  String get overrideBadge => '例外';

  @override
  String get startShift => '开始记录';

  @override
  String get stopShift => '结束记录';

  @override
  String get todayTotal => '今日合计';

  @override
  String get pickJob => '选择项目';

  @override
  String get noAssignedActiveJob => '你没有被分配任何进行中的项目';

  @override
  String get outsideGeofenceTitle => '不在地理围栏内';

  @override
  String get outsideGeofenceBody => '你不在项目现场。请说明原因，经理会收到通知。';

  @override
  String get overrideReasonLabel => '例外原因';

  @override
  String get cancel => '取消';

  @override
  String get startWithOverride => '以例外开始';

  @override
  String get locationServicesOff => '定位服务已关闭';

  @override
  String get locationDenied => '定位权限被拒绝';

  @override
  String get locationDeniedForever => '定位权限被永久拒绝——请在设置中允许';

  @override
  String get jobsTitle => '项目';

  @override
  String get newJob => '新建项目';

  @override
  String get noJobs => '暂无项目';

  @override
  String get createJob => '创建项目';

  @override
  String plannedHours(String hours) {
    return '计划 $hours 小时';
  }

  @override
  String get editJob => '编辑项目';

  @override
  String get jobName => '项目名称 *';

  @override
  String get requiredField => '必填项';

  @override
  String get description => '说明';

  @override
  String get address => '地址';

  @override
  String get latitude => '纬度 (lat)';

  @override
  String get longitude => '经度 (lon)';

  @override
  String get geofenceRadius => '地理围栏半径（米）';

  @override
  String get enterNumber => '请输入数字';

  @override
  String get estimatedHours => '预估工时';

  @override
  String get status => '状态';

  @override
  String get statusActive => '进行中';

  @override
  String get statusPaused => '已暂停';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusArchived => '已归档';

  @override
  String get saveChanges => '保存更改';

  @override
  String get jobFallbackTitle => '项目';

  @override
  String get info => '信息';

  @override
  String get manager => '经理';

  @override
  String get geofence => '地理围栏';

  @override
  String get estimatedHoursShort => '预估工时';

  @override
  String get addressUnset => '未填写';

  @override
  String get assignments => '分配';

  @override
  String get add => '添加';

  @override
  String errorWith(String error) {
    return '错误：$error';
  }

  @override
  String get noAssignedMembers => '暂无已分配的成员';

  @override
  String get tasks => '任务';

  @override
  String get noTasks => '暂无任务';

  @override
  String get rosterTitle => '我的团队';

  @override
  String get noTeamMembers => '你的团队中没有成员';

  @override
  String get askAdminAssign => '请联系管理员分配成员';

  @override
  String get reportsTitle => '报表';

  @override
  String get change => '更改';

  @override
  String get noReportData => '所选时间段没有数据';

  @override
  String totalLabel(String hours) {
    return '合计：$hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h 小时 $m 分钟';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 条记录',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => '用户管理';

  @override
  String get roleMember => '成员';

  @override
  String get roleManager => '经理';

  @override
  String get roleAdmin => '管理员';

  @override
  String get roleAdminFull => '系统管理员';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => '打卡';

  @override
  String get navJobs => '项目';

  @override
  String get navRoster => '团队';

  @override
  String get navReports => '报表';

  @override
  String get navAdmin => '管理';

  @override
  String get retry => '重试';

  @override
  String get loginSubtitle => '按项目记录工时';

  @override
  String get emailLabel => '电子邮箱';

  @override
  String get emailInvalid => '请输入有效的电子邮箱';

  @override
  String get passwordLabel => '密码';

  @override
  String get passwordMin => '至少 6 个字符';

  @override
  String get signIn => '登录';

  @override
  String get trackingTitle => '工时记录';

  @override
  String greeting(String name) {
    return '你好，$name！';
  }

  @override
  String get ready => '就绪';

  @override
  String get onSite => '在现场';

  @override
  String get overrideBadge => '例外';

  @override
  String get startShift => '开始记录';

  @override
  String get stopShift => '结束记录';

  @override
  String get todayTotal => '今日合计';

  @override
  String get pickJob => '选择项目';

  @override
  String get noAssignedActiveJob => '你没有被分配任何进行中的项目';

  @override
  String get outsideGeofenceTitle => '不在地理围栏内';

  @override
  String get outsideGeofenceBody => '你不在项目现场。请说明原因，经理会收到通知。';

  @override
  String get overrideReasonLabel => '例外原因';

  @override
  String get cancel => '取消';

  @override
  String get startWithOverride => '以例外开始';

  @override
  String get locationServicesOff => '定位服务已关闭';

  @override
  String get locationDenied => '定位权限被拒绝';

  @override
  String get locationDeniedForever => '定位权限被永久拒绝——请在设置中允许';

  @override
  String get jobsTitle => '项目';

  @override
  String get newJob => '新建项目';

  @override
  String get noJobs => '暂无项目';

  @override
  String get createJob => '创建项目';

  @override
  String plannedHours(String hours) {
    return '计划 $hours 小时';
  }

  @override
  String get editJob => '编辑项目';

  @override
  String get jobName => '项目名称 *';

  @override
  String get requiredField => '必填项';

  @override
  String get description => '说明';

  @override
  String get address => '地址';

  @override
  String get latitude => '纬度 (lat)';

  @override
  String get longitude => '经度 (lon)';

  @override
  String get geofenceRadius => '地理围栏半径（米）';

  @override
  String get enterNumber => '请输入数字';

  @override
  String get estimatedHours => '预估工时';

  @override
  String get status => '状态';

  @override
  String get statusActive => '进行中';

  @override
  String get statusPaused => '已暂停';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusArchived => '已归档';

  @override
  String get saveChanges => '保存更改';

  @override
  String get jobFallbackTitle => '项目';

  @override
  String get info => '信息';

  @override
  String get manager => '经理';

  @override
  String get geofence => '地理围栏';

  @override
  String get estimatedHoursShort => '预估工时';

  @override
  String get addressUnset => '未填写';

  @override
  String get assignments => '分配';

  @override
  String get add => '添加';

  @override
  String errorWith(String error) {
    return '错误：$error';
  }

  @override
  String get noAssignedMembers => '暂无已分配的成员';

  @override
  String get tasks => '任务';

  @override
  String get noTasks => '暂无任务';

  @override
  String get rosterTitle => '我的团队';

  @override
  String get noTeamMembers => '你的团队中没有成员';

  @override
  String get askAdminAssign => '请联系管理员分配成员';

  @override
  String get reportsTitle => '报表';

  @override
  String get change => '更改';

  @override
  String get noReportData => '所选时间段没有数据';

  @override
  String totalLabel(String hours) {
    return '合计：$hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h 小时 $m 分钟';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 条记录',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => '用户管理';

  @override
  String get roleMember => '成员';

  @override
  String get roleManager => '经理';

  @override
  String get roleAdmin => '管理员';

  @override
  String get roleAdminFull => '系统管理员';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => '打卡';

  @override
  String get navJobs => '專案';

  @override
  String get navRoster => '團隊';

  @override
  String get navReports => '報表';

  @override
  String get navAdmin => '管理';

  @override
  String get retry => '重試';

  @override
  String get loginSubtitle => '依專案記錄工時';

  @override
  String get emailLabel => '電子郵件';

  @override
  String get emailInvalid => '請輸入有效的電子郵件';

  @override
  String get passwordLabel => '密碼';

  @override
  String get passwordMin => '至少 6 個字元';

  @override
  String get signIn => '登入';

  @override
  String get trackingTitle => '工時記錄';

  @override
  String greeting(String name) {
    return '你好，$name！';
  }

  @override
  String get ready => '就緒';

  @override
  String get onSite => '在現場';

  @override
  String get overrideBadge => '例外';

  @override
  String get startShift => '開始記錄';

  @override
  String get stopShift => '結束記錄';

  @override
  String get todayTotal => '今日合計';

  @override
  String get pickJob => '選擇專案';

  @override
  String get noAssignedActiveJob => '你沒有被分配任何進行中的專案';

  @override
  String get outsideGeofenceTitle => '不在地理圍欄內';

  @override
  String get outsideGeofenceBody => '你不在專案現場。請說明原因，經理會收到通知。';

  @override
  String get overrideReasonLabel => '例外原因';

  @override
  String get cancel => '取消';

  @override
  String get startWithOverride => '以例外開始';

  @override
  String get locationServicesOff => '定位服務已關閉';

  @override
  String get locationDenied => '定位權限被拒絕';

  @override
  String get locationDeniedForever => '定位權限被永久拒絕——請在設定中允許';

  @override
  String get jobsTitle => '專案';

  @override
  String get newJob => '新增專案';

  @override
  String get noJobs => '尚無專案';

  @override
  String get createJob => '建立專案';

  @override
  String plannedHours(String hours) {
    return '計劃 $hours 小時';
  }

  @override
  String get editJob => '編輯專案';

  @override
  String get jobName => '專案名稱 *';

  @override
  String get requiredField => '必填欄位';

  @override
  String get description => '說明';

  @override
  String get address => '地址';

  @override
  String get latitude => '緯度 (lat)';

  @override
  String get longitude => '經度 (lon)';

  @override
  String get geofenceRadius => '地理圍欄半徑（公尺）';

  @override
  String get enterNumber => '請輸入數字';

  @override
  String get estimatedHours => '預估工時';

  @override
  String get status => '狀態';

  @override
  String get statusActive => '進行中';

  @override
  String get statusPaused => '已暫停';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusArchived => '已封存';

  @override
  String get saveChanges => '儲存變更';

  @override
  String get jobFallbackTitle => '專案';

  @override
  String get info => '資訊';

  @override
  String get manager => '經理';

  @override
  String get geofence => '地理圍欄';

  @override
  String get estimatedHoursShort => '預估工時';

  @override
  String get addressUnset => '未填寫';

  @override
  String get assignments => '分配';

  @override
  String get add => '新增';

  @override
  String errorWith(String error) {
    return '錯誤：$error';
  }

  @override
  String get noAssignedMembers => '尚無已分配的成員';

  @override
  String get tasks => '任務';

  @override
  String get noTasks => '尚無任務';

  @override
  String get rosterTitle => '我的團隊';

  @override
  String get noTeamMembers => '你的團隊中沒有成員';

  @override
  String get askAdminAssign => '請聯絡管理員分配成員';

  @override
  String get reportsTitle => '報表';

  @override
  String get change => '變更';

  @override
  String get noReportData => '所選期間沒有資料';

  @override
  String totalLabel(String hours) {
    return '合計：$hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h 小時 $m 分鐘';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 筆記錄',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => '使用者管理';

  @override
  String get roleMember => '成員';

  @override
  String get roleManager => '經理';

  @override
  String get roleAdmin => '管理員';

  @override
  String get roleAdminFull => '系統管理員';
}
