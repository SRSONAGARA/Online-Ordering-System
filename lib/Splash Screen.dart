import 'package:flutter/material.dart';

import 'Login Screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
   bool Opacity1 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
    _opacity();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  _opacity() async {
    await Future.delayed(Duration(seconds: 2));
   setState(() {
     Opacity1 = !Opacity1;
   });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: Opacity1 ? 1:0,
                duration: Duration(seconds: 1),
                child: Image(
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
