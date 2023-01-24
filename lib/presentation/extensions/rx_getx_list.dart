import 'package:get/get.dart';

extension ClearRxObservableList on Rx<List> {
  clear() => value = [];
}