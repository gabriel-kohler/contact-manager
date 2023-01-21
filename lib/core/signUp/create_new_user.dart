import 'dart:convert';

import '../core.dart';
import '../../domain/domain.dart';

class CreateNewUser implements AddNewUser {
  final Validation validation;
  final CacheStorage cacheStorage;
  final SignUpApi signUpApi;

  CreateNewUser({
    required this.validation,
    required this.cacheStorage,
    required this.signUpApi,
  });

  @override
  Future<void> addUser(AddNewUserParams params) async {
    try {
      print('addUser');
      print('email ${params.email}');
      print('password ${params.password}');
      await signUpApi.signUp(params.email, params.password);
    } catch (error) {
      print('error $error');
    }
  }

  String _mapToJson(Map<String, dynamic> value) => jsonEncode(value);

}
