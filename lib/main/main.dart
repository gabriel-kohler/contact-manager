import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:project_test/core/core.dart';
import 'package:project_test/presentation/presenters/signup_ui_controller.dart';
import 'package:project_test/screens/pages/pages.dart';
import 'package:project_test/utils/utils.dart';

import '../infrastructure/infrastructure.dart';
import '../presentation/dependencies/validation.dart';
import '../validation/validation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        AppRoutes.signIn: (context) => const LoginPage(),
        AppRoutes.signUp: (context) => SignUpPage(
              presenter: SignUpUiController(
                addNewUser: CreateNewUser(
                  cacheStorage: LocalStorageAdapter(
                    localStorage: LocalStorage('projecttest'),
                  ),
                  remoteSignUp: FirebaseAuthAdapter(
                    firebaseAuth: FirebaseAuth.instance,
                  ),
                  validation: ValidationAdapter(),
                ),
                validation: ValidationUIComposite(
                    [
                      ... ValidationUIBuilder.field('email').required().email().build(),
                      ... ValidationUIBuilder.field('password').required().minLength(6).build(),
                      ... ValidationUIBuilder.field('confirmPassword').required().sameAs('password').build(),
                    ],
                ),
              ),
            ),
      },
    );
  }
}
