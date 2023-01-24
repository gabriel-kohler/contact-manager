import '../../domain/domain.dart';

extension ContactListExtensions on List<ContactEntity> {
  List<ContactEntity> fromUser(String userId) =>
      where((contact) => contact.userAssociateId == userId).toList();
}