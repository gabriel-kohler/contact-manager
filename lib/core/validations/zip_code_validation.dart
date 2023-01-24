import 'package:project_test/core/core.dart';
import 'package:project_test/domain/domain.dart';

class ZipCodeValidation implements ZipCode {
  final HttpClient httpClient;
  final String url;

  ZipCodeValidation({required this.httpClient, required this.url});

  @override
  Future<AddressEntity> checkZipCode(String zipCode) async {
    try {
      final newZipCode = int.parse(zipCode);
      final newUrl = '$url/$newZipCode/json/';
      final response = await httpClient.request(url: newUrl, method: 'get');
      print('response > $response');
      return ZipCodeEntity.fromJson(response).toAddressEntity();
    } catch (error) {
      print('error $error');
      rethrow;
    }
  }
}