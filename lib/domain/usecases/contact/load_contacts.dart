import 'package:project_test/domain/domain.dart';

abstract class LoadContacts {
  Future<List<ContactEntity>?> fetchContactList(String userId);
}