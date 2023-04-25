import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/onBoardingScreens/onBoarding1.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/onBoardingScreens/onBoardingMain.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/splashScreenGetX.dart';

class GetApp extends StatelessWidget {
  const GetApp({super.key});

  @override
  Widget build(BuildContext context) {
   return const GetMaterialApp(
     debugShowCheckedModeBanner: false,
     // home: SplashScreenGetX(),
      home: OnBoardingMain(),
   );
  }
}