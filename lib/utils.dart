import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'Services/alert_service.dart';
import 'Services/auth_service.dart';
import 'firebase_options.dart';

/// Function to initialize Firebase
Future<void> setUpFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

/// Function to register services with GetIt
void registerServices() {
  final GetIt getIt = GetIt.instance;
  // Register services here
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<AlertService>(AlertService());
}
