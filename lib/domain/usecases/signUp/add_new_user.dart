import '../../domain.dart';

abstract class AddNewUser {
  Future<UserEntity> addUser(AddNewUserParams params);
}

class AddNewUserParams {
  final String email;
  final String password;

  AddNewUserParams({
    required this.email,
    required this.password,
  });
}
