import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmtracker/core/theme.dart';
import 'package:pmtracker/shared/widgets/error_view.dart';

void main() {
  testWidgets('ErrorView zobrazí chybu a retry tlačítko funguje',
      (WidgetTester tester) async {
    var retried = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: Scaffold(
          body: ErrorView(
            error: 'Testovací chyba',
            onRetry: () => retried = true,
          ),
        ),
      ),
    );

    expect(find.text('Testovací chyba'), findsOneWidget);
    expect(find.text('Zkusit znovu'), findsOneWidget);

    await tester.tap(find.text('Zkusit znovu'));
    await tester.pump();
    expect(retried, isTrue);
  });
}
