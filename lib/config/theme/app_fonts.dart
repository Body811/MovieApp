import 'package:flutter/cupertino.dart';

import 'app_colors.dart';

class AppFonts {
  static const montserrat = 'Montserrat';
  static const poppins = 'Poppins';

  static const header1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontFamily: montserrat,
    fontSize: 20,
    color: AppColors.black
  );

  static const header3 = TextStyle(
      fontWeight: FontWeight.w600,
      fontFamily: montserrat,
      fontSize: 12,
      color: AppColors.orange
  );

  static const header2 = TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: montserrat,
      fontSize: 12,
      color: AppColors.slateGray
  );

  static const body1 = TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: poppins,
    fontSize: 18,
    color: AppColors.black
  );

  static const body2 = TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: poppins,
      fontSize: 14,
      color: AppColors.black
  );

  static const body3 = TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: poppins,
      fontSize: 14,
      color: AppColors.black
  );

  static const body4 = TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: poppins,
      fontSize: 12,
      color: AppColors.black
  );

  static const body5 = TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: poppins,
      fontSize: 12,
      color: AppColors.black
  );
}
