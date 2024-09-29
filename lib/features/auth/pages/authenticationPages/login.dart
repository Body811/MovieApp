
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/pages/authenticationPages/forgot_password.dart';
import 'package:movie_app/features/auth/utils/authentication_utils.dart';
import 'package:movie_app/features/auth/pages/authenticationPages/register.dart';


class Login extends StatelessWidget {
   Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.white,),
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
              WelcomeText.getText(text: "Welcome back! Glad \nto see you, Again!"),
              const SizedBox(height: 25),
              InputField.getInputField(
                hintText: "Enter Your Email",
                controller: _emailController,
                icon: Icons.email,
              ),

              const SizedBox(height: 20),
              PasswordInputField(text: "Enter your Password", controller: _passwordController),
               const SizedBox(height: 3),
               Align(
                alignment:Alignment.topRight,
                child: InkWell(
                    onTap:() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                    },
                    child: const Text("Forgot Password?",style: TextStyle(color: Color(0xFF67686D))))
              ),
              const SizedBox(height: 15),
              AuthenticationScreenButton.getButton(text: "Login", onPress: (){}),
              const SizedBox(height:5),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?", style: TextStyle(fontSize: 15, fontWeight:FontWeight.w600, color: Color(0xFF1E232C))),
                  InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Register()));
                      },
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

