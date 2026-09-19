import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../shared/widgets/error_view.dart';

part 'admin_screen.g.dart';

@riverpod
Future<List<Map<String, dynamic>>> allUsers(Ref ref) async {
  return await Supabase.instance.client
      .from('profiles')
      .select()
      .order('full_name');
}

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(allUsersProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Správa uživatelů')),
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
            error: e.toString(),
            onRetry: () => ref.invalidate(allUsersProvider)),
        data: (users) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: users.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final u = users[i];
            final roleColor = switch (u['role'] as String) {
              'admin' => cs.error,
              'manager' => cs.primary,
              _ => cs.onSurfaceVariant,
            };
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: roleColor.withValues(alpha: 0.15),
                child: Text(
                  (u['full_name'] as String).isNotEmpty
                      ? (u['full_name'] as String)[0].toUpperCase()
                      : '?',
                  style: TextStyle(color: roleColor),
                ),
              ),
              title: Text(u['full_name'] as String),
              subtitle:
                  Text(u['id'] as String, style: const TextStyle(fontSize: 11)),
              trailing: _RoleChip(
                userId: u['id'] as String,
                currentRole: u['role'] as String,
                ref: ref,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final String userId;
  final String currentRole;
  final WidgetRef ref;
  const _RoleChip(
      {required this.userId, required this.currentRole, required this.ref});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: currentRole,
      onSelected: (role) async {
        await Supabase.instance.client
            .from('profiles')
            .update({'role': role}).eq('id', userId);
        ref.invalidate(allUsersProvider);
      },
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'member', child: Text('Člen')),
        PopupMenuItem(value: 'manager', child: Text('Manager')),
        PopupMenuItem(value: 'admin', child: Text('Admin')),
      ],
      child: Chip(
        label: Text(_roleLabel(currentRole)),
        padding: EdgeInsets.zero,
        side: BorderSide.none,
      ),
    );
  }

  String _roleLabel(String r) => switch (r) {
        'admin' => 'Admin',
        'manager' => 'Manager',
        _ => 'Člen',
      };
}
