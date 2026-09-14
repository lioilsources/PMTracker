import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth_provider.dart';
import '../../shared/widgets/error_view.dart';

part 'job_detail_screen.g.dart';

@riverpod
Future<Map<String, dynamic>> jobDetail(Ref ref, String jobId) async {
  final result = await Supabase.instance.client
      .from('jobs')
      .select('*, profiles!jobs_manager_id_fkey(full_name)')
      .eq('id', jobId)
      .single();
  return result;
}

@riverpod
Future<List<Map<String, dynamic>>> jobTasks(
    Ref ref, String jobId) async {
  return await Supabase.instance.client
      .from('tasks')
      .select()
      .eq('job_id', jobId)
      .order('sort_order');
}

@riverpod
Future<List<Map<String, dynamic>>> jobAssignments(
    Ref ref, String jobId) async {
  return await Supabase.instance.client
      .from('job_assignments')
      .select(
          '*, profiles!job_assignments_member_id_fkey(full_name, role)')
      .eq('job_id', jobId);
}

class JobDetailScreen extends ConsumerWidget {
  final String jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobDetailProvider(jobId));
    final tasksAsync = ref.watch(jobTasksProvider(jobId));
    final assignmentsAsync = ref.watch(jobAssignmentsProvider(jobId));
    final profile = ref.watch(currentProfileProvider).value;
    final role = profile?['role'] as String? ?? 'member';
    final isManager = role == 'manager' || role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: jobAsync.maybeWhen(
            data: (j) => Text(j['name'] as String),
            orElse: () => const Text('Zakázka')),
        actions: [
          if (isManager)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => context.push('/jobs/$jobId/edit'),
            ),
        ],
      ),
      body: jobAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
            error: e.toString(),
            onRetry: () => ref.invalidate(jobDetailProvider(jobId))),
        data: (job) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _InfoCard(job: job),
            const SizedBox(height: 16),
            _AssignmentsCard(
              assignmentsAsync: assignmentsAsync,
              jobId: jobId,
              isManager: isManager,
              ref: ref,
            ),
            const SizedBox(height: 16),
            _TasksCard(
              tasksAsync: tasksAsync,
              jobId: jobId,
              isManager: isManager,
              ref: ref,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Map<String, dynamic> job;
  const _InfoCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Informace',
                style: Theme.of(context).textTheme.titleMedium),
            const Divider(),
            if (job['description'] != null) ...[
              Text(job['description'] as String),
              const SizedBox(height: 8),
            ],
            _Row(
                icon: Icons.person,
                label: 'Manager',
                value: job['profiles']?['full_name'] ?? '-'),
            _Row(
                icon: Icons.location_on,
                label: 'Adresa',
                value: job['address'] ?? 'Nezadána'),
            _Row(
                icon: Icons.radar,
                label: 'Geofence',
                value: '${job['geofence_radius_m']} m'),
            if (job['estimated_hours'] != null)
              _Row(
                  icon: Icons.schedule,
                  label: 'Odhad hodin',
                  value: '${job['estimated_hours']} h'),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _Row({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Text('$label: ',
              style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

class _AssignmentsCard extends StatelessWidget {
  final AsyncValue<List<Map<String, dynamic>>> assignmentsAsync;
  final String jobId;
  final bool isManager;
  final WidgetRef ref;
  const _AssignmentsCard({
    required this.assignmentsAsync,
    required this.jobId,
    required this.isManager,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Přiřazení',
                    style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                if (isManager)
                  TextButton.icon(
                    icon: const Icon(Icons.person_add, size: 16),
                    label: const Text('Přidat'),
                    onPressed: () {}, // TODO: implementovat
                  ),
              ],
            ),
            const Divider(),
            assignmentsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Chyba: $e'),
              data: (assignments) => assignments.isEmpty
                  ? const Text('Žádní přiřazení členové')
                  : Column(
                      children: assignments
                          .map((a) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const CircleAvatar(
                                    child: Icon(Icons.person)),
                                title: Text(a['profiles']?['full_name'] ?? '-'),
                                subtitle:
                                    Text(a['profiles']?['role'] ?? '-'),
                              ))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TasksCard extends StatelessWidget {
  final AsyncValue<List<Map<String, dynamic>>> tasksAsync;
  final String jobId;
  final bool isManager;
  final WidgetRef ref;
  const _TasksCard({
    required this.tasksAsync,
    required this.jobId,
    required this.isManager,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Úkoly',
                    style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                if (isManager)
                  TextButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Přidat'),
                    onPressed: () {}, // TODO
                  ),
              ],
            ),
            const Divider(),
            tasksAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Chyba: $e'),
              data: (tasks) => tasks.isEmpty
                  ? const Text('Žádné úkoly')
                  : Column(
                      children: tasks
                          .map((t) => CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  t['title'] as String,
                                  style: t['is_completed'] == true
                                      ? const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough)
                                      : null,
                                ),
                                value: t['is_completed'] as bool,
                                onChanged: (val) async {
                                  await Supabase.instance.client
                                      .from('tasks')
                                      .update({
                                        'is_completed': val,
                                        'completed_by': val == true
                                            ? Supabase.instance.client.auth
                                                .currentUser?.id
                                            : null,
                                        'completed_at': val == true
                                            ? DateTime.now()
                                                .toIso8601String()
                                            : null,
                                      })
                                      .eq('id', t['id'] as String);
                                  ref.invalidate(jobTasksProvider(jobId));
                                },
                              ))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
