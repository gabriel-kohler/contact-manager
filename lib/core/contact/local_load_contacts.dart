import 'dart:convert';

import '../../domain/domain.dart';
import '../core.dart';

class LocalLoadContacts implements LoadContacts {
  LocalLoadContacts({required this.storage});

  final CacheStorage storage;

  @override
  Future<List<ContactEntity>?> fetchContactList(String userId) async {
    try {
      final response = await storage.fetch(key: 'contacts');
      if (response != null) {
        print('response > $response');
        if (response is String) {
          final contacts = jsonDecode(response);
          final contactList = _mapToEntity(contacts);
          return contactList.fromUser(userId);
        }
        return response;
      }
      return response;
    } catch (error) {
      print ('error $error');
      rethrow;
    }
  }

  List<ContactEntity> _mapToEntity(dynamic list) => list
      .map<ContactEntity>(
          (contact) => ContactEntity.fromJson(contact).toContactEntity())
      .toList();
}
