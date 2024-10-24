

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class ErrorSnackBar{
  static void show(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 10),
        // padding: EdgeInsets.only(bottom: 50),
        content:AwesomeSnackbarContent(
          title: 'Oh Snap!',
          message: content,
          contentType: ContentType.failure,
          messageTextStyle: TextStyle(fontSize: 12),
        )
      ),
    );
  }
}
