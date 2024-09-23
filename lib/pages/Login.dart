
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
   Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration:  const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Film_elements_on_white_background_with_copy_space.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
          )
        ),
        child:  Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 35),
              _WelcomeText.getText(),
              const SizedBox(height: 25),
              _InputField.getInputField(
                hintText: "Enter Your Email",
                controller: _emailController,
                icon: Icons.email,
              ),

              const SizedBox(height: 20),
              _PasswordInputField(controller: _passwordController),
               const SizedBox(height: 3),
               Align(
                alignment:Alignment.topRight,
                child: InkWell(onTap:() {} , child: const Text("Forgot Password?",style: TextStyle(color: Color(0xFF67686D))))
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: 900,
                height: 65,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E232C),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    onPressed: (){},
                    child: const Text("Login",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),)
                ),
              ),
              const SizedBox(height:5),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?", style: TextStyle(fontSize: 15, fontWeight:FontWeight.w600, color: Color(0xFF1E232C))),
                  InkWell(
                      onTap:(){},
                      child: const Text(" Register Now",style: TextStyle(fontSize: 15, fontWeight:FontWeight.w600 ,color: Color(0xFF35C2C1))))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _WelcomeText{
 static Widget getText(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Welcome back! Glad \nto see you, Again!",
        style: GoogleFonts.urbanist(
          textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700,),
        ), // GoogleFonts
      ),
    );
  }
}


class _InputField{
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

class _PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  const _PasswordInputField({required this.controller});

  @override
  State<_PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<_PasswordInputField> {

  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: widget.controller,
      cursorColor: Colors.black,
      obscureText: _isObscureText,
      decoration: InputDecoration(
        hintText: "Enter your Password",
        hintStyle: const TextStyle(color:Color(0xFF67686D), fontSize: 15),
        filled: true,
        fillColor: const Color(0xFFE8ECF4),
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
