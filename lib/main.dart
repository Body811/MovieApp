import 'package:flutter/material.dart';
import 'package:movie_app/config/strings/app_strings.dart';
import 'package:movie_app/config/theme/app_theme.dart';
import 'package:movie_app/features/auth/pages/authenticationPages/otp.dart';
import 'package:movie_app/features/details/presentation/pages/movie_details_screen.dart';

import 'features/details/domain/entities/movie_details_entity.dart';

void main() {
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
        home: const MovieDetailsScreen(movieId: 343611));
  }
}
