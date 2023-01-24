import 'dart:convert';

import 'package:project_test/domain/domain.dart';

import '../cache/cache_storage.dart';

class DeleteContactData implements DeleteContact {

  final CacheStorage storage;

  DeleteContactData({required this.storage});

  @override
  Future<void> delete(String contactId, List<ContactEntity> currentList) async {
    print('currentContactList > ${currentList.length}');
    currentList.removeWhere((contact) {
      print('contact id >>> ${contact.contactId}');
      print('contact id >>> $contactId');
      return contact.contactId == contactId;
    });
    print('currentContactList > ${currentList.length}');
    await storage.save(key: 'contacts', value: jsonEncode(currentList));
  }

}