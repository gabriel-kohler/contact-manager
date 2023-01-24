import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_test/screens/errors/screen_errors.dart';
import 'package:project_test/screens/pages/pages.dart';

import '../../../utils/utils.dart';

class ContactAddressDetailPage extends StatefulWidget {
  const ContactAddressDetailPage({Key? key, required this.presenter})
      : super(key: key);

  final EditContactPresenter presenter;

  @override
  State<ContactAddressDetailPage> createState() =>
      _ContactAddressDetailPageState();
}

class _ContactAddressDetailPageState extends State<ContactAddressDetailPage> {

  @override
  void initState() {
    widget.presenter.onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contato'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Center(
              child: Text(
                'Endereço',
                style: TextStyle(
                  color: AppColors.color1,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: Obx(() {
                      return TextFormField(
                        initialValue: widget.presenter.streetController.value,
                        decoration: InputDecoration(
                          labelText: 'Logradouro',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(() {
                      return TextFormField(
                        initialValue: widget.presenter.streetNumberController
                            .value,
                        decoration: InputDecoration(
                          labelText: 'N°',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: widget.presenter.validateStreetNumber,
                      );
                    }),
                  ),
                ],
              ),
            ),
            Obx(() {
              return TextFormField(
                initialValue: widget.presenter.cepController.value,
                decoration: InputDecoration(
                  labelText: 'Cep°',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: widget.presenter.validateCep,
              );
            }),
            EditChooseStateDropDown(presenter: widget.presenter),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return TextFormField(
                        initialValue: widget.presenter.districtController.value,
                        decoration: InputDecoration(
                          labelText: 'Bairro°',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: widget.presenter.validateDistrict,
                      );
                    }),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(() {
                      return TextFormField(
                        initialValue: widget.presenter.cityController.value,
                        decoration: InputDecoration(
                          labelText: 'Cidade',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: widget.presenter.validateCity,
                      );
                    }),
                  ),
                ],
              ),
            ),
            Obx(() {
              return TextFormField(
                initialValue: widget.presenter.complementController.value,
                decoration: InputDecoration(
                  labelText: 'Complemento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              );
            }),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.presenter.onSubmit();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary),
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditChooseStateDropDown extends StatelessWidget {
  const EditChooseStateDropDown({Key? key, required this.presenter})
      : super(key: key);

  final EditContactPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField2(
        value: presenter.stateController.value,
        decoration: InputDecoration(
          errorText: presenter.stateError.value?.description,
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        isExpanded: true,
        hint: const Text(
          'Selecione o estado',
          style: TextStyle(fontSize: 14),
        ),
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
          'Rondônia',
          'Roraima',
          'São Paulo',
          'Sergipe',
          'Tocantins',
          'Distrito Federal',
        ]
            .map((item) =>
            DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return 'Selecione o estado';
          }
        },
        onChanged: (value) {

        },
      );
    });
  }
}