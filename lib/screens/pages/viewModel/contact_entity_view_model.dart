import '../pages.dart';

class ContactViewModel {
  final String contactId;
  final String userAssociateId;
  final String name;
  final String photoUrl;
  final int phoneNumber;
  final int cpf;
  final String lat;
  final String lng;
  final String date;
  final AddressViewModel address;

  ContactViewModel({
    required this.contactId,
    required this.userAssociateId,
    required this.name,
    required this.photoUrl,
    required this.phoneNumber,
    required this.cpf,
    required this.lat,
    required this.lng,
    required this.date,
    required this.address,
  });
}