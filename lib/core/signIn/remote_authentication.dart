import 'dart:convert';

import 'package:project_test/core/core.dart';
import 'package:project_test/domain/domain.dart';

class RemoteAuthentication implements Authentication {
  final CacheStorage storage;
  final SignInCore signInCore;

  RemoteAuthentication({required this.signInCore, required this.storage});

  @override
  Future<void> auth(String email, String password) async {
    try {
      final user = await signInCore.signIn(email, password);
      await storage.save(
        key: 'user',
        value: jsonEncode(user),
      );
    } on SignInCoreError catch (error) {
      throw error.handleSignInCoreError();
    }
  }
}
