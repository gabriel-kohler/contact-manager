import 'package:project_test/domain/domain.dart';

abstract class DeleteAccount {
  Future<void> delete(String password, String userId, List<ContactEntity> contactList);
}