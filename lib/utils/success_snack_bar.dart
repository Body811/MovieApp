


import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SuccessSnackBar {
  static void show(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: const Duration(seconds: 10),
          content:AwesomeSnackbarContent(
            title: 'Nice!',
            message: content,
            contentType: ContentType.success,
          )
      ),
    );
  }
}