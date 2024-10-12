import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkInternetConnection(); // Check for connectivity
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    // Check if there is no internet
    if (connectivityResult == ConnectivityResult.none) {
      // Navigate to No Internet page if no connection
      Navigator.pushReplacementNamed(context, '/noInternet');
    } else {
      _checkLoginStatus(); // Continue with login status check
    }
  }

  Future<void> _checkLoginStatus() async {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    //
    // Timer(Duration(seconds: 3), () {
    //   if (isLoggedIn) {
    //     Navigator.pushReplacementNamed(context, '/main'); // Go to Home if logged in
    //   } else {
    //     Navigator.pushReplacementNamed(context, '/login'); // Go to Login if not logged in
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/SplashScreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/popcorn.png', height: 200, width: 200),
              const SizedBox(height: 20),
              const CircularProgressIndicator(color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
