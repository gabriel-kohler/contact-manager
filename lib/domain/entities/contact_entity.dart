import 'entities.dart';

class ContactEntity {

  final String contactId;
  final String userAssociateId;
  final String name;
  final String photoUrl;
  final int phoneNumber;
  final int cpf;
  final String lat;
  final String lng;
  final AddressEntity address;
  final String date;

  ContactEntity({
    required this.contactId,
    required this.userAssociateId,
    required this.name,
    required this.photoUrl,
    required this.phoneNumber,
    required this.cpf,
    required this.lat,
    required this.lng,
    required this.address,
    required this.date
  });

  Map toJson() => {
    'contactId': contactId,
    'userAssociateId': userAssociateId,
    'name': name,
    'photoUrl': photoUrl,
    'phoneNumber': phoneNumber,
    'cpf': cpf,
    'lat': lat,
    'lng': lng,
    'date': date,
    'address': {
      'streetName': address.streetName,
      'streetNumber': address.streetNumber,
      'zipCode': address.zipCode,
      'district': address.district,
      'state': address.state,
      'city': address.city,
    }
  };

  factory ContactEntity.fromJson(Map json) {
    // if (!json.keys.toSet().containsAll(['id', 'name'])) {
    //   throw Exception();
    // }
    return ContactEntity(
      contactId: json['contactId'],
      userAssociateId: json['userAssociateId'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      phoneNumber: json['phoneNumber'],
      cpf: json['cpf'],
      lat: json['lat'],
      lng: json['lng'],
      date: json['date'],
      address: AddressEntity.fromJson(json['address']),
    );
  }

  ContactEntity toContactEntity() => ContactEntity(
    contactId: contactId,
    userAssociateId: userAssociateId,
    name: name,
    phoneNumber: phoneNumber,
    cpf: cpf,
    lat: lat,
    lng: lng,
    date: date,
    address: address,
    photoUrl: photoUrl,
  );


}
