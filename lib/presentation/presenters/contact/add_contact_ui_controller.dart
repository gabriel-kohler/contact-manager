import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/domain/domain.dart';
import 'package:project_test/presentation/extensions/string_extensions.dart';
import 'package:project_test/screens/pages/pages.dart';
import 'package:project_test/screens/utils/toast_util.dart';

import '../../../screens/errors/errors.dart';
import '../../../utils/app_colors.dart';
import '../../dependencies/validation.dart';

class AddContactUiController extends GetxController
    implements ContactPresenter {
  final ZipCode zipCode;
  final ValidationUI validation;
  final ContactsManager contactsManager;
  final ManagerCurrentUser managerCurrentUser;
  final LoadCordinates loadCordinates;

  AddContactUiController({
    required this.zipCode,
    required this.validation,
    required this.contactsManager,
    required this.managerCurrentUser,
    required this.loadCordinates,
  });

  String? _name;
  String? _phoneNumber;
  String? _cpf;
  String? _cep;
  String? _street;
  String? _district;
  String? _streetNumber;
  String? _city;
  String? _state;
  String? _complement;

  final Rx<ScreenError?> _nameError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _phoneNumberError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _cpfError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _cepError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _streetError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _streetNumberError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _districtError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _stateError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _cityError = Rx<ScreenError?>(null);
  final Rx<String> _streetController = Rx<String>("");
  final Rx<String> _districtController = Rx<String>("");
  final Rx<String> _stateController = Rx<String>("Acre");
  final Rx<String> _cityController = Rx<String>("");
  final Rx<String> _complementController = Rx<String>("");
  final Rx<bool> _isFormValid = false.obs;
  final Rx<bool> _isLoading = false.obs;
  final Rx<bool> _hasUpdated = false.obs;

  @override
  Rx<ScreenError?> get nameError => _nameError;

  @override
  Rx<ScreenError?> get phoneNumberError => _phoneNumberError;

  @override
  Rx<ScreenError?> get cpfError => _cpfError;

  @override
  Rx<ScreenError?> get cepError => _cepError;

  @override
  Rx<ScreenError?> get streetError => _streetError;

  @override
  Rx<ScreenError?> get streetNumberError => _streetNumberError;

  @override
  Rx<ScreenError?> get districtError => _districtError;

  @override
  Rx<ScreenError?> get stateError => _stateError;

  @override
  Rx<ScreenError?> get cityError => _cityError;

  @override
  Rx<String> get streetController => _streetController;

  @override
  Rx<String> get districtController => _districtController;

  @override
  Rx<String> get stateController => _stateController;

  @override
  Rx<String> get cityController => _cityController;

  @override
  Rx<String> get complementController => _complementController;

  @override
  Rx<bool> get isFormValid => _isFormValid;

  @override
  Rx<bool> get isLoading => _isLoading;

  @override
  Rx<bool> get hasUpdated => _hasUpdated;

  @override
  TextEditingController get streetInput => TextEditingController();

  @override
  TextEditingController get districtInput => TextEditingController();

  @override
  TextEditingController get cityInput => TextEditingController();

  List<ContactViewModel> get contacts => Get.arguments;

  List<String> get _cpfList =>
      contacts.map((contact) => contact.cpf.toString()).toList();

  @override
  Future<void> onSubmit() async {
    final contactList = _toContactEntity(contacts);
    try {
      final user = await _fetchUser();
      final location = await loadCordinates.fetchLocationFromAddress(
          "${_streetController.value} $_streetNumber");

      final address = _getAddress();
      final contact = _getContact(address, location, user?.id);

      await contactsManager.addContact(contact, contactList);
      hasUpdated.value = true;
      Get.back(result: hasUpdated.value);
    } catch (error) {
      print('error > $error');
      ToastUtil.instance.showToast(
        message: "Ocorreu um erro. Verifique os campos e tente novamente.",
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
      );
    }
  }

  AddressEntity _getAddress() {
    print('teste > $_state');
    return AddressEntity(
      streetName: _streetController.value,
      streetNumber: int.parse(_streetNumber!),
      zipCode: int.parse(_cep!),
      state: _stateController.value,
      city: _cityController.value,
      district: _districtController.value,
      complement: _complement,
    );
  }

  ContactEntity _getContact(
    AddressEntity address,
    LocationEntity location,
    String? userId,
  ) =>
      ContactEntity(
        contactId: _name.hashCode.toString(),
        userAssociateId: userId ?? "",
        name: _name!,
        photoUrl: "",
        phoneNumber: int.parse(_phoneNumber!),
        cpf: int.parse(_cpf!),
        lat: location.latitude,
        lng: location.longitude,
        date: DateTime.now().toString(),
        address: address,
      );

  List<ContactEntity> _toContactEntity(List<ContactViewModel> contacts) {
    return contacts
        .map(
          (c) => ContactEntity(
            contactId: c.contactId,
            userAssociateId: c.userAssociateId,
            name: c.name,
            photoUrl: c.photoUrl,
            phoneNumber: c.phoneNumber,
            cpf: c.cpf,
            lat: c.lat,
            lng: c.lng,
            date: c.date,
            address: AddressEntity(
              zipCode: c.address.zipCode,
              streetName: c.address.streetName,
              streetNumber: c.address.streetNumber,
              district: c.address.district,
              city: c.address.city,
              state: c.address.state,
              complement: c.address.complement,
            ),
          ),
        )
        .toList();
  }

  ScreenError? _validateField(String field) {
    final formData = {
      'name': _name,
      'phoneNumber': _phoneNumber,
      'cpf': _cpf,
      'cpfList': _cpfList,
      'cep': _cep,
      'street': _street,
      'streetNumber': _streetNumber,
      'district': _district,
      'state': _state,
      'city': _city,
      'complement': _complement,
    };
    final error = validation.validate(field: field, inputFormData: formData);
    switch (error) {
      case ValidationError.invalidField:
        return ScreenError.invalidField;
      case ValidationError.requiredField:
        return ScreenError.requiredField;
      case ValidationError.cpfRepeated:
        return ScreenError.cpfRepeated;
      default:
        return null;
    }
  }

  void _validateForm() {
    isFormValid.value = nameError.value == null &&
            phoneNumberError.value == null &&
            cpfError.value == null &&
            cepError.value == null &&
            streetError.value == null &&
            streetNumberError.value == null &&
            districtError.value == null &&
            stateError.value == null &&
            cityError.value == null &&
            _name != null &&
            _phoneNumber != null &&
            _cpf != null &&
            _cep != null &&
            _streetNumber != null
        ? true
        : false;
    print('isFormValid > ${isFormValid.value}');
  }

  @override
  void validateName(String name) {
    _name = name;
    nameError.value = _validateField('name');
    _validateForm();
  }

  @override
  void validatePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber.removeCaractersAndNumbers();
    phoneNumberError.value = _validateField('phoneNumber');
    _validateForm();
  }

  @override
  void validateCpf(String cpf) {
    _cpf = cpf.removeCaractersAndNumbers();
    cpfError.value = _validateField('cpf');

    _validateForm();
  }

  @override
  void validateCep(String cep) {
    _cep = cep.removeCaractersAndNumbers();
    cepError.value = _validateField('cep');
    _validateForm();
  }

  @override
  void validateStreet(String street) {
    _street = street;
    streetError.value = _validateField('street');
    _validateForm();
  }

  @override
  void validateStreetNumber(String streetNumber) {
    _streetNumber = streetNumber.removeCaractersAndNumbers();
    streetNumberError.value = _validateField('streetNumber');
    _validateForm();
  }

  @override
  void validateDistrict(String district) {
    _district = district;
    districtError.value = _validateField('district');
    _validateForm();
  }

  @override
  void validateState(String? state) {
    _state = state;
    stateError.value = _validateField('state');
    _validateForm();
    print('state > $_state');
  }

  @override
  void validateCity(String city) {
    _city = city;
    cityError.value = _validateField('city');
    _validateForm();
  }

  @override
  void validateComplement(String complement) {
    _complement = complement;
  }

  @override
  Future<void> checkZipCode() async {
    final addressFromZipCode = await zipCode.checkZipCode(_cep ?? "");
    _streetController.value = addressFromZipCode.streetName;
    _districtController.value = addressFromZipCode.district;
    _stateController.value = addressFromZipCode.state;
    _cityController.value = addressFromZipCode.city;
    _complementController.value = addressFromZipCode.complement ?? "";
  }

  Future<UserEntity?> _fetchUser() async {
    return await managerCurrentUser.fetch();
  }
}
