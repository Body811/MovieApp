


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

  class WelcomeText{
  static Widget getText({required String text}){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
        style: GoogleFonts.urbanist(
          textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700,),
        ), // GoogleFonts
      ),
    );
  }
}


class InputField{
  static Widget getInputField({
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color:Color(0xFF67686D), fontSize: 15),
        filled: true,
        fillColor: const Color(0xFFE8ECF4),
        prefixIcon: Icon(icon),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE3E7EF), width: 2.0),
            borderRadius: BorderRadius.circular(8)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE3E7EF), width: 5.0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class AuthenticationScreenButton{
  static Widget getButton({required String text, required Function onPress}){
    return SizedBox(
      width: 900,
      height: 65,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E232C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          onPressed: () => onPress,
          child: Text(text,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),)
      ),
    );
  }
}

class AuthenticationAppbar{
    static AppBar getAppbar({required BuildContext context}){
      return AppBar(
        backgroundColor:  const Color(0xFFFBFBFB),
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:BoxDecoration(
                color: const Color(0xFFFBFBFB),
                borderRadius: BorderRadius.circular(12),
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(2, 2),
                    blurRadius: 3,
                  ),
                ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 20,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      );
    }
}


class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const PasswordInputField({super.key, required this.controller, required this.text});

  @override
  State<PasswordInputField> createState() => PasswordInputFieldState();
}

class PasswordInputFieldState extends State<PasswordInputField> {

  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: widget.controller,
      cursorColor: Colors.black,
      obscureText: _isObscureText,
      decoration: InputDecoration(
        hintText: widget.text,
        hintStyle: const TextStyle(color:Color(0xFF67686D), fontSize: 15),
        filled: true,
        fillColor: const Color(0xD0E8ECF4),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_isObscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _isObscureText = !_isObscureText;
            });
          },
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE3E7EF), width: 2.0),
            borderRadius: BorderRadius.circular(8)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE3E7EF), width: 5.0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}


