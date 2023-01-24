import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:project_test/screens/errors/errors.dart';

import '../pages.dart';

abstract class HomePresenter {

  Rx<List<ContactViewModel>> get contacts;
  Rx<List<Marker>> get markers;
  Rx<ScreenError?> get mainError;
  MapController get mapController;
  Rx<bool> get isVisibleTextField;

  Future<ContactViewModel?> fetchContacts();
  void goToAddContact(TabController tabController);
  void goToContactDetailPage(ContactViewModel contact);
  Future<void> logout();
  Future<void> deleteUser();
  void onSearch(String value);
  void onReorder(String type);
  void onPasswordSubmitted(String value);
  Future<void> onInitState();
  void onMapCreated(MapController mapController);
}