import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import '../../ControllersGetx/ApiConnection_Getx/AuthGetx.dart';
class OtpScreenGetx extends StatefulWidget {
  const OtpScreenGetx({Key? key}) : super(key: key);

  @override
  State<OtpScreenGetx> createState() => _OtpScreenGetxState();
}

class _OtpScreenGetxState extends State<OtpScreenGetx> {
  final authGetxController = Get.put(AuthGetxController());

  String verificationCode='';

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Obx(() => authGetxController.isLoading.value ? Center(child: CircularProgressIndicator(color: const Color.fromRGBO(86, 126, 239, 15)),):
      SingleChildScrollView(
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
            Text(
              'OTP Verification'.tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter the OTP sent to - '.tr,
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
                Text("Didn't Receive the OTP?".tr),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: ()async {
                      Get.rawSnackbar(
                          message:
                          'OTP resent successfully !'.tr,
                          backgroundColor:
                          const Color
                              .fromRGBO(
                              86,
                              126,
                              239,
                              10),
                          duration:
                          const Duration(seconds: 2));
                      await authGetxController.resendOtpGetx(userId: userId);
                    },
                    child:  Text(
                      'RESEND OTP'.tr,
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
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ])),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () async {
                    var result = await authGetxController.verifyOtpOnRegisterGetx(
                        userId: userId.toString(), otp:verificationCode.toString() );
                    print(jsonEncode(result));

                    if(result['status']==1){
                      Get.rawSnackbar(message: 'Account created successfully'.tr,backgroundColor:
                      Color.fromRGBO(86, 126, 239, 15),);
                      await Future.delayed(const Duration(seconds: 1));
                      await  Get.offNamedUntil('/loginScreenGetx', (route) => false);
                    }else{
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text('OTP is Invalid'.tr),
                          content: Text('Please insert correct OTP.'.tr),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text('Okey'.tr))
                          ],
                        );
                      });
                    }
                    authGetxController.isLoading.value = false;
                  },
                  child: Text('VERIFY & PROCEED'.tr)),
            ),
          ],
        ),
      ),)
    );
  }
}
