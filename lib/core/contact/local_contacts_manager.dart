import 'dart:convert';

import 'package:project_test/core/cache/cache.dart';

import '../../domain/domain.dart';

class LocalContactsManager implements ContactsManager {
  final CacheStorage storage;

  LocalContactsManager({required this.storage});

  @override
  Future<void> addContact(
      ContactEntity contact, List<ContactEntity> contactList) async {
    try {
      print('contact: ${contact.contactId}');
      print('contact: ${contact.userAssociateId}');
      print('contact: ${contact.name}');
      print('contact: ${contact.phoneNumber}');
      print('contact: ${contact.photoUrl}');
      print('contact: ${contact.cpf}');
      print('contact: ${contact.address.zipCode}');
      print('contact: ${contact.address.streetName}');
      print('contact: ${contact.address.streetNumber}');
      print('contact: ${contact.address.state}');
      print('contact: ${contact.address.city}');
      contactList.add(contact);
      await storage.save(key: "contacts", value: jsonEncode(contactList));
    } catch (error) {
      print('error > $error');
    }
  }

  @override
  Future<void> updateContact(ContactEntity contact, List<ContactEntity> contactList) async {
    print('contact list before ${contactList.length}');
    final newContactList = _deleteCurrentContact(contact.contactId, contactList);
    print('newContactLis ${newContactList.length}');
    print('contact list after ${contactList.length}');
    try {
      newContactList.add(contact);
      await storage.save(key: "contacts", value: jsonEncode(newContactList));
    } catch (error) {
      print('error > $error}');
    }
  }

  List<ContactEntity> _deleteCurrentContact(String contactId, List<ContactEntity> contactList) {
    contactList.forEach((contact) {
      print('contactId > $contactId');
      print('contact.contactId > ${contact.contactId}');
      print('${contact.contactId == contactId}');
    });
    contactList.removeWhere((contact) => contact.contactId == contactId);
    return contactList;
  }

}
