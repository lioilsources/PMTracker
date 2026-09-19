import 'package:flutter_test/flutter_test.dart';
import 'package:pmtracker/core/duration_format.dart';

void main() {
  group('formatHms', () {
    test('formátuje nulu', () {
      expect(formatHms(0), '00:00:00');
    });

    test('doplňuje nuly zleva', () {
      expect(formatHms(5), '00:00:05');
      expect(formatHms(65), '00:01:05');
      expect(formatHms(3665), '01:01:05');
    });

    test('hodiny nepřetékají do dnů — dlouhá směna zůstane čitelná', () {
      expect(formatHms(30 * 3600), '30:00:00');
    });

    test('záporný vstup (rozjeté hodiny na telefonu) nespadne', () {
      expect(formatHms(-10), '00:00:00');
    });
  });

  group('formatHoursMinutes', () {
    test('null je nula', () {
      expect(formatHoursMinutes(null), '0 h 00 min');
    });

    test('zaokrouhluje dolů na minuty', () {
      expect(formatHoursMinutes(3599), '0 h 59 min');
      expect(formatHoursMinutes(3600), '1 h 00 min');
      expect(formatHoursMinutes(7 * 3600 + 5 * 60 + 59), '7 h 05 min');
    });
  });
}
