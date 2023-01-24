import 'package:project_test/domain/domain.dart';

abstract class ManagerCurrentUser {
  Future<UserEntity>? fetch();
  Future<void> delete();
}