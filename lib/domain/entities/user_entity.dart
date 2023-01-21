import 'entities.dart';

class UserEntity {
  //TODO criar UNIQUE ID quando armazenar no banco

  final String name;
  final String photoUrl;
  final int phoneNumber;
  final int cpf;
  final int lat;
  final int lng;
  final Address address;
  final String token;

  UserEntity({
    required this.name,
    required this.photoUrl,
    required this.phoneNumber,
    required this.cpf,
    required this.lat,
    required this.lng,
    required this.address,
    required this.token,
  });

}
