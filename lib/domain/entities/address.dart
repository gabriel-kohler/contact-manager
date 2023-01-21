class Address {
  final String streetName;
  final int? streetNumber;
  final int zipCode;
  final String city;
  final String state;
  final String? complement;

  Address({
    required this.streetName,
    required this.zipCode,
    required this.state,
    required this.city,
    this.streetNumber,
    this.complement,
  });
}
