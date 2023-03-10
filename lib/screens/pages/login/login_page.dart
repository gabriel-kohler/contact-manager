import 'package:flutter/material.dart';
import 'package:project_test/screens/pages/login/login.dart';

import '../../../utils/utils.dart';
import '../../errors/screen_errors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  final LoginPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Builder(builder: (context) {
        presenter.mainErrorStream.listen((ScreenError? mainError) {
          if (mainError != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(mainError.description),
                  ),
                )
                .closed
                .then(
                  (value) => ScaffoldMessenger.of(context).clearSnackBars(),
                );
          }
        });
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: Image.asset('assets/images/signin.png'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    StreamBuilder<ScreenError?>(
                        stream: presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            key: const ValueKey('email'),
                            decoration: InputDecoration(
                              icon: const Icon(Icons.email_outlined),
                              labelText: 'Email',
                              errorText: snapshot.hasData
                                  ? snapshot.data?.description
                                  : null,
                            ),
                            onChanged: presenter.validateEmail,
                          );
                        }),
                    const SizedBox(height: 20),
                    StreamBuilder<ScreenError?>(
                        stream: presenter.passwordErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            key: const ValueKey('password'),
                            obscureText: true,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.password),
                              labelText: 'Senha',
                              errorText: snapshot.hasData
                                  ? snapshot.data?.description
                                  : null,
                            ),
                            onChanged: presenter.validatePassword,
                          );
                        }),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: StreamBuilder<bool>(
                          stream: presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed:
                                  snapshot.data == true ? presenter.auth : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Login'),
                            );
                          }),
                    ),
                    const SizedBox(height: 20),
                    const Text('Ainda n??o tem uma conta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.signUp);
                      },
                      child: const Text(
                        'Clique aqui e fa??a o seu cadastro',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
