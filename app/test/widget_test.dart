import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmtracker/features/tracking/tracking_provider.dart';
import 'package:pmtracker/shared/widgets/error_view.dart';

void main() {
  testWidgets('ErrorView shows the error and retries on tap', (tester) async {
    var retries = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ErrorView(error: 'Spojení selhalo', onRetry: () => retries++),
      ),
    ));

    expect(find.text('Spojení selhalo'), findsOneWidget);

    await tester.tap(find.text('Zkusit znovu'));
    expect(retries, 1);
  });

  group('ActiveEntry.fromMap', () {
    test('načte řádek z get_active_entry', () {
      final entry = ActiveEntry.fromMap({
        'id': '11111111-1111-1111-1111-111111111111',
        'job_id': '00000000-0000-0000-0000-0000000000a1',
        'job_name': 'Rekonstrukce kanceláří Praha',
        'started_at': '2026-09-08T07:30:00Z',
        'within_geofence': true,
      });

      expect(entry.id, '11111111-1111-1111-1111-111111111111');
      expect(entry.jobId, '00000000-0000-0000-0000-0000000000a1');
      expect(entry.jobName, 'Rekonstrukce kanceláří Praha');
      expect(entry.startedAt, DateTime.parse('2026-09-08T07:30:00Z'));
      expect(entry.withinGeofence, isTrue);
    });

    test('within_geofence smí být null, dokud server neověří polohu', () {
      final entry = ActiveEntry.fromMap({
        'id': '22222222-2222-2222-2222-222222222222',
        'job_id': '00000000-0000-0000-0000-0000000000b1',
        'job_name': 'Instalace klimatizace Brno',
        'started_at': '2026-09-08T09:00:00Z',
        'within_geofence': null,
      });

      expect(entry.withinGeofence, isNull);
    });
  });
}
