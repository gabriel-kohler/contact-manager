class AddressEntity {
  final String streetName;
  final int? streetNumber;
  final int zipCode;
  final String city;
  final String state;
  final String? complement;
  final String district;

  AddressEntity({
    required this.streetName,
    required this.zipCode,
    required this.state,
    required this.city,
    required this.district,
    this.streetNumber,
    this.complement,
  });

  Map toJson() => {
    'streetName': streetName,
    'zipCode': zipCode,
    'state': state,
    'city': city,
    'district': district,
    'streetNumber': streetNumber,
    'complement': complement,
  };

  factory AddressEntity.fromJson(Map json) {
    return AddressEntity(
      streetName: json['streetName'],
      zipCode: json['zipCode'],
      state: json['state'],
      city: json['city'],
      district: json['district'],
      streetNumber: json['streetNumber'],
      complement: json['complement'],
    );
  }
}
