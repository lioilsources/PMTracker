import '../l10n/app_localizations.dart';

/// Localized label of a profile role (`member`, `manager`, `admin`); [full] spells out "administrator".
String roleLabel(AppLocalizations l, String role, {bool full = false, String? fallback}) => switch (role) {
      'admin' => full ? l.roleAdminFull : l.roleAdmin,
      'manager' => l.roleManager,
      'member' => l.roleMember,
      _ => fallback ?? role,
    };

/// Localized label of a job status.
String jobStatusLabel(AppLocalizations l, String status) => switch (status) {
      'active' => l.statusActive,
      'paused' => l.statusPaused,
      'completed' => l.statusCompleted,
      'archived' => l.statusArchived,
      _ => status,
    };
