import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ViewsBloc/splashScreen/splash_screen.dart';

class BlocApp extends StatelessWidget {
  const BlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenBloc(),
    );
  }
}
