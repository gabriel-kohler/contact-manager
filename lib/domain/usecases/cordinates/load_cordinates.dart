import '../../domain.dart';

abstract class LoadCordinates {
  Future<LocationEntity> fetchLocationFromAddress(String address);
}