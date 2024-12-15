import 'package:flutter/material.dart';
import 'package:mock_api_practice/feature/home/presentation/pages/home.dart';
import 'package:mock_api_practice/feature/login/presentation/pages/login_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

   const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    moveTo();
    super.initState();
  }

 Future<void> moveTo() async {
   var prefs = await SharedPreferences.getInstance();



  await Future.delayed(const Duration(seconds: 3), () {
     if(mounted) {
       if (prefs.containsKey("token")) {
         print("logged in");
         Navigator.pushReplacement(context,
             MaterialPageRoute(builder: (context) => const HomeScreen()));
       } else {
         Navigator.pushReplacement(context,
             MaterialPageRoute(builder: (context) => const LoginScreen()));
       }
     }
   });
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Customize your splash screen color
      body: Center(
        child: Text(
          'EveryThing Shop',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}