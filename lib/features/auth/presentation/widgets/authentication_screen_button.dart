import 'package:flutter/material.dart';


class AuthenticationScreenButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const AuthenticationScreenButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 900,
      height: 65,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E232C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPress,
        child: Text(text,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600,),
        ),
      ),
    );
  }
}