// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'PMTracker';

  @override
  String get navTracking => '打刻';

  @override
  String get navJobs => '案件';

  @override
  String get navRoster => 'チーム';

  @override
  String get navReports => 'レポート';

  @override
  String get navAdmin => '管理';

  @override
  String get retry => '再試行';

  @override
  String get loginSubtitle => '案件ごとの勤務時間記録';

  @override
  String get emailLabel => 'メールアドレス';

  @override
  String get emailInvalid => '有効なメールアドレスを入力してください';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get passwordMin => '6文字以上';

  @override
  String get signIn => 'ログイン';

  @override
  String get trackingTitle => '勤務時間の記録';

  @override
  String greeting(String name) {
    return 'こんにちは、$nameさん！';
  }

  @override
  String get ready => '待機中';

  @override
  String get onSite => '現場にいます';

  @override
  String get overrideBadge => '例外';

  @override
  String get startShift => '記録を開始';

  @override
  String get stopShift => '記録を終了';

  @override
  String get todayTotal => '本日の合計';

  @override
  String get pickJob => '案件を選択';

  @override
  String get noAssignedActiveJob => '担当している進行中の案件がありません';

  @override
  String get outsideGeofenceTitle => 'ジオフェンス外です';

  @override
  String get outsideGeofenceBody => '案件の現場にいません。理由を入力すると、マネージャーに通知されます。';

  @override
  String get overrideReasonLabel => '例外の理由';

  @override
  String get cancel => 'キャンセル';

  @override
  String get startWithOverride => '例外として開始';

  @override
  String get locationServicesOff => '位置情報サービスがオフです';

  @override
  String get locationDenied => '位置情報へのアクセスが拒否されました';

  @override
  String get locationDeniedForever => '位置情報へのアクセスが永続的に拒否されています。設定で許可してください';

  @override
  String get jobsTitle => '案件';

  @override
  String get newJob => '新規案件';

  @override
  String get noJobs => '案件がありません';

  @override
  String get createJob => '案件を作成';

  @override
  String plannedHours(String hours) {
    return '予定 $hours 時間';
  }

  @override
  String get editJob => '案件を編集';

  @override
  String get jobName => '案件名 *';

  @override
  String get requiredField => '必須項目です';

  @override
  String get description => '説明';

  @override
  String get address => '住所';

  @override
  String get latitude => '緯度 (lat)';

  @override
  String get longitude => '経度 (lon)';

  @override
  String get geofenceRadius => 'ジオフェンス半径 (m)';

  @override
  String get enterNumber => '数値を入力してください';

  @override
  String get estimatedHours => '見積時間';

  @override
  String get status => 'ステータス';

  @override
  String get statusActive => '進行中';

  @override
  String get statusPaused => '一時停止';

  @override
  String get statusCompleted => '完了';

  @override
  String get statusArchived => 'アーカイブ';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get jobFallbackTitle => '案件';

  @override
  String get info => '情報';

  @override
  String get manager => 'マネージャー';

  @override
  String get geofence => 'ジオフェンス';

  @override
  String get estimatedHoursShort => '見積時間';

  @override
  String get addressUnset => '未入力';

  @override
  String get assignments => '担当者';

  @override
  String get add => '追加';

  @override
  String errorWith(String error) {
    return 'エラー: $error';
  }

  @override
  String get noAssignedMembers => '担当メンバーがいません';

  @override
  String get tasks => 'タスク';

  @override
  String get noTasks => 'タスクがありません';

  @override
  String get rosterTitle => 'マイチーム';

  @override
  String get noTeamMembers => 'チームにメンバーがいません';

  @override
  String get askAdminAssign => '管理者にメンバーの割り当てを依頼してください';

  @override
  String get reportsTitle => 'レポート';

  @override
  String get change => '変更';

  @override
  String get noReportData => '選択した期間のデータがありません';

  @override
  String totalLabel(String hours) {
    return '合計: $hours';
  }

  @override
  String hoursMinutes(int h, String m) {
    return '$h時間$m分';
  }

  @override
  String entryCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n件の記録',
    );
    return '$_temp0';
  }

  @override
  String get adminTitle => 'ユーザー管理';

  @override
  String get roleMember => 'メンバー';

  @override
  String get roleManager => 'マネージャー';

  @override
  String get roleAdmin => '管理者';

  @override
  String get roleAdminFull => '管理者';
}
