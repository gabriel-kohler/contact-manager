import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_test/core/cordinates/cordinates.dart';

class CordinatorAdapter implements Cordinator {
  final GeocodingPlatform geocoding;

  CordinatorAdapter({required this.geocoding});

  @override
  Future<Map<String, String>> getCordinate(String address) async {
    try {
      List<Location> locations =
          await locationFromAddress(address);
      locations.forEach((location) {
        print('latitude > ${location.latitude}');
        print('longitude > ${location.longitude}');
      });
      final cordinates = {
        'latitude': locations.first.latitude.toString(),
        'longitude': locations.first.longitude.toString(),
      };
      return cordinates;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<bool> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Future<Map<String, String>> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final location = {
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
      };
      return location;
    } catch (error) {
      print('error > $error}');
      rethrow;
    }
  }

}
