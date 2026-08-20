import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtracker/features/auth/auth_provider.dart';
import 'package:pmtracker/features/tracking/tracking_repository.dart';
import 'package:pmtracker/core/location_service.dart';
import 'package:pmtracker/features/tracking/tracking_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../support/fakes.dart';

void main() {
  late FakeTrackingRepository repo;
  late FakeLocationService location;

  setUp(() {
    repo = FakeTrackingRepository(jobs: [
      {
        'id': 'job-1',
        'name': 'Rekonstrukce kanceláří Praha',
        'status': 'active',
        'address': 'Václavské náměstí 1, Praha 1',
        'geofence_radius_m': 200,
      },
    ]);
    location = FakeLocationService();
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          trackingRepositoryProvider.overrideWithValue(repo),
          locationServiceProvider.overrideWithValue(location),
          currentProfileProvider.overrideWith(
            (ref) async => {'full_name': 'Petr Svoboda', 'role': 'member'},
          ),
        ],
        child: const MaterialApp(home: TrackingScreen()),
      ),
    );
    // Bez pumpAndSettle — obrazovka drží sekundový ticker, který nikdy
    // "nedoběhne".
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('bez běžícího výkazu nabízí Zahájit', (tester) async {
    await pumpScreen(tester);

    expect(find.text('Připraven'), findsOneWidget);
    expect(find.text('Zahájit výkaz'), findsOneWidget);
    expect(find.text('Ukončit výkaz'), findsNothing);
  });

  testWidgets('běžící výkaz ukazuje název zakázky a stav Na místě',
      (tester) async {
    repo.entry = {
      'id': 'entry-1',
      'job_id': 'job-1',
      'job_name': 'Rekonstrukce kanceláří Praha',
      'started_at':
          DateTime.now().subtract(const Duration(minutes: 5)).toIso8601String(),
      'within_geofence': true,
    };

    await pumpScreen(tester);

    expect(find.text('Rekonstrukce kanceláří Praha'), findsOneWidget);
    expect(find.text('Na místě'), findsOneWidget);
    expect(find.text('Ukončit výkaz'), findsOneWidget);
  });

  testWidgets('výkaz mimo geofence je označen jako Override', (tester) async {
    repo.entry = {
      'id': 'entry-1',
      'job_id': 'job-1',
      'job_name': 'Rekonstrukce kanceláří Praha',
      'started_at': DateTime.now().toIso8601String(),
      'within_geofence': false,
    };

    await pumpScreen(tester);

    expect(find.text('Override'), findsOneWidget);
    expect(find.text('Na místě'), findsNothing);
  });

  testWidgets('výběr zakázky spustí tracking se souřadnicemi', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Zahájit výkaz'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Vyberte zakázku'), findsOneWidget);

    await tester.tap(find.text('Václavské náměstí 1, Praha 1'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(repo.startCalls.single['jobId'], 'job-1');
    expect(repo.startCalls.single['latitude'], 50.0827);
    expect(find.text('Ukončit výkaz'), findsOneWidget);
  });

  testWidgets('bez přiřazené zakázky se zobrazí hláška místo prázdného výběru',
      (tester) async {
    repo.jobs = [];
    await pumpScreen(tester);

    await tester.tap(find.text('Zahájit výkaz'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
        find.text('Nejste přiřazeni k žádné aktivní zakázce'), findsOneWidget);
    expect(repo.startCalls, isEmpty);
  });

  testWidgets('odmítnutí mimo geofence otevře dialog a start s důvodem projde',
      (tester) async {
    repo.startError = PostgrestException(
        message: 'Outside geofence: provide override_reason');

    await pumpScreen(tester);

    await tester.tap(find.text('Zahájit výkaz'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Václavské náměstí 1, Praha 1'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Mimo geofence'), findsOneWidget);

    // Server tentokrát start přijme (uživatel doplnil důvod).
    repo.startError = null;
    await tester.enterText(
        find.byType(TextField), 'Vyzvedávám materiál ve skladu');
    await tester.pump();
    await tester.tap(find.text('Zahájit s override'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(repo.startCalls, hasLength(2));
    expect(repo.startCalls.last['overrideReason'],
        'Vyzvedávám materiál ve skladu');
    expect(find.text('Override'), findsOneWidget);
  });

  testWidgets('chyba polohy se ukáže uživateli a nic se nezaloží',
      (tester) async {
    location.error = const LocationException('Lokalizační služby jsou vypnuté');

    await pumpScreen(tester);

    await tester.tap(find.text('Zahájit výkaz'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Václavské náměstí 1, Praha 1'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Lokalizační služby jsou vypnuté'), findsOneWidget);
    expect(repo.startCalls, isEmpty);
  });

  testWidgets('ukončení výkazu pošle id záznamu', (tester) async {
    repo.entry = {
      'id': 'entry-7',
      'job_id': 'job-1',
      'job_name': 'Rekonstrukce kanceláří Praha',
      'started_at': DateTime.now().toIso8601String(),
      'within_geofence': true,
    };

    await pumpScreen(tester);

    await tester.tap(find.text('Ukončit výkaz'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(repo.stopCalls.single['entryId'], 'entry-7');
    expect(find.text('Připraven'), findsOneWidget);
  });
}
