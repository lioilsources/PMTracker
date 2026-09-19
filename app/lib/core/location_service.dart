import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

/// Souřadnice putují jen do RPC volání — do databáze se neukládají.
class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates({required this.latitude, required this.longitude});
}

/// Vrstva nad `geolocator`, aby šlo polohu v testech podstrčit.
abstract class LocationService {
  Future<Coordinates> currentPosition();
}

class GeolocatorLocationService implements LocationService {
  const GeolocatorLocationService();

  @override
  Future<Coordinates> currentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException('Lokalizační služby jsou vypnuté');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationException('Přístup k poloze odmítnut');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(
          'Přístup k poloze trvale odmítnut — povolte v nastavení');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    );
    return Coordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}

class LocationException implements Exception {
  final String message;
  const LocationException(this.message);

  @override
  String toString() => message;
}

@riverpod
LocationService locationService(Ref ref) => const GeolocatorLocationService();
