import '../../domain/domain.dart';
import '../core.dart';

class FetchCurrentLocation implements FetchLocation {

  final Cordinator cordinator;

  FetchCurrentLocation({required this.cordinator});

  @override
  Future<LocationEntity> fetch() async {
    try {
      final location = await cordinator.getCurrentLocation();
      return LocationEntity.fromJson(location);
    } catch (error) {
      print('error > $error');
      rethrow;
    }
  }

}