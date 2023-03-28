import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:oline_ordering_system/repository/AuthRepo.dart';
import 'package:oline_ordering_system/views/Home%20Screen.dart';
import 'package:oline_ordering_system/views/Login%20Screen.dart';
class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtpScreen> createState() => _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  var size;
  String verificationCode='';
  // TextEditingController otpController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final argument = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    String userId=argument['id'];
    print('userId: ${userId}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image(
                  image: AssetImage('assets/Otpimage.png'),
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'OTP Verification',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter the OTP sent to - ',
                ),
                Icon(Icons.email_outlined),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.edit)),
              ],
            ),
            SizedBox(height: 20),
            Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OtpTextField(
                      numberOfFields: 4,
                      borderColor: const Color(0xFF512DA8),
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {
                        verificationCode = code;
                      },
                      onSubmit: (String code) {
                        verificationCode = code;
                        print(verificationCode);
                        // moveToHome(context);
                      }, // end onSubmit
                    )
                  ],
                )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't Receive the OTP?"),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: ()async {
                      var result1=await AuthRepo.resendOtp(userId: userId);
                    },
                    child: Text(
                      'RESEND OTP',
                      style: TextStyle(color: Colors.pinkAccent),
                    ))
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 37, 150, 190),
                    Colors.pinkAccent
                  ])),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () async {
                    var result = await AuthRepo.verifyOtpOnForgotPassword(
                        userId: userId.toString(), otp:verificationCode.toString() );
                    print(jsonEncode(result));

                    if(result['status']==1){
                      await Future.delayed(const Duration(seconds: 1));
                      await  Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false);
                    }else{
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text('OTP is Invalid'),
                          content: Text('Please insert correct OTP.'),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text('Okey'))
                          ],
                        );
                      });
                    }

                  },
                  child: Text('VERIFY & PROCEED')),
            ),
          ],
        ),
      ),
    );
  }
}
