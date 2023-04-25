import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:oline_ordering_system/provider/ApiConnection/AuthRepo.dart';
import 'package:oline_ordering_system/views/AuthViews/Login%20Screen.dart';
class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var size;
  String verificationCode='';

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final userId = ModalRoute.of(context)!.settings.arguments as String;
    print('userId: ${userId}');
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Authentication'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            const SizedBox(
                height: 200,
                width: 200,
                child: Image(
                  image: AssetImage('assets/Otpimage.png'),
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'OTP Verification',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter the OTP sent to - ',
                ),
                const Icon(Icons.email_outlined),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.edit)),
              ],
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't Receive the OTP?"),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: ()async {
                     await AuthRepo.resendOtp(userId: userId);
                    },
                    child: const Text(
                      'RESEND OTP',
                      style: TextStyle(color: Colors.pinkAccent),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 30,
              decoration: const BoxDecoration(
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
                    var result = await AuthRepo.verifyOtpOnRegister(
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
                  child: const Text('VERIFY & PROCEED')),
            ),
          ],
        ),
      ),
    );
  }
}
