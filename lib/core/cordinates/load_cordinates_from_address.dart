
import '../../domain/domain.dart';
import '../core.dart';

class LoadCordinatesFromAddress implements LoadCordinates {

  final Cordinator cordinator;

  LoadCordinatesFromAddress({required this.cordinator});

  @override
  Future<LocationEntity> fetchLocationFromAddress(String address) async {
    try {
      final cordinates = await cordinator.getCordinate(address);
      return LocationEntity.fromJson(cordinates);
    } catch (error) {
      rethrow;
    }
  }

}