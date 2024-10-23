import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const Navbar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.white);
          }
          return const IconThemeData(color: AppColors.slateGray);
        }),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap, // Pass the onTap callback
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          const NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          const NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
          const NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Favorites'),
        ],
        backgroundColor: AppColors.black,
      ),
    );
  }
}
