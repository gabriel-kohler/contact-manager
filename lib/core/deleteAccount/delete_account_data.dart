import 'dart:convert';

import 'package:project_test/domain/domain.dart';

import '../core.dart';

class DeleteAccountData implements DeleteAccount {
  final CacheStorage storage;
  final RemoteDeleteUser remoteDeleteUser;

  DeleteAccountData({required this.storage, required this.remoteDeleteUser});

  @override
  Future<void> delete(String password, String userId, List<ContactEntity> contactList) async {
    try {
      await _removeUserData(userId, contactList);
      await _removeUserAccount(userId, password);
    } on SignInCoreError catch (error) {
      throw error.handleSignInCoreError();
    }
    catch (error) {
      print('error > $error');
    }
  }

  Future<void> _removeUserData(
      String userId, List<ContactEntity> contactList) async {
    contactList.removeWhere((contact) => contact.userAssociateId == userId);
    await storage.save(key: 'contacts', value: jsonEncode(contactList));
  }

  Future<void> _removeUserAccount(String userId, String password) async {
    await remoteDeleteUser.deleteUser(password);
  }
}
