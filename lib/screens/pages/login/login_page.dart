import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                      'Login',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined),
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.password),
                      hintText: 'Senha',
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Ainda não tem uma conta?'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.signUp);
              },
              child: const Text(
                'Clique aqui e faça o seu cadastro',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
