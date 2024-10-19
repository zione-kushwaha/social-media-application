import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get_it/get_it.dart';
import 'package:learning3/Services/alert_service.dart';
import '../Services/auth_service.dart';
import 'main_view.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GetIt getIt = GetIt.instance;
  late AuthService _authService;
  late AlertService _alertService;
  late String checkFlag;

  @override
  void initState() {
    super.initState();
    _authService = getIt.get<AuthService>();
    _alertService = getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      resizeToAvoidBottomInset:
          false, // Prevent resizing when the keyboard appears
      body: FlutterLogin(
        onLogin: (LoginData data) async {
          // Add custom logic for sign-in
          final result = await _authService.LoginUser(data);
          if (result == null) {
            checkFlag = 'login';
          }
          return result;
        },
        onSignup: (SignupData data) async {
          final result = await _authService.SignupUser(data);
          if (result == null) {
            checkFlag = 'signup';
          }
          return result;
        },
        onRecoverPassword: (String data) {
          final result = _authService.recoverPassword(data);
          return result;
        },
        onSubmitAnimationCompleted: () {
          switch (checkFlag) {
            case 'login':
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MyhomePage()));
              _alertService.showToast(
                  message: 'Login Successful', context: context);
              break;
            case 'signup':
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()));
              _alertService.showToast(
                  message: 'Signup Successful Please Verify Your Email',
                  context: context);
              break;
          }
        },
        messages: LoginMessages(
          userHint: 'Email',
          passwordHint: 'Password',
          confirmPasswordHint: 'Confirm Password',
          loginButton: 'LOG IN',
          signupButton: 'REGISTER',
          forgotPasswordButton: 'Forgot Password',
          recoverPasswordButton: 'SEND',
          goBackButton: 'GO BACK',
          confirmPasswordError: 'Passwords do not match!',
          recoverPasswordIntro: 'Don\'t feel bad. Happens to the best of us.',
          recoverPasswordDescription:
              'Enter your email and we will send you a link to reset your password.',
          recoverPasswordSuccess: 'Password rescued successfully',
        ),
        theme: LoginTheme(
          primaryColor: Colors.deepPurpleAccent,
          titleStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
