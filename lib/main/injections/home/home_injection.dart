import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/core.dart';
import '../../../core/loadUser/load_user.dart';
import '../../../infrastructure/infrastructure.dart';
import '../../../presentation/presentation.dart';
import '../../../screens/pages/pages.dart';

HomePage makeHomePage(
    LocalStorageAdapter localStorageAdapter, FirebaseAuth firebaseAuth) =>
    HomePage(
      presenter: HomeUiController(
        deleteAccount: DeleteAccountData(
          storage: localStorageAdapter,
          remoteDeleteUser: FirebaseAuthAdapter(
            firebaseAuth: firebaseAuth,
          ),
        ),
        managerCurrentUser: LocalManagerCurrentUser(
          storage: localStorageAdapter,
        ),
        loadContacts: LocalLoadContacts(
          storage: localStorageAdapter,
        ),
      ),
    );