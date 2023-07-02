import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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
    await Future.delayed(const Duration(seconds: 1));
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
         Navigator.of(context)
             .pushReplacementNamed('/home-screen');
         return;
       }
         Navigator.of(context).pushReplacementNamed('/login-screen');
       return;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: Opacity1 ? 1:0,
                duration: const Duration(seconds: 2),
                child: const Image(
                  image: AssetImage('assets/SplashImage.jpg'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
