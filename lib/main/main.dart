import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:project_test/core/core.dart';
import 'package:project_test/screens/pages/pages.dart';
import 'package:project_test/utils/utils.dart';

import '../infrastructure/infrastructure.dart';
import '../presentation/presenters/presenters.dart';
import '../validation/validation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final routeObserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: makeLoginPage(firebaseAuth),
      navigatorObservers: [routeObserver],
      getPages: [
        GetPage(
          name: AppRoutes.signIn,
          page: () => makeLoginPage(
            firebaseAuth,
          ),
        ),
        GetPage(
          name: AppRoutes.signUp,
          page: () => makeSignUpPage(firebaseAuth),
        ),
        GetPage(
          name: AppRoutes.homePage,
          page: () => const HomePage(),
        ),
      ],
    );
  }
}

LoginPage makeLoginPage(FirebaseAuth firebaseAuth) => LoginPage(
      presenter: SignInUiController(
        authentication: RemoteAuthentication(
          signInApi: FirebaseAuthAdapter(firebaseAuth: firebaseAuth),
        ),
        validation: ValidationUIComposite(
          [
            RequiredFieldValidation('email'),
            EmailValidation('email'),
            RequiredFieldValidation('password'),
          ],
        ),
      ),
    );

SignUpPage makeSignUpPage(FirebaseAuth firebaseAuth) => SignUpPage(
        presenter: SignUpUiController(
      addNewUser: CreateNewUser(
        cacheStorage: LocalStorageAdapter(
          localStorage: LocalStorage('projecttest'),
        ),
        signUpApi: FirebaseAuthAdapter(
          firebaseAuth: firebaseAuth,
        ),
        validation: ValidationAdapter(),
      ),
      validation: ValidationUIComposite(
        [
          ...ValidationUIBuilder.field('email').required().email().build(),
          ...ValidationUIBuilder.field('password')
              .required()
              .minLength(6)
              .build(),
          ...ValidationUIBuilder.field('confirmPassword')
              .required()
              .sameAs('password')
              .build(),
        ],
      ),
    ));
