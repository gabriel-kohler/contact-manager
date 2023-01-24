class UserEntity {

  UserEntity({required this.id, required this.email});

  final String id;
  final String email;

  Map toJson() => {
    'id': id,
    'email': email,
  };

  factory UserEntity.fromJson(Map json) {
    // if (!json.keys.toSet().containsAll(['id', 'email'])) {
    //   throw Exception();
    // }
    return UserEntity(
      id: json['id'],
      email: json['email'],
    );
  }

}