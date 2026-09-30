import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/auth_provider.dart';

class AppShell extends ConsumerWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentProfileProvider).value;
    final role = profile?['role'] as String? ?? 'member';
    final location = GoRouterState.of(context).matchedLocation;

    int selectedIndex = 0;
    if (location.startsWith('/jobs')) selectedIndex = 1;
    if (location.startsWith('/roster')) selectedIndex = 2;
    if (location.startsWith('/reports')) selectedIndex = 3;
    if (location.startsWith('/admin')) selectedIndex = 4;

    final destinations = <NavigationDestination>[
      const NavigationDestination(
        icon: Icon(Icons.timer_outlined),
        selectedIcon: Icon(Icons.timer),
        label: 'Výkaz',
      ),
      const NavigationDestination(
        icon: Icon(Icons.work_outline),
        selectedIcon: Icon(Icons.work),
        label: 'Zakázky',
      ),
      if (role == 'manager' || role == 'admin')
        const NavigationDestination(
          icon: Icon(Icons.group_outlined),
          selectedIcon: Icon(Icons.group),
          label: 'Roster',
        ),
      if (role == 'manager' || role == 'admin')
        const NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart),
          label: 'Reporty',
        ),
      if (role == 'admin')
        const NavigationDestination(
          icon: Icon(Icons.admin_panel_settings_outlined),
          selectedIcon: Icon(Icons.admin_panel_settings),
          label: 'Admin',
        ),
    ];

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex.clamp(0, destinations.length - 1),
        onDestinationSelected: (i) {
          final routes = [
            '/',
            '/jobs',
            if (role == 'manager' || role == 'admin') '/roster',
            if (role == 'manager' || role == 'admin') '/reports',
            if (role == 'admin') '/admin',
          ];
          context.go(routes[i]);
        },
        destinations: destinations,
      ),
    );
  }
}
