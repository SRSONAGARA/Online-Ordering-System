import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/Home%20Screen.dart';
import 'package:oline_ordering_system/Login%20Screen.dart';
import 'package:oline_ordering_system/ProductScreen.dart';
import 'package:oline_ordering_system/Registration%20Screen.dart';
import 'package:oline_ordering_system/Splash%20Screen.dart';

import 'Welcome Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:Splash(),
      home: HomeScreen(),
      routes: {
        '/welcome-screen':(context)=>WelcomeScreen(),
        '/login-screen':(context)=>LoginScreen(),
        '/registration-screen':(context)=>RegistrationScreen(),
        '/home-screen':(context)=>HomeScreen(),
        '/product-screen':(context)=>ProductScreen(),

      },
    );
  }
}
