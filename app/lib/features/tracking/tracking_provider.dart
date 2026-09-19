import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/location_service.dart';
import 'tracking_repository.dart';

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
    final row = await ref.watch(trackingRepositoryProvider).activeEntry();
    if (row == null) return null;
    return ActiveEntry.fromMap(row);
  }

  Future<void> startTracking(String jobId, {String? overrideReason}) async {
    final position = await ref.read(locationServiceProvider).currentPosition();
    await ref.read(trackingRepositoryProvider).startTracking(
          jobId: jobId,
          latitude: position.latitude,
          longitude: position.longitude,
          overrideReason: overrideReason,
        );
    ref.invalidateSelf();
    ref.invalidate(todaySecondsProvider);
    await future;
  }

  Future<void> stopTracking() async {
    final entry = await future;
    if (entry == null) return;
    final position = await ref.read(locationServiceProvider).currentPosition();
    await ref.read(trackingRepositoryProvider).stopTracking(
          entryId: entry.id,
          latitude: position.latitude,
          longitude: position.longitude,
        );
    ref.invalidateSelf();
    ref.invalidate(todaySecondsProvider);
    await future;
  }
}

@riverpod
Future<int> todaySeconds(Ref ref) =>
    ref.watch(trackingRepositoryProvider).todaySeconds();

@riverpod
Future<List<Map<String, dynamic>>> myAssignedJobs(Ref ref) =>
    ref.watch(trackingRepositoryProvider).assignedJobs();
