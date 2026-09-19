import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/auth_provider.dart';
import '../features/tracking/tracking_screen.dart';
import '../features/jobs/jobs_screen.dart';
import '../features/jobs/job_detail_screen.dart';
import '../features/jobs/job_form_screen.dart';
import '../features/roster/roster_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/admin/admin_screen.dart';
import '../shared/shell/app_shell.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull?.session != null;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (_, __) => const TrackingScreen()),
          GoRoute(path: '/jobs', builder: (_, __) => const JobsScreen()),
          GoRoute(
            path: '/jobs/new',
            builder: (_, __) => const JobFormScreen(),
          ),
          GoRoute(
            path: '/jobs/:id',
            builder: (_, state) =>
                JobDetailScreen(jobId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/jobs/:id/edit',
            builder: (_, state) =>
                JobFormScreen(jobId: state.pathParameters['id']),
          ),
          GoRoute(path: '/roster', builder: (_, __) => const RosterScreen()),
          GoRoute(path: '/reports', builder: (_, __) => const ReportsScreen()),
          GoRoute(path: '/admin', builder: (_, __) => const AdminScreen()),
        ],
      ),
    ],
  );
}
