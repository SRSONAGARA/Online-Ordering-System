import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../ControllersGetx/ApiConnection_Getx/AuthGetx.dart';

class RegistrationScreenGetx extends StatefulWidget {
  const RegistrationScreenGetx({Key? key}) : super(key: key);

  @override
  State<RegistrationScreenGetx> createState() => _RegistrationScreenGetxState();
}

class _RegistrationScreenGetxState extends State<RegistrationScreenGetx> {
  final authGetxController = Get.put(AuthGetxController());
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var _isObscure;
  final formKey = GlobalKey<FormState>();

  /* void accessApi(BuildContext context) async {
    final authRepoProvider = Provider.of<AuthRepo>(context,listen: false);
    authRepoProvider.isLoading = false;

  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // accessApi(context);
    _isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => authGetxController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                    color: const Color.fromRGBO(86, 126, 239, 15)))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/imagesGetx/loginImgGetx/background.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(
                                "REGISTER NOW!".tr,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Welcome".tr,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                )
                              ],
                            ),
                            TextFormField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person_outline),
                                  labelText: 'Username'.tr,
                                  hintText: 'Enter your Name'.tr),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username can't empty".tr;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.email_outlined),
                                  labelText: 'E-mail'.tr,
                                  hintText: 'Enter your E-mail'.tr),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't empty".tr;
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                    .hasMatch(value!)) {
                                  return "Enter Correct email".tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(10),
                              ],
                              controller: mobileNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.phone_outlined),
                                  labelText: 'Mobile No'.tr,
                                  hintText: 'Enter your mobile no.'.tr),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Mobile No can't empty".tr;
                                } else if (value.length < 10) {
                                  return "Mobile No is not less than 10 letter"
                                      .tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock_outline),
                                labelText: 'Password'.tr,
                                hintText: 'Enter your Password'.tr,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password can't empty".tr;
                                } else if (value.length < 6) {
                                  return "Password is not less than 6 letter"
                                      .tr;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: _isObscure,
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.lock_outline),
                                  labelText: 'Confirm Password'.tr,
                                  hintText: 'Re-Enter your Password'.tr,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Confirm Password Can't empty".tr;
                                } else if (value.length < 6) {
                                  return "Password is not less than 6 letter"
                                      .tr;
                                } else if (value != passwordController.text) {
                                  return "Password not matched".tr;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 30,
                              width: 200,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
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
                                      var result = await authGetxController
                                          .userRegisterGetx(
                                              username: userNameController.text,
                                              email: emailController.text,
                                              phone:
                                                  mobileNumberController.text,
                                              password:
                                                  passwordController.text);
                                      // print(jsonEncode(result));
                                      print(
                                          'status: ${authGetxController.signupModelClassGetx.status}');
                                      if (authGetxController
                                              .signupModelClassGetx.status ==
                                          1) {
                                        // print('Hello');
                                        String userId = authGetxController
                                            .signupModelClassGetx.data.id;
                                        // print(jsonEncode(result));
                                        print(userId);
                                        Get.toNamed('/otpScreenGetx',
                                            arguments: userId.toString());
                                        // Navigator.pushNamed(context, '/otp-screen',arguments: userId.toString());
                                      } else {
                                        // print('user already exist');
                                        showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Already registered'.tr),
                                                content: Text(
                                                    'User Already Exist with same Email-Id try with different Email-Id!'
                                                        .tr),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text("okay".tr),
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                      authGetxController.isLoading.value =
                                          false;
                                      // authGetxController.isLoading.value = false;
                                    }
                                  },
                                  child: Text('Sign Up'.tr)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Have an Account?".tr),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Login'.tr,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(86, 126, 239, 10)),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )));
  }
}
