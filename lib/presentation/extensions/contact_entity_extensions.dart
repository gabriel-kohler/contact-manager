import 'package:project_test/domain/domain.dart';

import '../../screens/pages/pages.dart';

extension ContactEntityExtensions on ContactEntity {
  ContactViewModel toViewModel() => ContactViewModel(
        contactId: contactId,
        userAssociateId: userAssociateId,
        name: name,
        phoneNumber: phoneNumber,
        cpf: cpf,
        lat: lat,
        lng: lng,
        date: date,
        photoUrl: photoUrl,
        address: address.toViewModel(),
      );
}

extension AddressEntityExtensions on AddressEntity {
  AddressViewModel toViewModel() => AddressViewModel(
        streetName: streetName,
        streetNumber: streetNumber,
        district: district,
        state: state,
        city: city,
        zipCode: zipCode,
        complement: complement,
      );
}

extension ContactViewModelExtensions on ContactViewModel {
  ContactEntity toEntity() => ContactEntity(
    contactId: contactId,
    userAssociateId: userAssociateId,
    name: name,
    photoUrl: photoUrl,
    phoneNumber: phoneNumber,
    cpf: cpf,
    lat: lat,
    lng: lng,
    date: date,
    address: address.toEntity(),
  );
}

extension AddressViewModelExtensions on AddressViewModel {
  AddressEntity toEntity() => AddressEntity(
    streetName: streetName,
    zipCode: zipCode,
    state: state,
    city: city,
    district: district,
  );
}
