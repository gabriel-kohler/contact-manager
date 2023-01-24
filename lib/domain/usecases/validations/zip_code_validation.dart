import '../../domain.dart';

abstract class ZipCode {
  Future<AddressEntity> checkZipCode(String zipCode);
}