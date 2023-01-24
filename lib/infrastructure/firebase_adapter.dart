import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_test/core/core.dart';

class FirebaseAuthAdapter implements SignUpCore, SignInCore, RemoteDeleteUser {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthAdapter({required this.firebaseAuth});

  @override
  Future<Map<String, dynamic>> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = {
        'id': credential.user?.uid,
        'email': credential.user?.email,
      };
      return user;
    } catch (error) {
      print('error $error');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = {
        'id': credential.user?.uid,
        'email': credential.user?.email,
      };
      print('credential > ${credential.user?.email}');
      return user;
    } on FirebaseAuthException catch (error) {
      throw _handleFirebaseError(error.code);

    }
    catch (error) {
      print('error > $error');
      rethrow;
    }
  }

  SignInCoreError _handleFirebaseError(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return SignInCoreError.userNotFound;
      case 'wrong-password':
        return SignInCoreError.wrongPassword;
      default:
        return SignInCoreError.unexpected;
    }
  }

  @override
  Future<void> deleteUser(String password) async {
    try {
      final currentUser = firebaseAuth.currentUser;
      await signIn(currentUser?.email ?? "", password);
      await currentUser?.delete();
    } catch (error) {
      print('error > $error');
      rethrow;
    }
  }
}
