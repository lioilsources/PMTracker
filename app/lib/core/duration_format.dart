// Formátování časů výkazů. Čisté funkce — snadno testovatelné.

/// `HH:MM:SS` pro běžící stopky. Hodiny nepřetékají do dnů,
/// 30h směna se zobrazí jako `30:00:00`.
String formatHms(int totalSeconds) {
  final seconds = totalSeconds < 0 ? 0 : totalSeconds;
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  final s = seconds % 60;
  return '${h.toString().padLeft(2, '0')}:'
      '${m.toString().padLeft(2, '0')}:'
      '${s.toString().padLeft(2, '0')}';
}

/// `4 h 05 min` pro reporty a součty.
String formatHoursMinutes(int? totalSeconds) {
  final seconds = (totalSeconds ?? 0) < 0 ? 0 : (totalSeconds ?? 0);
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  return '$h h ${m.toString().padLeft(2, '0')} min';
}
