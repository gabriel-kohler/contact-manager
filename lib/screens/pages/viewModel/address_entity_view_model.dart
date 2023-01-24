class AddressViewModel {
  final String streetName;
  final int? streetNumber;
  final int zipCode;
  final String city;
  final String state;
  final String? complement;
  final String district;

  AddressViewModel({
    required this.streetName,
    required this.zipCode,
    required this.state,
    required this.city,
    required this.district,
    this.streetNumber,
    this.complement,
  });
}