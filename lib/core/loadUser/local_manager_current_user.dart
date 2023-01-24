import 'dart:convert';

import 'package:project_test/domain/domain.dart';

import '../core.dart';

class LocalManagerCurrentUser implements ManagerCurrentUser {

  final CacheStorage storage;

  LocalManagerCurrentUser({required this.storage});

  @override
  Future<UserEntity> fetch() async {
    try {
      final user = await storage.fetch(key: 'user');
      if (user == null) {
        throw Exception();
      }
      return UserEntity.fromJson(jsonDecode(user));
    } catch (error) {
      print('error $error');
      rethrow;
    }
  }

  @override
  Future<void> delete() async {
    try {
      await storage.delete(key: 'user');
    } catch (error) {
      print('error $error');
    }
  }



}