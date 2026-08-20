import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/duration_format.dart';
import '../auth/auth_provider.dart';
import 'tracking_provider.dart';
import '../../shared/widgets/error_view.dart';

class TrackingScreen extends ConsumerStatefulWidget {
  const TrackingScreen({super.key});

  @override
  ConsumerState<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends ConsumerState<TrackingScreen> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker =
        Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _showJobPicker() async {
    final jobs = await ref.read(myAssignedJobsProvider.future);
    if (!mounted) return;
    if (jobs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Nejste přiřazeni k žádné aktivní zakázce')),
      );
      return;
    }

    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => _JobPickerSheet(jobs: jobs),
    );
    if (selected == null) return;

    await _startTracking(selected);
  }

  Future<void> _stopTracking() async {
    try {
      await ref.read(trackingNotifierProvider.notifier).stopTracking();
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _startTracking(String jobId, {String? overrideReason}) async {
    try {
      await ref
          .read(trackingNotifierProvider.notifier)
          .startTracking(jobId, overrideReason: overrideReason);
    } on Exception catch (e) {
      if (!mounted) return;
      final msg = e.toString();
      if (msg.contains('Outside geofence')) {
        _showOverrideDialog(jobId);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
      }
    }
  }

  Future<void> _showOverrideDialog(String jobId) async {
    final ctrl = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Mimo geofence'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'Nejste na místě zakázky. Uveďte důvod a manager bude informován.'),
            const SizedBox(height: 16),
            TextField(
              controller: ctrl,
              decoration: const InputDecoration(labelText: 'Důvod override'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Zrušit')),
          FilledButton(
            onPressed: () =>
                ctrl.text.trim().isNotEmpty ? Navigator.pop(ctx, true) : null,
            child: const Text('Zahájit s override'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _startTracking(jobId, overrideReason: ctrl.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final entryAsync = ref.watch(trackingNotifierProvider);
    final todayAsync = ref.watch(todaySecondsProvider);
    final profile = ref.watch(currentProfileProvider).valueOrNull;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Výkaz práce'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
            },
          ),
        ],
      ),
      body: entryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
            error: e.toString(),
            onRetry: () => ref.invalidate(trackingNotifierProvider)),
        data: (entry) {
          final isTracking = entry != null;
          final elapsed = isTracking
              ? DateTime.now().difference(entry.startedAt).inSeconds
              : 0;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  if (profile != null) ...[
                    Text(
                      'Dobrý den, ${(profile['full_name'] as String).split(' ').first}!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Timer circle
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isTracking
                          ? cs.primaryContainer
                          : cs.surfaceContainerHighest,
                      boxShadow: [
                        BoxShadow(
                          color: cs.shadow.withValues(alpha: 0.15),
                          blurRadius: 24,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isTracking) ...[
                            Text(
                              formatHms(elapsed),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    color: cs.onPrimaryContainer,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              entry.jobName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: cs.onPrimaryContainer),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  entry.withinGeofence == true
                                      ? Icons.location_on
                                      : Icons.location_off,
                                  size: 14,
                                  color: entry.withinGeofence == true
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  entry.withinGeofence == true
                                      ? 'Na místě'
                                      : 'Override',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: entry.withinGeofence == true
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                ),
                              ],
                            ),
                          ] else ...[
                            Icon(Icons.timer_outlined,
                                size: 48, color: cs.onSurfaceVariant),
                            const SizedBox(height: 8),
                            Text('Připraven',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Start/Stop button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: isTracking ? _stopTracking : _showJobPicker,
                      icon: Icon(isTracking ? Icons.stop : Icons.play_arrow),
                      label:
                          Text(isTracking ? 'Ukončit výkaz' : 'Zahájit výkaz'),
                      style: FilledButton.styleFrom(
                        backgroundColor: isTracking ? cs.error : cs.primary,
                        foregroundColor: isTracking ? cs.onError : cs.onPrimary,
                        minimumSize: const Size(double.infinity, 56),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Today total
                  todayAsync.when(
                    loading: () => const LinearProgressIndicator(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (secs) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.today),
                            const SizedBox(width: 12),
                            const Text('Dnes celkem'),
                            const Spacer(),
                            Text(
                              formatHms(secs + (isTracking ? elapsed : 0)),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontFamily: 'monospace'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _JobPickerSheet extends StatelessWidget {
  final List<Map<String, dynamic>> jobs;
  const _JobPickerSheet({required this.jobs});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Vyberte zakázku',
                style: Theme.of(context).textTheme.titleMedium),
          ),
          const Divider(height: 1),
          ListView.builder(
            shrinkWrap: true,
            itemCount: jobs.length,
            itemBuilder: (ctx, i) {
              final job = jobs[i];
              return ListTile(
                leading: const Icon(Icons.work_outline),
                title: Text(job['name'] as String),
                subtitle: job['address'] != null
                    ? Text(job['address'] as String)
                    : null,
                onTap: () => Navigator.pop(ctx, job['id'] as String),
              );
            },
          ),
        ],
      ),
    );
  }
}
