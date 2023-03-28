import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:oline_ordering_system/repository/AuthRepo.dart';
import 'package:oline_ordering_system/views/Login%20Screen.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  Widget CustomText = Text("Forgot Password");
  TextEditingController emailController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var size;
  var _isObscure;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    final favoriteProvider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Image(
                    height: size.height / 4,
                    width: size.width / 4,
                    image: AssetImage('assets/ForgotPswImage.png'),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Forgot Your Password?',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText("Please enter the email address you'd like \n  your password reset information sent to" ,maxLines: 2,),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock_outline),
                      labelText: 'Email address',
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email can't empty";
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(value!)) {
                        return "Enter Correct email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // TextFormField(
                  //   obscureText: true,
                  //   controller: newPassword,
                  //   decoration: InputDecoration(
                  //     icon: Icon(Icons.lock_outline),
                  //     labelText: 'New password',
                  //     hintText: 'Enter your new password',
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Password can't empty";
                  //     } else if (value.length < 6) {
                  //       return "Password is not less than 6 letter";
                  //     } else if (!RegExp(
                  //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                  //         .hasMatch(value)) {
                  //       return "Enter valid password";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // TextFormField(
                  //   obscureText: _isObscure,
                  //   controller: confirmPassword,
                  //   decoration: InputDecoration(
                  //       icon: Icon(Icons.lock_outline),
                  //       labelText: 'Confirm Password',
                  //       hintText: 'Re-Enter your Password',
                  //       suffixIcon: IconButton(
                  //           onPressed: () {
                  //             setState(() {
                  //               _isObscure = !_isObscure;
                  //             });
                  //           },
                  //           icon: Icon(_isObscure
                  //               ? Icons.visibility
                  //               : Icons.visibility_off))),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Confirm Password Can't empty";
                  //     } else if (value.length < 6) {
                  //       return "Password is not less than 6 letter";
                  //     } else if (!RegExp(
                  //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                  //         .hasMatch(value)) {
                  //       return "Enter valid password";
                  //     } else if (value != newPassword.text) {
                  //       return "Password not matched";
                  //     }
                  //   },
                  // ),
                  SizedBox(
                    height: 60,
                  ),
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
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            var result = await AuthRepo.forgotPassword(
                                emailId: emailController.text);
                            print(jsonEncode(result));

                            if (result['status'] == 1) {
                              String userId = result['data']['_id'];
                              print(userId);
                              await Future.delayed(Duration(seconds: 1));
                              await Navigator.pushNamed(
                                  context, '/forgotpswOtp-screen',
                                  arguments: {'id': userId.toString()});
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Email is not registered'),
                                      content: Text(
                                          'This Email Id is not Registered With us kindly register first!'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('okey'))
                                      ],
                                    );
                                  });
                            }
                            ;
                          }
                        },
                        child: Text('Send otp')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
