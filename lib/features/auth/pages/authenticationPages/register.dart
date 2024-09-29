
import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/utils/authentication_utils.dart';


class Register extends StatelessWidget {
   Register ({super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthenticationAppbar.getAppbar(context: context,backgroundColor: const Color(0xFFFBFBFB)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Curled_film_stripes_isolated_white_background.png'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 35),
                WelcomeText.getText(text: "Hello! Register to get \nStarted"),
                const SizedBox(height: 25),
                InputField.getInputField(
                  hintText: "Enter Your Username",
                  controller: _userNameController,
                  icon: Icons.account_circle,
                ),
                const SizedBox(height: 10),
                InputField.getInputField(
                  hintText: "Enter Your Email",
                  controller: _emailController,
                  icon: Icons.email,
                ),
                const SizedBox(height: 10),
                PasswordInputField(text: "Enter your Password", controller: _passwordController),
                const SizedBox(height: 10),
                PasswordInputField(text: "Confirm password", controller: _confirmPasswordController),
                const SizedBox(height: 15),
                AuthenticationScreenButton.getButton(text: "Register", onPress: (){}),
                const SizedBox(height:5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account", style: TextStyle(fontSize: 15, fontWeight:FontWeight.w600, color: Color(0xFF1E232C))),
                    InkWell(
                        onTap:(){Navigator.pop(context);},
                        child: const Text(" login Now",style: TextStyle(fontSize: 15, fontWeight:FontWeight.w600 ,color: Color(0xFF35C2C1))))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

