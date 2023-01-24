abstract class Cordinator {
  Future<Map<String, String>> getCordinate(String address);
  Future<bool> requestLocationPermission();
  Future<Map<String, String>> getCurrentLocation();


}