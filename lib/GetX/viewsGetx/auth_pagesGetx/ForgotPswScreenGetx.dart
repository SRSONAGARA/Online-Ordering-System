import 'dart:convert';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../ControllersGetx/ApiConnection_Getx/AuthGetx.dart';

class ForgotPswScreenGetx extends StatefulWidget {
  const ForgotPswScreenGetx({Key? key}) : super(key: key);

  @override
  State<ForgotPswScreenGetx> createState() => _ForgotPswScreenGetxState();
}

class _ForgotPswScreenGetxState extends State<ForgotPswScreenGetx> {
  final authGetxController = Get.put(AuthGetxController());

  final formKey = GlobalKey<FormState>();

  Widget CustomText = Text("Forgot Password".tr);
  TextEditingController emailController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => authGetxController.isLoading.value
        ?  Container(
      decoration: BoxDecoration(color: Colors.white),
      height: Get.height/1.3,
      child: const Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(86, 126, 239, 10),
          )),
    )
        :  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
        title: CustomText,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.black,
                  size: 18,
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image(
                    height: 200,
                    width: 200,
                    image: const AssetImage('assets/imagesGetx/forgetPswImgGetx.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot your Password?'.tr,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Please enter the email address you'd like \n  your password reset information sent to".tr,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration:  InputDecoration(
                      icon: Icon(Icons.lock_outline),
                      labelText: 'Email Address'.tr,
                      hintText: 'Enter your Email'.tr,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email can't empty".tr;
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(value!)) {
                        return "Enter Correct email".tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
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
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            var result =
                            await authGetxController.forgotPasswordGetx(
                                emailId: emailController.text);
                            // print(jsonEncode(result));

                            if (result['status'] == 1) {
                              String userId = result['data']['_id'];
                              print(userId);
                              // await Future.delayed(const Duration(seconds: 1));
                              authGetxController.isLoading.value = false;
                              await Get.toNamed('/forgotPswOtpScreenGetx',
                                  arguments: {'id': userId.toString()});
                            } else {
                              authGetxController.isLoading.value = false;
                              Get.dialog(AlertDialog(
                                title: Text('Email is not registered'.tr),
                                content: Text(
                                    'This Email Id is not Registered With us kindly register first!'.tr),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('okey'.tr))
                                ],
                              ));
                            }
                            ;
                          }
                        },
                        child: Text('Send otp'.tr)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
