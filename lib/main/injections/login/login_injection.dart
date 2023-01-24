import 'package:firebase_auth/firebase_auth.dart';
import 'package:localstorage/localstorage.dart';

import '../../../core/core.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../../presentation/presentation.dart';
import '../../../screens/pages/pages.dart';
import '../../../validation/validation.dart';

LoginPage makeLoginPage(FirebaseAuth firebaseAuth, LocalStorage storage) =>
    LoginPage(
      presenter: SignInUiController(
        authentication: RemoteAuthentication(
          storage: LocalStorageAdapter(localStorage: storage),
          signInCore: FirebaseAuthAdapter(firebaseAuth: firebaseAuth),
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