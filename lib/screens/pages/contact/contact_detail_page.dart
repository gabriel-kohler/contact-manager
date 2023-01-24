import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:project_test/utils/utils.dart';

import '../pages.dart';

class ContactDetailPage extends StatefulWidget {
  const ContactDetailPage({Key? key, required this.presenter})
      : super(key: key);

  final EditContactPresenter presenter;

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  @override
  void initState() {
    widget.presenter.onInitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contato'),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Get.back(result: widget.presenter.hasUpdated.value);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(
                        child: Text("Tem certeza que deseja excluir esse contato?"),
                      ),
                      content: SizedBox(
                        height: 60,
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: IconsOutlineButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      text: 'Cancelar',
                                      iconData: Icons.cancel_outlined,
                                      textStyle:
                                      const TextStyle(color: Colors.grey),
                                      iconColor: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: IconsButton(
                                      onPressed: () {
                                        widget.presenter.onDeleteContact();
                                      },
                                      text: 'Deletar',
                                      iconData: Icons.delete,
                                      color: AppColors.primary,
                                      textStyle:
                                      const TextStyle(color: Colors.white),
                                      iconColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Image.asset('assets/images/editcontact.png'),
              ),
              const SizedBox(height: 25),
              Obx(() {
                return TextFormField(
                  initialValue: widget.presenter.nameController.value,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: widget.presenter.validateName,
                );
              }),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        return TextFormField(
                          initialValue:
                              widget.presenter.phoneNumberController.value,
                          decoration: InputDecoration(
                            labelText: 'Telefone°',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: widget.presenter.validatePhoneNumber,
                        );
                      }),
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: Obx(() {
                        return TextFormField(
                          initialValue: widget.presenter.cpfController.value,
                          decoration: InputDecoration(
                            labelText: 'Cpf',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onChanged: widget.presenter.validateCpf,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.presenter.goToEditAddressPage();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary),
                        child: const Text('Editar endereço'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
