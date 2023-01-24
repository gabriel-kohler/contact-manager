import 'package:project_test/core/cordinates/cordinates.dart';
import 'package:project_test/domain/domain.dart';

class RequestUserLocation implements CheckLocationPermission {

  final Cordinator cordinator;

  RequestUserLocation({required this.cordinator});

  @override
  Future<void> checkPermission() async {
    try {
      await cordinator.requestLocationPermission();
    } catch (error) {
      print('error > $error');
    }
  }

}