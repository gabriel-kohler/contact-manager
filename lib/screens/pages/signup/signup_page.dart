import 'package:flutter/material.dart';
import 'package:project_test/screens/errors/errors.dart';
import 'package:project_test/screens/pages/pages.dart';

import '../../../utils/utils.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key, required this.presenter}) : super(key: key);

  final SignUpPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Cadastro'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    StreamBuilder<ScreenError?>(
                      stream: presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: snapshot.hasData ? snapshot.data?.description : null,
                          ),
                          onChanged: presenter.validateEmail,
                        );
                      }
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<ScreenError?>(
                      stream: presenter.passwordErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            errorText: snapshot.hasData ? "Esse campo deve ter no mínimo 6 caracteres" : null,
                          ),
                          onChanged: presenter.validatePassword,
                        );
                      }
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<ScreenError?>(
                      stream: presenter.confirmPasswordStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirmar senha',
                            errorText: snapshot.hasData ? snapshot.data?.description : null,
                          ),
                          onChanged: presenter.validateConfirmPassword,
                        );
                      }
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.addressRegistration,
                            arguments: presenter,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Continuar'),
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
