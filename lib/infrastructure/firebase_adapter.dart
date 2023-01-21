import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_test/core/core.dart';

class FirebaseAuthAdapter implements SignUpApi, SignInApi {
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

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('credential > ${credential.user?.email}');
    } on FirebaseAuthException catch (error) {
      _handleFirebaseError(error.code);
    }
    catch (error) {
      print('error > $error');
    }
  }

  void _handleFirebaseError(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        throw SignInApiError.userNotFound;
      case 'wrong-password':
        throw SignInApiError.wrongPassword;
      default:
        throw SignInApiError.unexpected;
    }
  }
}
