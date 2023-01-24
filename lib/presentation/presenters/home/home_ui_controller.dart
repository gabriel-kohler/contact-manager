import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_test/domain/domain.dart';
import 'package:project_test/presentation/extensions/rx_getx_list.dart';
import 'package:project_test/presentation/presentation.dart';
import 'package:project_test/screens/errors/errors.dart';

import '../../../screens/pages/pages.dart';
import '../../../utils/utils.dart';

class HomeUiController extends GetxController implements HomePresenter {
  final LoadContacts loadContacts;
  final ManagerCurrentUser managerCurrentUser;
  final DeleteAccount deleteAccount;

  HomeUiController({
    required this.loadContacts,
    required this.managerCurrentUser,
    required this.deleteAccount,
  });

  late final UserEntity? _user;

  final Rx<List<ContactViewModel>> _contacts = Rx<List<ContactViewModel>>([]);

  final Rx<List<Marker>> _markers = Rx<List<Marker>>([]);

  @override
  Rx<ScreenError?> mainError = Rx<ScreenError?>(null);

  @override
  Rx<bool> isVisibleTextField = false.obs;

  @override
  Rx<List<ContactViewModel>> get contacts => _contacts;

  @override
  Rx<List<Marker>> get markers => _markers;

  @override
  MapController get mapController => _mapController;

  ContactViewModel? get lastContactAdded => _lastContactAdded;

  late MapController _mapController;
  String _password = '';
  ContactViewModel? _lastContactAdded;

  Rx<bool> hasUpdated = false.obs;

  @override
  void onMapCreated(MapController mapController) {
    _mapController = mapController;
    print('hasUpdate ${hasUpdated.value}');
    if (hasUpdated.value) {
      _centerLocationOnNewContact();
    }
  }

  @override
  Future<void> onInitState() async {
    _user = await managerCurrentUser.fetch();
    await fetchContacts();
    _updateMarkers();
  }

  @override
  Future<ContactViewModel?> fetchContacts() async {
    print('fetchContacts');
    try {
      final contactsList = await loadContacts.fetchContactList(_user?.id ?? "");
      if (contactsList != null && contactsList.isNotEmpty) {
        contacts.value =
            contactsList.map((contact) => contact.toViewModel()).toList();
        return contacts.value.last;
      } else {
        contacts.value = contacts.clear();
      }
    } catch (error) {
      print('error > $error');
    }
    return null;
  }

  @override
  void goToAddContact(TabController tabController) async {
    hasUpdated.value = await Get.toNamed(
      AppRoutes.addContactPage,
      arguments: contacts.value,
    );
    if (hasUpdated.value) {
      _lastContactAdded = await fetchContacts();
      _updateMarkers();
      tabController.animateTo(1);
    }
  }

  @override
  void goToContactDetailPage(ContactViewModel contact) async {
    hasUpdated.value = await Get.toNamed(
      AppRoutes.contactDetailPage,
      arguments: ContactDetailViewModel(
        contact: contact,
        currentContactList: contacts.value,
      ),
    );

    if (hasUpdated.value) {
      await fetchContacts();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await managerCurrentUser.delete();
      Get.offAllNamed(AppRoutes.signIn);
    } catch (error) {
      print('error > $error');
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      mainError.value = null;
      await deleteAccount.delete(
        _password,
        _user?.id ?? "",
        _toContactEntity(contacts.value),
      );
      Get.offAllNamed(AppRoutes.signIn);
    } on AuthenticationError catch (error) {
      mainError.value = error.handleAuthenticationError();
    } catch (error) {
      rethrow;
    }
  }

  @override
  void onPasswordSubmitted(String value) {
    _password = value;
  }

  @override
  void onSearch(String value) {
    final index = contacts.value.indexWhere((element) => element.name == value);
    final contact = contacts.value.removeAt(index);
    contacts.value.insert(0, contact);
  }

  @override
  void onReorder(String type) {
    switch (type) {
      case 'Ordem alfabética':
        contacts.value.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Recentes':
        contacts.value.sort((a, b) => b.date.compareTo(a.date));
        break;
      case 'Antigos':
        contacts.value.sort((a, b) => a.name.compareTo(b.name));
        break;
    }
      contacts.refresh();
  }

  List<ContactEntity> _toContactEntity(List<ContactViewModel> contactList) =>
      contactList.map((contact) => contact.toEntity()).toList();

  void _centerLocation(double lat, double lng) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(LatLng(lat, lng), 15);
    });
  }

  void _centerLocationOnNewContact() {
    print('_lastContactAdded ${_lastContactAdded?.name}');
    print('_lastContactAdded ${_lastContactAdded?.contactId}');
    if (_lastContactAdded?.contactId != null) {
      _centerLocation(
        double.parse(_lastContactAdded?.lat ?? ""),
        double.parse(_lastContactAdded?.lng ?? ""),
      );
    }
    hasUpdated.value = false;
  }

  void _updateMarkers() {
    print('_updateMarkers > ${contacts.value}');
    if (contacts.value.isNotEmpty) {
      for (var contact in _contacts.value) {
        _markers.value.add(
          ContactMarker(
            onTap: () {
              goToContactDetailPage(contact);
            },
            lat: double.parse(contact.lat),
            lng: double.parse(contact.lng),
            child: SvgPicture.asset(
              AppConstants.contactMarkerPath,
            ),
          ),
        );
      }
    } else {
      _markers.value = _markers.clear();
    }
  }
}
