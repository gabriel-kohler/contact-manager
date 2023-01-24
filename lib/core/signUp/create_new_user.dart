import 'dart:convert';

import '../../domain/domain.dart';
import '../core.dart';

class CreateNewUser implements AddNewUser {
  final CacheStorage storage;
  final SignUpCore signUpCore;

  CreateNewUser({
    required this.storage,
    required this.signUpCore,
  });

  @override
  Future<UserEntity> addUser(AddNewUserParams params) async {
    try {
      print('addUser');
      print('email ${params.email}');
      print('password ${params.password}');

      final user = await signUpCore.signUp(
        params.email,
        params.password,
      );

      await storage.save(
        key: 'user',
        value: jsonEncode(user),
      );
      return UserEntity.fromJson(user);
    } catch (error) {
      print('error $error');
      rethrow;
    }
  }
}
