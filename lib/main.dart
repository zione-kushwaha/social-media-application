import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'Services/auth_service.dart';
import 'screens/auth_screen.dart';
import 'screens/main_view.dart';
import 'utils.dart';

Future<void> main() async {
  await setup();
  runApp(MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpFirebase();
  registerServices();
}

class MyApp extends StatelessWidget {
  final GetIt _geitit = GetIt.instance;
  late AuthService _authService;
  MyApp({super.key}) {
    _authService = _geitit.get<AuthService>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _authService.user == null
                ? CreateRoute(const AuthScreen())
                : CreateRoute(const MyhomePage());
          case '/home':
            return CreateRoute(const MyhomePage());
        }
        return null;
      },
    );
  }
}

PageRouteBuilder CreateRoute(Widget destination) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return destination;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
