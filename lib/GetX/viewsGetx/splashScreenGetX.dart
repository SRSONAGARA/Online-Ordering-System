import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
class SplashScreenGetX extends StatefulWidget {
  const SplashScreenGetX({Key? key}) : super(key: key);

  @override
  State<SplashScreenGetX> createState() => _SplashScreenGetXState();
}

class _SplashScreenGetXState extends State<SplashScreenGetX> {
  bool Opacity1 = true;
  bool? logInBool;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _opacity();
    isLogIn();
  }
  _opacity() async {
    Future.delayed(Duration(seconds: 2));
    setState(() {
      Opacity1 = !Opacity1;
    });
  }
  isLogIn() async {
    final preferences = await SharedPreferences.getInstance();
    logInBool = preferences.getBool('loginBool');

    print(preferences.getBool('loginBool'));
    await Future.delayed(const Duration(seconds: 2), () {
      if (logInBool != null && logInBool == true) {
        Get.offNamed('/homeScreenGetx');
        return;
      }
      Get.offNamed('/loginScreenGetx');
      return;

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/SplashImage.jpg')
              /*AnimatedOpacity(
                  opacity: Opacity1 ? 2 : 0,
                  duration: Duration(seconds: 1),
                  child: Image(image: AssetImage('assets/SplashImage.jpg'))*/),
            ],
          ),
        ),
      ),
    );
  }
}
