import 'package:flutter/material.dart';

import '../../../../config/strings/app_strings.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_fonts.dart';

class DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double screenWidth;
  final double screenHeight;

  const DetailsAppBar({super.key, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: const Text(AppStrings.detailsTitle),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w700,
        fontSize: screenWidth * 0.05,
        fontFamily: AppFonts.montserrat,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.1);
}
