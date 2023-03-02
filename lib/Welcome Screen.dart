import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text('Hello There!',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 30),),
              SizedBox(height: 10,),
              Text('Automatic identity verification which enable you to verify your identity'),
              Container(
                  height: size.height / 2,
                  width: size.width / 2,
                  child: Image(image: AssetImage('assets/WelcomeImage.png'))),
              // InkWell(onTap: (){}, child: Text('Log In'),),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login-screen');
                  },
                  child: Text('Login')),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style:ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration-screen');
                  },
                  child: Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
