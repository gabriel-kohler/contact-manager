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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Faça o seu cadastro'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Image.asset('assets/images/signup.png'),
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
                    child: StreamBuilder<bool>(
                      stream: presenter.isFormValidStream,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: snapshot.data == true ? presenter.signUp : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Continuar'),
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
