import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstorage/localstorage.dart';

import '../../../core/core.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../../presentation/presentation.dart';
import '../../../screens/pages/pages.dart';
import '../../../validation/validation.dart';

SignUpPage makeSignUpPage(FirebaseAuth firebaseAuth, LocalStorage storage) =>
    SignUpPage(
        presenter: SignUpUiController(
          addNewUser: CreateNewUser(
            storage: LocalStorageAdapter(
              localStorage: storage,
            ),
            signUpCore: FirebaseAuthAdapter(
              firebaseAuth: firebaseAuth,
            ),
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
        ),);