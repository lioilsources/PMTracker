import 'package:pmtracker/core/location_service.dart';
import 'package:pmtracker/features/tracking/tracking_repository.dart';

/// Zaznamenává volání a vrací připravené odpovědi — žádná síť, žádné GPS.
class FakeTrackingRepository implements TrackingRepository {
  FakeTrackingRepository({
    this.entry,
    this.today = 0,
    this.jobs = const [],
    this.startError,
    this.stopError,
  });

  Map<String, dynamic>? entry;
  int today;
  List<Map<String, dynamic>> jobs;

  /// Výjimka, kterou má start/stop vyhodit místo úspěchu (simulace serveru).
  Object? startError;
  Object? stopError;

  final List<Map<String, Object?>> startCalls = [];
  final List<Map<String, Object?>> stopCalls = [];
  int activeEntryCalls = 0;

  /// Záznam, který se objeví po úspěšném startu.
  Map<String, dynamic>? entryAfterStart;

  @override
  Future<Map<String, dynamic>?> activeEntry() async {
    activeEntryCalls++;
    return entry;
  }

  @override
  Future<String> startTracking({
    required String jobId,
    required double latitude,
    required double longitude,
    String? overrideReason,
  }) async {
    startCalls.add({
      'jobId': jobId,
      'latitude': latitude,
      'longitude': longitude,
      'overrideReason': overrideReason,
    });
    if (startError != null) throw startError!;
    entry = entryAfterStart ??
        {
          'id': 'entry-1',
          'job_id': jobId,
          'job_name': 'Rekonstrukce kanceláří Praha',
          'started_at': DateTime.now().toIso8601String(),
          'within_geofence': overrideReason == null,
        };
    return entry!['id'] as String;
  }

  @override
  Future<void> stopTracking({
    required String entryId,
    required double latitude,
    required double longitude,
  }) async {
    stopCalls.add({
      'entryId': entryId,
      'latitude': latitude,
      'longitude': longitude,
    });
    if (stopError != null) throw stopError!;
    entry = null;
  }

  @override
  Future<int> todaySeconds() async => today;

  @override
  Future<List<Map<String, dynamic>>> assignedJobs() async => jobs;
}

class FakeLocationService implements LocationService {
  FakeLocationService({
    this.coordinates = const Coordinates(latitude: 50.0827, longitude: 14.4244),
    this.error,
  });

  Coordinates coordinates;
  Object? error;
  int calls = 0;

  @override
  Future<Coordinates> currentPosition() async {
    calls++;
    if (error != null) throw error!;
    return coordinates;
  }
}
