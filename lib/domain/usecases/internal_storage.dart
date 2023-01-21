import 'package:project_test/domain/domain.dart';

abstract class SaveCurrentUser {
  Future<void> save({required UserEntity user});
}