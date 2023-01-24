import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/screens/errors/screen_errors.dart';

import '../../../utils/utils.dart';
import '../pages.dart';

class AddContactPage extends StatelessWidget {
  AddContactPage({Key? key, required this.presenter}) : super(key: key);

  final ContactPresenter presenter;

  final TextEditingController cityInput = TextEditingController();
  final TextEditingController streetInput = TextEditingController();
  final TextEditingController districtInput = TextEditingController();
  final TextEditingController complementInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar contato'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Get.back(result: false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Image.asset('assets/images/addcontact2.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Obx(() {
                          return TextFormField(
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              errorText: presenter.nameError.value?.description,
                            ),
                            onChanged: presenter.validateName,
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Telefone',
                              errorText:
                              presenter.phoneNumberError.value?.description,
                            ),
                            onChanged: presenter.validatePhoneNumber,
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Cpf',
                              errorText: presenter.cpfError.value?.description,
                            ),
                            onChanged: presenter.validateCpf,
                          );
                        }),
                        const SizedBox(height: 20),
                        Obx(() {
                          return TextFormField(
                            maxLength: 8,
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: 'Cep',
                              errorText:
                              presenter.phoneNumberError.value?.description,
                            ),
                            onChanged: (v) async {
                              presenter.validateCep(v);
                              if (v.length == 8) {
                                await presenter.checkZipCode();
                                streetInput.text =
                                    presenter.streetController?.value ?? "";
                                cityInput.text =
                                    presenter.cityController?.value ?? "";
                                complementInput.text =
                                    presenter.complementController?.value ?? "";
                                districtInput.text =
                                    presenter.districtController?.value ?? "";
                              }
                            },
                          );
                        }),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Endereço',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: AppColors.color1,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Obx(() {
                      return TextFormField(
                        controller: streetInput,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Logradouro',
                          errorText: presenter.streetError.value?.description,
                        ),
                        onChanged: presenter.validateStreet,
                      );
                    }),
                    const SizedBox(height: 20),
                    Obx(() {
                      return TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Número',
                          errorText:
                          presenter.streetNumberError.value?.description,
                        ),
                        onChanged: presenter.validateStreetNumber,
                      );
                    }),
                    const SizedBox(height: 20),
                    Obx(() {
                      return TextFormField(
                        controller: districtInput,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Bairro',
                          errorText: presenter.districtError.value?.description,
                        ),
                        onChanged: presenter.validateDistrict,
                      );
                    }),
                    const SizedBox(height: 40),
                    ChooseStateDropDown(presenter: presenter),
                    const SizedBox(height: 20),
                    Obx(() {
                      return TextFormField(
                        controller: cityInput,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Cidade',
                          errorText: presenter.cityError.value?.description,
                        ),
                        onChanged: presenter.validateCity,
                      );
                    }),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: complementInput,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: 'Complemento',
                      ),
                      onChanged: presenter.validateComplement,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        return ElevatedButton(
                          onPressed: presenter.isFormValid.value ? presenter
                              .onSubmit : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Salvar contato'),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseStateDropDown extends StatelessWidget {
  const ChooseStateDropDown({Key? key, required this.presenter})
      : super(key: key);

  final ContactPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          DropdownButtonFormField2(
            value: presenter.stateController.value,
            decoration: InputDecoration(
              errorText: presenter.stateError.value?.description,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
            buttonHeight: 50,
            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            items: [
              'Acre',
              'Alagoas',
              'Amapá',
              'Amazonas',
              'Bahia',
              'Ceará',
              'Espírito Santo',
              'Goiás',
              'Maranhão',
              'Mato Grosso',
              'Mato Grosso do Sul',
              'Minas Gerais',
              'Pará',
              'Paraíba',
              'Paraná',
              'Pernambuco',
              'Piauí',
              'Rio de Janeiro',
              'Rio Grande do Norte',
              'Rio Grande do Sul',
              'Rondônia',
              'Roraima',
              'Santa Catarina',
              'São Paulo',
              'Sergipe',
              'Tocantins',
              'Distrito Federal',
            ]
                .map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              );
            })
                .toList(),
            onChanged: presenter.validateState,
          ),
    );
  }
}
