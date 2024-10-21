import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/features/auth/data/repository/login_repository_impl.dart';
import 'package:movie_app/features/auth/domain/entities/user_entity.dart';
import 'package:movie_app/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:movie_app/features/auth/presentation/authenticationPages/register.dart';
import 'package:movie_app/utils/error_snack_bar.dart';
import 'package:movie_app/utils/validation_utils.dart';
import '../../../../utils/success_snack_bar.dart';
import '../../domain/Params/login_user_params.dart';
import '../widgets/authentication_screen_button.dart';
import '../widgets/input_field.dart';
import '../widgets/password_input_field.dart';
import '../widgets/welcome_text.dart';
import 'forgot_password.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {

      final String email = _emailController.text;
      final String password = _passwordController.text;

      final loginUserUsecase = LoginUserUsecase(
        repository: LoginRepositoryImpl(
          firebaseAuth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance,
        ),
      );
      try{
        await loginUserUsecase.call(
          params: LoginUserParams(
            email: email,
            password: password,
          )
      );
         Navigator.pushReplacementNamed(context, "/main");
         // Navigator.pushReplacementNamed(context, "/profile");

      }on FirebaseAuthException catch(e){
        ErrorSnackBar.show(context,'Error ${e.message}.');
      }catch(e){
        ErrorSnackBar.show(context, 'An unexpected error occurred.');
      }
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/backgrounds/Film elements on white background with copy space.png'),
          fit: BoxFit.fitWidth,
          alignment: Alignment.bottomCenter,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 35),
                const WelcomeText(text: "Welcome back! Glad \nto see you, Again!"),
                const SizedBox(height: 25),
                InputField(
                  hintText: "Enter Your Email",
                  controller: _emailController,
                  icon: Icons.email,
                  validator: ValidationUtils.validateEmail,
                ),
                const SizedBox(height: 20),
                PasswordInputField(
                  text: "Enter your Password",
                  controller: _passwordController,
                  validator: ValidationUtils.validatePassword,
                ),
                const SizedBox(height: 3),
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                          },
                        child: const Text("Forgot Password?",
                            style: TextStyle(color:
                            Color(0xFF67686D)
                            )
                        )
                    )
                ),
                const SizedBox(height: 15),
                AuthenticationScreenButton(
                    text: "Login",
                    onPress: () {
                      FocusScope.of(context).unfocus();
                      _login();
                    }
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E232C)
                        )
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                          },
                        child: const Text(" Register Now",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF35C2C1)
                            )
                        )
                    )
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
