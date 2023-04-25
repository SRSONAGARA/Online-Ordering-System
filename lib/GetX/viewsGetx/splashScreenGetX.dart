import 'package:flutter/material.dart';

class SplashScreenGetX extends StatefulWidget {
  const SplashScreenGetX({Key? key}) : super(key: key);

  @override
  State<SplashScreenGetX> createState() => _SplashScreenGetXState();
}

class _SplashScreenGetXState extends State<SplashScreenGetX> {
  bool Opacity1 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _opacity();
  }

  _opacity() async {
    Future.delayed(Duration(seconds: 2));
    setState(() {
      Opacity1 = !Opacity1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: AnimatedOpacity(
              opacity: Opacity1 ? 1 : 0,
              duration: Duration(seconds: 5),
              child: Image(image: AssetImage('assets/SplashImage.jpg'))),
        ),
      ),
    );
  }
}
