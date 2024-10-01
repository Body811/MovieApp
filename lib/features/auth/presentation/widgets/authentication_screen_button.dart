import 'package:flutter/material.dart';


class AuthenticationScreenButton {
  static Widget getButton({required String text, required Function onPress}) {
    return SizedBox(
      width: 900,
      height: 65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E232C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () => onPress,
          child: Text(
            text,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          )),
    );
  }
}