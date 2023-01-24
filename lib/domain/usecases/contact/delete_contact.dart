import '../../domain.dart';

abstract class DeleteContact {
  Future<void> delete(String contactId, List<ContactEntity> currentList);
}