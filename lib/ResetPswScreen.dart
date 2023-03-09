import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 300,
                    width: 400,
                    child:Image(image: AssetImage('assets/ResetPswImage.jpeg'),)
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Current Password',
                      hintText: 'Enter your Current Password'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter New Password'),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Re-Enter your New Password'),
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
                      onPressed: (){},child:Text('Save the Password') ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
