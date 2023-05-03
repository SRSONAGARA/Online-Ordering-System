import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/AccountScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/CartScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/OrderHistoryScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/ProductScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/WishlistScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/homeScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/ChangePswScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/ForgotPswOtpScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/ForgotPswScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/LoginScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/OtpScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/RegistrationScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/splashScreenGetX.dart';


class GetApp extends StatelessWidget {
  const GetApp({super.key});

  @override
  Widget build(BuildContext context) {
   return  GetMaterialApp(
     debugShowCheckedModeBanner: false,
     home: SplashScreenGetX(),
     //  home: OnBoardingMain(),
     //  home: LoginScreenGetx(),
     getPages: [
       GetPage(name: '/loginScreenGetx', page: ()=>LoginScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/registrationScreenGetx', page: ()=>RegistrationScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/otpScreenGetx', page: ()=>OtpScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/forgotPswScreenGetx', page: ()=>ForgotPswScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/forgotPswOtpScreenGetx', page: ()=>ForgotPswOtpScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/changePswScreenGetx', page: ()=>ChangePswScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/homeScreenGetx', page: ()=>HomeScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/productScreenGetx', page: ()=>ProductScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/wishlistScreenGetx', page: ()=>WishlistScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/cartScreenGetx', page: ()=>CartScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/orderHistoryScreenGetx', page: ()=>OrderHistoryScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/accountScreenGetx', page: ()=>AccountScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

     ],
   );
  }
}