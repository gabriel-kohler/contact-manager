import '../../domain.dart';

abstract class ContactsManager {
  Future<void> addContact(ContactEntity contact, List<ContactEntity> currentContactList);
  Future<void> updateContact(ContactEntity contact, List<ContactEntity> currentContactList);
}