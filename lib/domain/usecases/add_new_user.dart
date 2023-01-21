abstract class AddNewUser {
  Future<void> addUser(AddNewUserParams params);
}

class AddNewUserParams {
  final String email;
  final String password;

  AddNewUserParams({
    required this.email,
    required this.password,
  });
}
