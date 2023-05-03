import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../../ControllersGetx/ApiConnection_Getx/AuthGetx.dart';
class ForgotPswOtpScreenGetx extends StatefulWidget {
  const ForgotPswOtpScreenGetx({Key? key}) : super(key: key);

  @override
  State<ForgotPswOtpScreenGetx> createState() => _ForgotPswOtpScreenGetxState();
}

class _ForgotPswOtpScreenGetxState extends State<ForgotPswOtpScreenGetx> {
  final authGetxController = Get.put(AuthGetxController());

  String verificationCode='';

  @override
  Widget build(BuildContext context) {
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
                      Get.back();
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
                      var result1=await authGetxController.resendOtpGetx(userId: userId);
                    },
                    child: const Text(
                      'RESEND OTP',
                      style: TextStyle(color: Colors.pinkAccent),
                    ))
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ])),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () async {
                    var result = await authGetxController.verifyOtpOnForgotPasswordGetx(
                        userId: userId.toString(), otp:verificationCode.toString() );
                    print(jsonEncode(result));

                    if(result['status']==1){
                      await Future.delayed(const Duration(seconds: 1));
                      await Get.offNamedUntil('/loginScreenGetx', (route) => false);
                    }else{
                      Get.dialog(
                         AlertDialog(
                          title: Text('OTP is Invalid'),
                          content: Text('Please insert correct OTP.'),
                          actions: [
                            TextButton(onPressed: (){
                              Get.back();
                            }, child: Text('Okey'))
                          ],
                        )
                      );
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
