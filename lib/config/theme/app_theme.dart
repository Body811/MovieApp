import 'package:flutter/material.dart';
import 'package:movie_app/config/theme/app_colors.dart';
import 'package:movie_app/config/theme/app_fonts.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: AppFonts.poppins,
        appBarTheme: appBarTheme());
  }

  static AppBarTheme appBarTheme() {
    return const AppBarTheme(
        color: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black),
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontFamily: AppFonts.montserrat,
            color: AppColors.black,
            fontSize: 20,
            height: 24.38,
            fontWeight: FontWeight.w700));
  }
}
