import 'package:flutter/material.dart';



class AuthenticationAppbar {
  static AppBar getAppbar(
      {required BuildContext context, required Color backgroundColor}) {
    return AppBar(
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(2, 2),
                blurRadius: 3,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}