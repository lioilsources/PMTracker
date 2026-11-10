import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/labels.dart';
import '../../shared/widgets/error_view.dart';

part 'roster_screen.g.dart';

@riverpod
Future<List<Map<String, dynamic>>> myRoster(Ref ref) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  return await Supabase.instance.client
      .from('profiles')
      .select()
      .eq('manager_id', userId!);
}

class RosterScreen extends ConsumerWidget {
  const RosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final rosterAsync = ref.watch(myRosterProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l.rosterTitle)),
      body: rosterAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
            error: e.toString(),
            onRetry: () => ref.invalidate(myRosterProvider)),
        data: (members) {
          if (members.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group_outlined,
                      size: 64, color: cs.onSurfaceVariant),
                  const SizedBox(height: 16),
                  Text(l.noTeamMembers),
                  const SizedBox(height: 8),
                  Text(
                    l.askAdminAssign,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: members.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final m = members[i];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: cs.primaryContainer,
                    child: Text(
                      (m['full_name'] as String).isNotEmpty
                          ? (m['full_name'] as String)[0].toUpperCase()
                          : '?',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ),
                  title: Text(m['full_name'] as String),
                  subtitle: Text(roleLabel(l, m['role'] as String, full: true)),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }

}
