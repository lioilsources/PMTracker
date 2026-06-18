import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';

part 'tracking_provider.g.dart';

class ActiveEntry {
  final String id;
  final String jobId;
  final String jobName;
  final DateTime startedAt;
  final bool? withinGeofence;

  ActiveEntry({
    required this.id,
    required this.jobId,
    required this.jobName,
    required this.startedAt,
    this.withinGeofence,
  });

  factory ActiveEntry.fromMap(Map<String, dynamic> m) => ActiveEntry(
        id: m['id'] as String,
        jobId: m['job_id'] as String,
        jobName: m['job_name'] as String,
        startedAt: DateTime.parse(m['started_at'] as String),
        withinGeofence: m['within_geofence'] as bool?,
      );
}

@riverpod
class TrackingNotifier extends _$TrackingNotifier {
  @override
  Future<ActiveEntry?> build() async {
    final rows = await Supabase.instance.client.rpc('get_active_entry');
    if (rows == null || (rows as List).isEmpty) return null;
    return ActiveEntry.fromMap(rows.first as Map<String, dynamic>);
  }

  Future<void> startTracking(String jobId, {String? overrideReason}) async {
    final pos = await _getPosition();
    await Supabase.instance.client.rpc('start_tracking', params: {
      'p_job_id': jobId,
      'p_lat': pos.latitude,
      'p_lon': pos.longitude,
      if (overrideReason != null) 'p_override_reason': overrideReason,
    });
    ref.invalidateSelf();
  }

  Future<void> stopTracking() async {
    final entry = await future;
    if (entry == null) return;
    final pos = await _getPosition();
    await Supabase.instance.client.rpc('stop_tracking', params: {
      'p_entry_id': entry.id,
      'p_lat': pos.latitude,
      'p_lon': pos.longitude,
    });
    ref.invalidateSelf();
    ref.invalidate(todaySecondsProvider);
  }

  Future<Position> _getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Lokalizační služby jsou vypnuté');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Přístup k poloze odmítnut');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Přístup k poloze trvale odmítnut — povolte v nastavení');
    }

    return Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best));
  }
}

@riverpod
Future<int> todaySeconds(TodaySecondsRef ref) async {
  final result = await Supabase.instance.client.rpc('get_today_seconds');
  return (result as int?) ?? 0;
}

@riverpod
Future<List<Map<String, dynamic>>> myAssignedJobs(
    MyAssignedJobsRef ref) async {
  final result = await Supabase.instance.client
      .from('job_assignments')
      .select('job_id, jobs(id, name, status, address, geofence_radius_m)')
      .eq('jobs.status', 'active');
  return (result as List)
      .map((e) => e['jobs'] as Map<String, dynamic>)
      .where((e) => e.isNotEmpty)
      .toList();
}
