import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/pages/authenticationPages/forgot_password.dart';
import 'package:movie_app/pages/authenticationPages/login.dart';
import 'package:movie_app/pages/authenticationPages/otp.dart';
import 'package:movie_app/pages/authenticationPages/register.dart';


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
      theme: ThemeData(
        textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme)
      ),
      title: 'Movie App',
      // home: Login(),
      // home: Register()
      // home: ForgotPassword()
      // home: CreateNewPassword()
      home: const Otp()

    );
  }
}

