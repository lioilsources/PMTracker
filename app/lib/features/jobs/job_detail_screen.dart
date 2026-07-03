import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../auth/auth_provider.dart';
import '../../shared/widgets/error_view.dart';

part 'job_detail_screen.g.dart';

@riverpod
Future<Map<String, dynamic>> jobDetail(JobDetailRef ref, String jobId) async {
  final result = await Supabase.instance.client
      .from('jobs')
      .select('*, profiles!jobs_manager_id_fkey(full_name)')
      .eq('id', jobId)
      .single();
  return result;
}

@riverpod
Future<List<Map<String, dynamic>>> jobTasks(
    JobTasksRef ref, String jobId) async {
  return await Supabase.instance.client
      .from('tasks')
      .select()
      .eq('job_id', jobId)
      .order('sort_order') as List<Map<String, dynamic>>;
}

@riverpod
Future<List<Map<String, dynamic>>> jobAssignments(
    JobAssignmentsRef ref, String jobId) async {
  return await Supabase.instance.client
      .from('job_assignments')
      .select(
          '*, profiles!job_assignments_member_id_fkey(full_name, role)')
      .eq('job_id', jobId) as List<Map<String, dynamic>>;
}

class JobDetailScreen extends ConsumerWidget {
  final String jobId;
  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobDetailProvider(jobId));
    final tasksAsync = ref.watch(jobTasksProvider(jobId));
    final assignmentsAsync = ref.watch(jobAssignmentsProvider(jobId));
    final profile = ref.watch(currentProfileProvider).valueOrNull;
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
        data: (job) {
          // RLS dovoluje přiřazovat lidi a spravovat úkoly jen
          // vlastníkovi zakázky (owns_job), ne každému managerovi.
          final userId = Supabase.instance.client.auth.currentUser?.id;
          final isOwner = isManager && job['manager_id'] == userId;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _InfoCard(job: job),
              const SizedBox(height: 16),
              _AssignmentsCard(
                assignmentsAsync: assignmentsAsync,
                jobId: jobId,
                isOwner: isOwner,
                ref: ref,
              ),
              const SizedBox(height: 16),
              _TasksCard(
                tasksAsync: tasksAsync,
                jobId: jobId,
                companyId: job['company_id'] as String,
                isOwner: isOwner,
                ref: ref,
              ),
            ],
          );
        },
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
  final bool isOwner;
  final WidgetRef ref;
  const _AssignmentsCard({
    required this.assignmentsAsync,
    required this.jobId,
    required this.isOwner,
    required this.ref,
  });

  Future<void> _showAddMemberSheet(BuildContext context) async {
    final client = Supabase.instance.client;
    final assignedIds = (assignmentsAsync.valueOrNull ?? [])
        .map((a) => a['member_id'] as String)
        .toSet();
    // Profily celé firmy — manager může vzít i člena cizího rosteru
    // (půjčení); RLS omezí select na vlastní firmu.
    final profiles = (await client
            .from('profiles')
            .select('id, full_name, role')
            .order('full_name') as List)
        .cast<Map<String, dynamic>>()
        .where((p) => !assignedIds.contains(p['id']))
        .toList();

    if (!context.mounted) return;
    await showModalBottomSheet(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: profiles.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(24),
                child: Text('Všichni členové firmy už jsou přiřazeni'),
              )
            : ListView(
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Přiřadit člena',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  ...profiles.map((p) => ListTile(
                        leading:
                            const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(p['full_name'] as String),
                        subtitle: Text(p['role'] as String),
                        onTap: () async {
                          try {
                            await client.from('job_assignments').insert({
                              'job_id': jobId,
                              'member_id': p['id'],
                              'assigned_by': client.auth.currentUser?.id,
                            });
                            ref.invalidate(jobAssignmentsProvider(jobId));
                          } on PostgrestException catch (e) {
                            if (sheetContext.mounted) {
                              ScaffoldMessenger.of(sheetContext).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Přiřazení se nezdařilo: ${e.message}')));
                            }
                          }
                          if (sheetContext.mounted) {
                            Navigator.of(sheetContext).pop();
                          }
                        },
                      )),
                ],
              ),
      ),
    );
  }

  Future<void> _removeAssignment(
      BuildContext context, Map<String, dynamic> assignment) async {
    try {
      await Supabase.instance.client
          .from('job_assignments')
          .delete()
          .eq('id', assignment['id'] as String);
      ref.invalidate(jobAssignmentsProvider(jobId));
    } on PostgrestException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Odebrání se nezdařilo: ${e.message}')));
      }
    }
  }

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
                if (isOwner)
                  TextButton.icon(
                    icon: const Icon(Icons.person_add, size: 16),
                    label: const Text('Přidat'),
                    onPressed: () => _showAddMemberSheet(context),
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
                                trailing: isOwner
                                    ? IconButton(
                                        icon: const Icon(
                                            Icons.remove_circle_outline),
                                        tooltip: 'Odebrat ze zakázky',
                                        onPressed: () =>
                                            _removeAssignment(context, a),
                                      )
                                    : null,
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
  final String companyId;
  final bool isOwner;
  final WidgetRef ref;
  const _TasksCard({
    required this.tasksAsync,
    required this.jobId,
    required this.companyId,
    required this.isOwner,
    required this.ref,
  });

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final titleCtrl = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Nový úkol'),
        content: TextField(
          controller: titleCtrl,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Název úkolu'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Zrušit'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(titleCtrl.text.trim()),
            child: const Text('Přidat'),
          ),
        ],
      ),
    );
    if (title == null || title.isEmpty) return;

    final tasks = tasksAsync.valueOrNull ?? [];
    final nextOrder = tasks.isEmpty
        ? 1
        : tasks
                .map((t) => t['sort_order'] as int? ?? 0)
                .reduce((a, b) => a > b ? a : b) +
            1;
    try {
      await Supabase.instance.client.from('tasks').insert({
        'job_id': jobId,
        'company_id': companyId,
        'title': title,
        'sort_order': nextOrder,
      });
      ref.invalidate(jobTasksProvider(jobId));
    } on PostgrestException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Úkol se nepodařilo přidat: ${e.message}')));
      }
    }
  }

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
                if (isOwner)
                  TextButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Přidat'),
                    onPressed: () => _showAddTaskDialog(context),
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
