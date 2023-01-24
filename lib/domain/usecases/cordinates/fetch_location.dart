import 'package:project_test/domain/domain.dart';

abstract class FetchLocation {
  Future<LocationEntity> fetch();
}