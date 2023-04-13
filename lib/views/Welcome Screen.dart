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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text('Hello There!',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 30),),
              const SizedBox(height: 10,),
              const Text('Automatic identity verification which enable you to verify your identity'),
              SizedBox(
                  height: size.height / 2,
                  width: size.width / 2,
                  child: const Image(image: AssetImage('assets/WelcomeImage.png'))),
              // InkWell(onTap: (){}, child: Text('Log In'),),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login-screen');
                  },
                  child: const Text('Login')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style:ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration-screen');
                  },
                  child: const Text('Sign Up')),
            ],
          ),
        ),
      ),
    );
  }
}
