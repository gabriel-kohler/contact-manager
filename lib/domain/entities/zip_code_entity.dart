import '../domain.dart';

class ZipCodeEntity {
  final String streetName;
  final String zipCode;
  final String city;
  final String state;
  final String? complement;
  final String district;

  ZipCodeEntity({
    required this.streetName,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.district,
    this.complement,
  });

  Map toJson() => {
    'streetName': streetName,
    'zipCode': zipCode,
    'state': state,
    'city': city,
    'district': district,
    'complement': complement,
  };

  factory ZipCodeEntity.fromJson(Map json) {
    return ZipCodeEntity(
      streetName: json['logradouro'],
      zipCode: json['cep'],
      district: json['bairro'],
      city: json['localidade'],
      state: json['uf'],
      complement: json['complemento'],
    );
  }

  AddressEntity toAddressEntity() => AddressEntity(
    streetName: streetName,
    zipCode: int.parse(zipCode.replaceAll("-", "")),
    state: _getState(state),
    city: city,
    district: district,
  );

  String _getState(String uf) {
    switch (uf) {
      case "AC":
        return "Acre";
      case "AL":
        return "Alagoas";
      case "AM":
        return "Amazonas";
      case "AP":
        return "Amapá";
      case "BA":
        return "Bahia";
      case "CE":
        return "Ceará";
      case "DF":
        return "Distrito Federal";
      case "ES":
        return "Espírito Santo";
      case "GO":
        return "Goiás";
      case "MA":
        return "Maranhão";
      case "MG":
        return "Minas Gerais";
      case "MS":
        return "Mato Grosso do Sul";
      case "MT":
        return "Mato Grosso";
      case "PA":
        return "Pará";
      case "PB":
        return "Paraíba";
      case "PE":
        return "Pernambuco";
      case "PI":
        return "Piauí";
      case "PR":
        return "Paraná";
      case "RJ":
        return "Rio de Janeiro";
      case "RN":
        return "Rio Grande do Norte";
      case "RO":
        return "Rondônia";
      case "RR":
        return "Roraima";
      case "RS":
        return "Rio Grande do Sul";
      case "SC":
        return "Santa Catarina";
      case "SE":
        return "Sergipe";
      case "SP":
        return "São Paulo";
      case "TO":
        return "Tocantíns";
      default:
        return "";
    }
  }
}
