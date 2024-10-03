import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/presentation/authenticationPages/password_changed.dart';
import 'package:movie_app/firebase_options.dart';
import 'config/strings/app_strings.dart';
import 'config/theme/app_theme.dart';
import 'features/auth/presentation/authenticationPages/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        title: AppStrings.appTitle,
        // home: const MovieDetailsScreen(movieId: 343611)
        // home: const PasswordChanged()
        home: Login()

    );
  }
}
