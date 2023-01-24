import 'package:project_test/domain/domain.dart';

abstract class CheckLocationPermission {
  Future<void> checkPermission();
}