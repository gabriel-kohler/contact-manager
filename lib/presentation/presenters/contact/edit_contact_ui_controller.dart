import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_test/presentation/extensions/string_extensions.dart';
import 'package:project_test/screens/errors/screen_errors.dart';
import 'package:project_test/utils/utils.dart';

import '../../../domain/domain.dart';
import '../../../screens/pages/pages.dart';
import '../../../screens/utils/toast_util.dart';
import '../../presentation.dart';

class EditContactUiController extends GetxController
    implements EditContactPresenter {
  final ZipCode zipCode;
  final ValidationUI validation;
  final ContactsManager contactsManager;
  final ManagerCurrentUser managerCurrentUser;
  final LoadCordinates loadCordinates;
  final DeleteContact deleteContact;

  EditContactUiController({
    required this.zipCode,
    required this.validation,
    required this.contactsManager,
    required this.managerCurrentUser,
    required this.loadCordinates,
    required this.deleteContact,
  });

  final Rx<ScreenError?> _nameError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _phoneNumberError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _cpfError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _cpfRepeatedError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _cepError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _streetError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _streetNumberError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _districtError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _stateError = Rx<ScreenError?>(null);
  final Rx<ScreenError?> _cityError = Rx<ScreenError?>(null);
  final Rx<String> _nameController = Rx<String>("");
  final Rx<String> _phoneController = Rx<String>("");
  final Rx<String> _cpfController = Rx<String>("");
  final Rx<String> _cepController = Rx<String>("");
  final Rx<String> _streetController = Rx<String>("");
  final Rx<String> _streetNumberController = Rx<String>("");
  final Rx<String> _districtController = Rx<String>("");
  final Rx<String> _stateController = Rx<String>("");
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
  Rx<ScreenError?> get cpfRepeatedError => _cpfRepeatedError;

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
  Rx<bool> get isFormValid => _isFormValid;

  @override
  Rx<bool> get isLoading => _isLoading;

  @override
  Rx<bool> get hasUpdated => _hasUpdated;

  @override
  Rx<String> get nameController => _nameController;

  @override
  Rx<String> get phoneNumberController => _phoneController;

  @override
  Rx<String> get cpfController => _cpfController;

  @override
  Rx<String> get cepController => _cepController;

  @override
  Rx<String> get streetController => _streetController;

  @override
  Rx<String> get streetNumberController => _streetNumberController;

  @override
  Rx<String> get districtController => _districtController;

  @override
  Rx<String> get stateController => _stateController;

  @override
  Rx<String> get cityController => _cityController;

  @override
  Rx<String> get complementController => _complementController;

  ContactDetailViewModel? editContactsViewModel;
  ContactViewModel? currentContact;
  List<ContactViewModel>? contacts;

  List<String>? get _cpfList =>
      contacts?.map((contact) => contact.cpf.toString()).toList();

  @override
  void onInitState() {
    editContactsViewModel = Get.arguments;
    currentContact = editContactsViewModel?.contact;
    contacts = editContactsViewModel?.currentContactList;
    _getTextFieldInitialValues();
  }

  @override
  Future<void> onSubmit() async {
    _validateAllForms();
    final contactList = _toContactEntity(contacts!);
    try {
      final user = await _fetchUser();
      final location = await loadCordinates.fetchLocationFromAddress(
          "${_streetController.value} ${_streetNumberController.value}");
      await zipCode.checkZipCode(_cepController.value ?? "");

      final address = _getAddress();
      final contact = _getContact(address, location, user?.id, currentContact!);

      await contactsManager.updateContact(contact, contactList);
      ToastUtil.instance.showToast(
        message: "Contato salvo",
        backgroundColor: AppColors.color1,
        textColor: Colors.white,
      );
      hasUpdated.value = true;
    } catch (error) {
      print('error > $error');
      ToastUtil.instance.showToast(
        message: "Ocorreu um erro. Verifique os campos e tente novamente.",
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
      );
    }
  }

  @override
  Future<void> onDeleteContact() async {
    try {
      print('currentCOntact ${currentContact?.contactId}');
      final contactList = _toContactEntity(contacts!);
      await deleteContact.delete(currentContact?.contactId ?? "", contactList);
      hasUpdated.value = true;
      Get.offAllNamed(AppRoutes.homePage);
    } catch (error) {
      print('onDeleteContact error >$error');
    }
  }

  AddressEntity _getAddress() => AddressEntity(
        streetName: _streetController.value,
        streetNumber: int.parse(_streetNumberController.value),
        zipCode: int.parse(_cepController.value),
        state: _stateController.value,
        city: _cityController.value,
        district: _districtController.value,
      );

  ContactEntity _getContact(
    AddressEntity address,
    LocationEntity location,
    String? userId,
    ContactViewModel contact,
  ) =>
      ContactEntity(
        contactId: contact.contactId,
        userAssociateId: userId ?? "",
        name: _nameController.value,
        photoUrl: "",
        phoneNumber: int.parse(_phoneController.value),
        cpf: int.parse(_cpfController.value),
        lat: location.latitude,
        lng: location.longitude,
        date: contact.date,
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
      'name': _nameController.value,
      'phoneNumber': _phoneController.value,
      'cpf': _cpfController.value,
      'cpfList': _cpfList,
      'cep': _cepController.value,
      'street': _streetController.value,
      'streetNumber': _streetNumberController.value,
      'district': _districtController.value,
      'state': _stateController.value,
      'city': _cityController.value,
      'complement': _complementController.value,
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
            cpfRepeatedError.value == null &&
            streetNumberError.value == null &&
            districtError.value == null &&
            stateError.value == null &&
            cityError.value == null
        ? true
        : false;
  }

  @override
  void validateName(String name) {
    print('validateName');
    _nameController.value = name;
    nameError.value = _validateField('name');
    _validateForm();
  }

  @override
  void validatePhoneNumber(String phoneNumber) {
    _phoneController.value = phoneNumber.removeCaractersAndNumbers();
    phoneNumberError.value = _validateField('phoneNumber');
    _validateForm();
  }

  @override
  void validateCpf(String cpf) {
    _cpfController.value = cpf.removeCaractersAndNumbers();
    cpfError.value = _validateField('cpf');
    _validateForm();
  }

  @override
  void validateCep(String cep) {
    _cepController.value = cep.removeCaractersAndNumbers();
    cepError.value = _validateField('cep');
    _validateForm();
  }

  @override
  void validateStreet(String street) {
    _streetController.value = street;
    streetError.value = _validateField('street');
    _validateForm();
  }

  @override
  void validateStreetNumber(String streetNumber) {
    _streetNumberController.value = streetNumber.removeCaractersAndNumbers();
    streetNumberError.value = _validateField('streetNumber');
    _validateForm();
  }

  @override
  void validateDistrict(String district) {
    _districtController.value = district;
    districtError.value = _validateField('district');
    _validateForm();
  }

  @override
  void validateState(String state) {
    _stateController.value = state;
    stateError.value = _validateField('state');
    _validateForm();
    print('state > ${stateController.value}');
  }

  @override
  void validateCity(String city) {
    _cityController.value = city;
    cityError.value = _validateField('city');
    _validateForm();
  }

  @override
  void validateComplement(String complement) {
    _complementController.value = complement;
  }

  @override
  void goToEditAddressPage() {
    Get.toNamed(
      AppRoutes.contactAddressDetailPage,
      arguments: editContactsViewModel,
    );
  }

  void _validateAllForms() {
    nameError.value = _validateField('name');
    phoneNumberError.value = _validateField('phoneNumber');
    cpfError.value = _validateField('cpf');
    cepError.value = _validateField('cep');
    streetError.value = _validateField('street');
    streetNumberError.value = _validateField('streetNumber');
    districtError.value = _validateField('district');
    cityError.value = _validateField('city');
  }

  Future<UserEntity?> _fetchUser() async {
    return await managerCurrentUser.fetch();
  }

  void _getTextFieldInitialValues() {
    _nameController.value = currentContact?.name ?? "";
    _phoneController.value = currentContact?.phoneNumber.toString() ?? "";
    _cpfController.value = currentContact?.cpf.toString() ?? "";
    _cepController.value = currentContact?.address.zipCode.toString() ?? "";
    _streetController.value = currentContact?.address.streetName ?? "";
    _streetNumberController.value =
        currentContact?.address.streetNumber.toString() ?? "";
    _districtController.value = currentContact?.address.district ?? "";
    _stateController.value = currentContact?.address.state ?? "";
    _cityController.value = currentContact?.address.city.toString() ?? "";
    _complementController.value = currentContact?.address.complement ?? "";
  }
}
