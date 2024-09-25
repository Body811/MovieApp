import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/config/strings/app_strings.dart';
import 'package:movie_app/config/theme/app_theme.dart';
import 'package:movie_app/features/auth/pages/authenticationPages/otp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
      title: AppStrings.AppTitle,
      home: const Otp()

    );
  }
}

