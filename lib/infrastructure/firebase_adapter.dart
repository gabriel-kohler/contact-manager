import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_test/core/core.dart';

class FirebaseAuthAdapter implements RemoteSignUp {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthAdapter({required this.firebaseAuth});

  @override
  Future<void> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('credential > ${credential.user?.email}');
    } catch (error) {
      print('error $error');
    }

  }
}
