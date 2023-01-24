import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../errors/errors.dart';

abstract class ContactPresenter {
  Rx<ScreenError?> get nameError;
  Rx<ScreenError?> get phoneNumberError;
  Rx<ScreenError?> get cpfError;
  Rx<ScreenError?> get cepError;
  Rx<ScreenError?> get streetError;
  Rx<ScreenError?> get streetNumberError;
  Rx<ScreenError?> get districtError;
  Rx<ScreenError?> get stateError;
  Rx<ScreenError?> get cityError;
  Rx<String>? get streetController;
  Rx<String>? get districtController;
  Rx<String> get stateController;
  Rx<String>? get cityController;
  Rx<String>? get complementController;
  Rx<bool> get isFormValid;
  Rx<bool> get isLoading;
  Rx<bool> get hasUpdated;
  TextEditingController get streetInput;
  TextEditingController get districtInput;
  TextEditingController get cityInput;

  void validateName(String name);
  void validatePhoneNumber(String phoneNumber);
  void validateCpf(String cpf);
  void validateCep(String cep);
  void validateStreet(String street);
  void validateDistrict(String district);
  void validateStreetNumber(String streetNumber);
  void validateState(String? state);
  void validateCity(String city);
  void validateComplement(String complement);
  Future<void> checkZipCode();
  Future<void> onSubmit();
}