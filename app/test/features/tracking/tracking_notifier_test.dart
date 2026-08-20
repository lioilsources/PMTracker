import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtracker/core/location_service.dart';
import 'package:pmtracker/features/tracking/tracking_provider.dart';
import 'package:pmtracker/features/tracking/tracking_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../support/fakes.dart';

void main() {
  late FakeTrackingRepository repo;
  late FakeLocationService location;

  ProviderContainer makeContainer() {
    final container = ProviderContainer(overrides: [
      trackingRepositoryProvider.overrideWithValue(repo),
      locationServiceProvider.overrideWithValue(location),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    repo = FakeTrackingRepository();
    location = FakeLocationService();
  });

  test('bez běžícího výkazu je stav null', () async {
    final container = makeContainer();
    expect(await container.read(trackingNotifierProvider.future), isNull);
  });

  test('běžící výkaz se namapuje včetně serverového geofence flagu', () async {
    repo.entry = {
      'id': 'entry-1',
      'job_id': 'job-1',
      'job_name': 'Rekonstrukce kanceláří Praha',
      'started_at': '2026-08-20T08:00:00.000Z',
      'within_geofence': true,
    };

    final container = makeContainer();
    final entry = await container.read(trackingNotifierProvider.future);

    expect(entry, isNotNull);
    expect(entry!.id, 'entry-1');
    expect(entry.jobName, 'Rekonstrukce kanceláří Praha');
    expect(entry.withinGeofence, isTrue);
    expect(entry.startedAt, DateTime.parse('2026-08-20T08:00:00.000Z'));
  });

  test('start odešle aktuální souřadnice a id zakázky', () async {
    location.coordinates =
        const Coordinates(latitude: 49.1951, longitude: 16.6071);

    final container = makeContainer();
    await container.read(trackingNotifierProvider.future);
    await container
        .read(trackingNotifierProvider.notifier)
        .startTracking('job-42');

    expect(repo.startCalls, hasLength(1));
    expect(repo.startCalls.single['jobId'], 'job-42');
    expect(repo.startCalls.single['latitude'], 49.1951);
    expect(repo.startCalls.single['longitude'], 16.6071);
    expect(repo.startCalls.single['overrideReason'], isNull);
  });

  test('po startu se stav obnoví ze serveru', () async {
    final container = makeContainer();
    await container.read(trackingNotifierProvider.future);
    await container
        .read(trackingNotifierProvider.notifier)
        .startTracking('job-1');

    final entry = await container.read(trackingNotifierProvider.future);
    expect(entry, isNotNull);
    expect(entry!.withinGeofence, isTrue);
  });

  test('override důvod se předá serveru a záznam je mimo geofence', () async {
    final container = makeContainer();
    await container.read(trackingNotifierProvider.future);
    await container
        .read(trackingNotifierProvider.notifier)
        .startTracking('job-1', overrideReason: 'Vyzvedávám materiál');

    expect(repo.startCalls.single['overrideReason'], 'Vyzvedávám materiál');
    final entry = await container.read(trackingNotifierProvider.future);
    expect(entry!.withinGeofence, isFalse);
  });

  test('odmítnutí serverem (mimo geofence) probublá k volajícímu', () async {
    repo.startError = PostgrestException(
        message: 'Outside geofence: provide override_reason');

    final container = makeContainer();
    await container.read(trackingNotifierProvider.future);

    await expectLater(
      container.read(trackingNotifierProvider.notifier).startTracking('job-1'),
      throwsA(isA<PostgrestException>()),
    );
  });

  test('bez polohy se tracking vůbec nezaloží', () async {
    location.error = const LocationException('Přístup k poloze odmítnut');

    final container = makeContainer();
    await container.read(trackingNotifierProvider.future);

    await expectLater(
      container.read(trackingNotifierProvider.notifier).startTracking('job-1'),
      throwsA(isA<LocationException>()),
    );
    expect(repo.startCalls, isEmpty,
        reason: 'bez souřadnic nesmí odejít žádné RPC volání');
  });

  test('stop bez běžícího výkazu je no-op', () async {
    final container = makeContainer();
    await container.read(trackingNotifierProvider.future);
    await container.read(trackingNotifierProvider.notifier).stopTracking();

    expect(repo.stopCalls, isEmpty);
    expect(location.calls, 0);
  });

  test('stop pošle id běžícího záznamu a stav se vyprázdní', () async {
    repo.entry = {
      'id': 'entry-9',
      'job_id': 'job-1',
      'job_name': 'Instalace klimatizace Brno',
      'started_at': '2026-08-20T08:00:00.000Z',
      'within_geofence': true,
    };

    final container = makeContainer();
    await container.read(trackingNotifierProvider.future);
    await container.read(trackingNotifierProvider.notifier).stopTracking();

    expect(repo.stopCalls.single['entryId'], 'entry-9');
    expect(await container.read(trackingNotifierProvider.future), isNull);
  });

  test('dnešní součet se po ukončení výkazu načte znovu', () async {
    repo.entry = {
      'id': 'entry-9',
      'job_id': 'job-1',
      'job_name': 'Instalace klimatizace Brno',
      'started_at': '2026-08-20T08:00:00.000Z',
      'within_geofence': true,
    };
    repo.today = 3600;

    final container = makeContainer();
    expect(await container.read(todaySecondsProvider.future), 3600);

    repo.today = 7200;
    await container.read(trackingNotifierProvider.notifier).stopTracking();

    expect(await container.read(todaySecondsProvider.future), 7200);
  });

  test('zakázky bez navázaného jobu (odfiltrované jointem) se přeskočí',
      () async {
    repo.jobs = [
      {'id': 'job-1', 'name': 'Praha', 'status': 'active'},
    ];

    final container = makeContainer();
    expect(await container.read(myAssignedJobsProvider.future), hasLength(1));
  });
}
