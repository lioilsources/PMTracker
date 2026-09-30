import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
