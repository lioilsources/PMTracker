import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import '../../shared/widgets/error_view.dart';

part 'reports_screen.g.dart';

// Parametr se nesmí jmenovat "from" — koliduje s polem
// generovaného Riverpod provideru (ProviderBase.from).
@riverpod
Future<List<Map<String, dynamic>>> utilizationReport(
  UtilizationReportRef ref,
  DateTime fromDate,
  DateTime toDate,
) async {
  final result = await Supabase.instance.client.rpc(
    'get_member_utilization',
    params: {
      'p_from': DateFormat('yyyy-MM-dd').format(fromDate),
      'p_to': DateFormat('yyyy-MM-dd').format(toDate),
    },
  );
  return (result as List).cast<Map<String, dynamic>>();
}

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  DateTime _from = DateTime.now().subtract(const Duration(days: 30));
  DateTime _to = DateTime.now();

  Future<void> _pickDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _from, end: _to),
    );
    if (range != null) {
      setState(() {
        _from = range.start;
        _to = range.end;
      });
      ref.invalidate(utilizationReportProvider);
    }
  }

  String _formatHours(int? secs) {
    if (secs == null) return '0:00';
    final h = secs ~/ 3600;
    final m = (secs % 3600) ~/ 60;
    return '$h h ${m.toString().padLeft(2, '0')} min';
  }

  @override
  Widget build(BuildContext context) {
    final reportAsync = ref.watch(utilizationReportProvider(_from, _to));
    final fmt = DateFormat('d. M. yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporty'),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _pickDateRange,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text('${fmt.format(_from)} — ${fmt.format(_to)}'),
                const Spacer(),
                TextButton(
                    onPressed: _pickDateRange,
                    child: const Text('Změnit')),
              ],
            ),
          ),
          Expanded(
            child: reportAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorView(
                  error: e.toString(),
                  onRetry: () =>
                      ref.invalidate(utilizationReportProvider)),
              data: (rows) {
                if (rows.isEmpty) {
                  return const Center(
                      child:
                          Text('Žádná data pro vybrané období'));
                }

                // Group by member
                final Map<String, List<Map<String, dynamic>>> byMember =
                    {};
                for (final row in rows) {
                  final name = row['full_name'] as String;
                  byMember.putIfAbsent(name, () => []).add(row);
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: byMember.length,
                  itemBuilder: (_, i) {
                    final name = byMember.keys.elementAt(i);
                    final entries = byMember[name]!;
                    final totalSecs = entries.fold<int>(
                        0,
                        (sum, e) =>
                            sum + ((e['total_seconds'] as int?) ?? 0));
                    final cs = Theme.of(context).colorScheme;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: cs.primaryContainer,
                          child: Text(name[0].toUpperCase(),
                              style: TextStyle(
                                  color: cs.onPrimaryContainer)),
                        ),
                        title: Text(name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600)),
                        subtitle:
                            Text('Celkem: ${_formatHours(totalSecs)}'),
                        children: entries
                            .map((e) => ListTile(
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 16),
                                  title: Text(e['job_name'] as String),
                                  trailing: Text(
                                    _formatHours(
                                        e['total_seconds'] as int?),
                                    style: const TextStyle(
                                        fontFamily: 'monospace'),
                                  ),
                                  subtitle: Text(
                                      '${e['entry_count']} záznamů'),
                                ))
                            .toList(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
