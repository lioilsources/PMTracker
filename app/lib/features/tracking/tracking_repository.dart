import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/supabase_client.dart';

part 'tracking_repository.g.dart';

/// Jediné místo, kudy tracking mluví se Supabase.
/// Díky tomu jde v testech podstrčit fake a testovat logiku bez sítě.
abstract class TrackingRepository {
  Future<Map<String, dynamic>?> activeEntry();

  /// Vrací id založeného záznamu. Server rozhoduje o `within_geofence`.
  Future<String> startTracking({
    required String jobId,
    required double latitude,
    required double longitude,
    String? overrideReason,
  });

  Future<void> stopTracking({
    required String entryId,
    required double latitude,
    required double longitude,
  });

  Future<int> todaySeconds();

  Future<List<Map<String, dynamic>>> assignedJobs();
}

class SupabaseTrackingRepository implements TrackingRepository {
  final SupabaseClient _client;

  SupabaseTrackingRepository(this._client);

  @override
  Future<Map<String, dynamic>?> activeEntry() async {
    final rows = await _client.rpc('get_active_entry');
    if (rows == null || (rows as List).isEmpty) return null;
    return rows.first as Map<String, dynamic>;
  }

  @override
  Future<String> startTracking({
    required String jobId,
    required double latitude,
    required double longitude,
    String? overrideReason,
  }) async {
    final id = await _client.rpc('start_tracking', params: {
      'p_job_id': jobId,
      'p_lat': latitude,
      'p_lon': longitude,
      if (overrideReason != null) 'p_override_reason': overrideReason,
    });
    return id as String;
  }

  @override
  Future<void> stopTracking({
    required String entryId,
    required double latitude,
    required double longitude,
  }) async {
    await _client.rpc('stop_tracking', params: {
      'p_entry_id': entryId,
      'p_lat': latitude,
      'p_lon': longitude,
    });
  }

  @override
  Future<int> todaySeconds() async {
    final result = await _client.rpc('get_today_seconds');
    return (result as int?) ?? 0;
  }

  @override
  Future<List<Map<String, dynamic>>> assignedJobs() async {
    final result = await _client
        .from('job_assignments')
        .select('job_id, jobs(id, name, status, address, geofence_radius_m)')
        .eq('jobs.status', 'active');
    return (result as List)
        .map((e) => e['jobs'] as Map<String, dynamic>?)
        .whereType<Map<String, dynamic>>()
        .where((e) => e.isNotEmpty)
        .toList();
  }
}

@riverpod
TrackingRepository trackingRepository(Ref ref) =>
    SupabaseTrackingRepository(ref.watch(supabaseProvider));
