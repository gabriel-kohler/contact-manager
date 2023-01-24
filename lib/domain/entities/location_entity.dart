class LocationEntity {
  final String latitude;
  final String longitude;

  LocationEntity({
    required this.latitude,
    required this.longitude,
  });

  Map toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  factory LocationEntity.fromJson(Map json) {
    // if (!json.keys.toSet().containsAll(['id', 'email'])) {
    //   throw Exception();
    // }
    return LocationEntity(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
