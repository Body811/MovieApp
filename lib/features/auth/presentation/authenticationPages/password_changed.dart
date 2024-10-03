import 'package:flutter/material.dart';
import '/features/auth/presentation/widgets/authentication_screen_button.dart';
import 'login.dart';


class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/backgrounds/Curled film stripes isolated white background.png'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icons/Successmark.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Password Changed!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10.0),
              Text(
                'Your password has been changed \nsuccessfully.',
                style: TextStyle(
                  fontSize:14.0,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AuthenticationScreenButton(
                text: 'Back to Login',
                onPress: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                },
              ),
              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}


