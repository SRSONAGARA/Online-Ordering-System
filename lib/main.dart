import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/AccountScreen.dart';
import 'package:oline_ordering_system/CartScreen.dart';
import 'package:oline_ordering_system/Home%20Screen.dart';
import 'package:oline_ordering_system/Login%20Screen.dart';
import 'package:oline_ordering_system/OrderHistoryScreen.dart';
import 'package:oline_ordering_system/OtpScreen.dart';
import 'package:oline_ordering_system/ProductScreen.dart';
import 'package:oline_ordering_system/Registration%20Screen.dart';
import 'package:oline_ordering_system/ResetPswScreen.dart';
import 'package:oline_ordering_system/Splash%20Screen.dart';

import 'Welcome Screen.dart';
import 'WishlistScreen.dart';

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
      home:Splash(),
      // home: LoginScreen(),
      // home: HomeScreen(),
      // home: AccountScreen(),
      routes: {
        '/welcome-screen':(context)=>WelcomeScreen(),
        '/login-screen':(context)=>LoginScreen(),
        '/resetpsw-screen':(context)=>ResetPasswordScreen(),
        '/registration-screen':(context)=>RegistrationScreen(),
        '/otp-screen':(context)=>OtpScreen(),
        '/home-screen':(context)=>HomeScreen(),
        '/product-screen':(context)=>ProductScreen(),
        '/wishlist-screen':(context)=>WishlistScreen(),
        '/cart-screen':(context)=>CartScreen(),
        '/orderhistory-screen':(context)=>OrderHistoryScreen(),
        '/account-screen':(context)=>AccountScreen(),

      },
    );
  }
}
