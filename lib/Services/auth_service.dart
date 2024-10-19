import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
    });
  }

  User? _user;

  // getter to get the user
  User? get user => _user;

  // login with the credentials
  Future<String?> LoginUser(LoginData data) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data.name, password: data.password);
      _user = userCredential.user;

      // Check if the email is verified
      if (_user != null && !_user!.emailVerified) {
        await FirebaseAuth.instance.signOut();
        return 'Email is not verified. Please verify your email.';
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // signup with the credentials
  Future<String?> SignupUser(SignupData data) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data.name!, password: data.password!);
      _user = userCredential.user;

      // Send email verification
      if (_user != null && !_user!.emailVerified) {
        await _user!.sendEmailVerification();
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // recover password
  Future<String?> recoverPassword(String name) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: name);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // signout
  Future<void> SignoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      _user = null;
    } catch (e) {
      print(e.toString());
    }
  }
}
