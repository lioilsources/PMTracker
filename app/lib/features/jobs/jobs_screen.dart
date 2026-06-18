import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth_provider.dart';
import '../../shared/widgets/error_view.dart';

part 'jobs_screen.g.dart';

@riverpod
Future<List<Map<String, dynamic>>> allJobs(AllJobsRef ref) async {
  return await Supabase.instance.client
      .from('jobs')
      .select('*, profiles!jobs_manager_id_fkey(full_name)')
      .order('created_at', ascending: false) as List<Map<String, dynamic>>;
}

class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(allJobsProvider);
    final profile = ref.watch(currentProfileProvider).valueOrNull;
    final role = profile?['role'] as String? ?? 'member';
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Zakázky')),
      floatingActionButton: (role == 'manager' || role == 'admin')
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/jobs/new'),
              icon: const Icon(Icons.add),
              label: const Text('Nová zakázka'),
            )
          : null,
      body: jobsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
            error: e.toString(),
            onRetry: () => ref.invalidate(allJobsProvider)),
        data: (jobs) {
          if (jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_outline, size: 64, color: cs.onSurfaceVariant),
                  const SizedBox(height: 16),
                  const Text('Žádné zakázky'),
                  if (role == 'manager' || role == 'admin') ...[
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: () => context.push('/jobs/new'),
                      child: const Text('Vytvořit zakázku'),
                    ),
                  ],
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final job = jobs[i];
              final statusColor =
                  _statusColor(job['status'] as String, cs);
              return Card(
                child: InkWell(
                  onTap: () => context.push('/jobs/${job['id']}'),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 64,
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(job['name'] as String,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              if (job['address'] != null)
                                Text(job['address'] as String,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 8,
                                children: [
                                  Chip(
                                    label: Text(
                                        _statusLabel(job['status'] as String)),
                                    backgroundColor:
                                        statusColor.withValues(alpha: 0.15),
                                    side: BorderSide.none,
                                    padding: EdgeInsets.zero,
                                    labelStyle: TextStyle(
                                        color: statusColor, fontSize: 12),
                                  ),
                                  if (job['estimated_hours'] != null)
                                    Chip(
                                      label: Text(
                                          '${job['estimated_hours']}h plán'),
                                      side: BorderSide.none,
                                      padding: EdgeInsets.zero,
                                      labelStyle:
                                          const TextStyle(fontSize: 12),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _statusColor(String status, ColorScheme cs) => switch (status) {
        'active' => Colors.green,
        'paused' => Colors.orange,
        'completed' => cs.primary,
        _ => cs.onSurfaceVariant,
      };

  String _statusLabel(String status) => switch (status) {
        'active' => 'Aktivní',
        'paused' => 'Pozastavena',
        'completed' => 'Dokončena',
        'archived' => 'Archiv',
        _ => status,
      };
}
