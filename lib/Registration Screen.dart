import 'package:flutter/material.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 200,
                width: 200,
                child:Image(image: AssetImage('assets/LoginImage.png'),)
            ),
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter your Username'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  hintText: 'Enter your E-mail'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your Password'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  hintText: 'Re-Enter your Password'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 37, 150, 190), Colors.pinkAccent])
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: (){
                    Navigator.pushNamed(context, '/home-screen');
                  },child:Text('Sign Up') ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Have an Account?"),
                SizedBox(width: 10,),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/login-screen');
                }, child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
