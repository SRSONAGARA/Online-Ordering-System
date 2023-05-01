import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/OrderHistoryScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/homeScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/auth_pagesGetx/LoginScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/onBoardingScreens/onBoarding1.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/onBoardingScreens/onBoardingMain.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/splashScreenGetX.dart';

class GetApp extends StatelessWidget {
  const GetApp({super.key});

  @override
  Widget build(BuildContext context) {
   return  GetMaterialApp(
     debugShowCheckedModeBanner: false,
     // home: SplashScreenGetX(),
     //  home: OnBoardingMain(),
      home: LoginScreenGetx(),
     getPages: [
       GetPage(name: '/homeScreenGetx', page: ()=>HomeScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/loginScreenGetx', page: ()=>LoginScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
       GetPage(name: '/orderHistoryScreenGetx', page: ()=>OrderHistoryScreenGetx(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

     ],
   );
  }
}