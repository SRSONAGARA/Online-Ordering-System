import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/ApiConnection/ApiConnection_Provider.dart';
import 'package:oline_ordering_system/views/AccountScreen.dart';
import 'package:oline_ordering_system/views/CartScreen.dart';
import 'package:oline_ordering_system/views/ForgotPasswordOtpScreen.dart';
import 'package:oline_ordering_system/views/ForgotPasswordScreen.dart';
import 'package:oline_ordering_system/views/Home%20Screen.dart';
import 'package:oline_ordering_system/views/Login%20Screen.dart';
import 'package:oline_ordering_system/views/OrderHistoryScreen.dart';
import 'package:oline_ordering_system/views/OtpScreen.dart';
import 'package:oline_ordering_system/views/ProductScreen.dart';
import 'package:oline_ordering_system/views/Registration%20Screen.dart';
import 'package:oline_ordering_system/views/ResetPswScreen.dart';
import 'package:oline_ordering_system/views/Splash%20Screen.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:oline_ordering_system/provider/placeOrder_provider.dart';
import 'package:oline_ordering_system/provider/search_provider.dart';
import 'package:provider/provider.dart';

import 'views/ProductDetailsScreen.dart';
import 'views/Welcome Screen.dart';
import 'views/WishlistScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>FavouriteProvider()),
      ChangeNotifierProvider(create: (_)=>CartProvider()),
      ChangeNotifierProvider(create: (_)=>PlaceOrderProvider()),
      ChangeNotifierProvider(create: (_)=>SearchProvider()),
      ChangeNotifierProvider(create: (_)=>ApiConnectionProvider())
    ],
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // home:Splash(),
      home: LoginScreen(),
      // home:RegistrationScreen() ,
      // home: ForgotPasswordScreen(),
      // home: HomeScreen(),
      // home: OtpScreen(),
      // home: AccountScreen(),
      routes: {
        '/welcome-screen':(context)=>WelcomeScreen(),
        '/login-screen':(context)=>LoginScreen(),
        '/forgotpsw-screen':(context)=>ForgotPasswordScreen(),
        '/forgotpswOtp-screen':(context)=>ForgotPasswordOtpScreen(),
        '/resetpsw-screen':(context)=>ResetPasswordScreen(),
        '/registration-screen':(context)=>RegistrationScreen(),
        '/otp-screen':(context)=>OtpScreen(),
        '/home-screen':(context)=>HomeScreen(),
        '/product-screen':(context)=>ProductScreen(),
        '/productDetails-screen':(context)=>ProductDetailsScreen(),
        '/wishlist-screen':(context)=>WishlistScreen(),
        '/cart-screen':(context)=>CartScreen(),
        '/orderhistory-screen':(context)=>OrderHistoryScreen(),
        '/account-screen':(context)=>AccountScreen(),

      },
    ));
  }
}
