import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ControllersGetx/ApiConnection_Getx/AccountScreenGetxController.dart';

class ChangePswScreenGetx extends StatefulWidget {
  const ChangePswScreenGetx({Key? key}) : super(key: key);

  @override
  State<ChangePswScreenGetx> createState() => _ChangePswScreenGetxState();
}

class _ChangePswScreenGetxState extends State<ChangePswScreenGetx> {
  var accountScreenGetxController = Get.put(AccountScreenGetxController());
  final formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  Widget CustomText = const Text("Reset Your Password");
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                      height: 300,
                      width: 400,
                      child: const Image(
                        image: AssetImage('assets/ResetPswImage.jpeg'),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Enter a new password',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      obscureText: true,
                      controller: newPassword,
                      decoration: const InputDecoration(
                          labelText: 'New Password',
                          hintText: 'Enter New Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "New Password Can't empty";
                        } else if (value.length < 6) {
                          return "Password is not less than 6 letter";
                        }
                      }),
                  TextFormField(
                      obscureText: _isObscure,
                      controller: confirmPassword,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Re-Enter your New Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password Can't empty";
                        } else if (value.length < 6) {
                          return "Password is not less than 6 letter";
                        } else if (value != newPassword.text) {
                          return "Password not matched";
                        }
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 30,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color
                            .fromRGBO(
                            86,
                            126,
                            239,
                            10),
                        ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            var result = await accountScreenGetxController
                                .changePasswordGetx(
                                    newPass: newPassword.text,
                                    confirmPass: confirmPassword.text);
                            if (result['status'] == 1) {
                              Get.dialog(AlertDialog(
                                title: Text('Your Password has been Updated'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.offAllNamed('/loginScreenGetx');
                                        },
                                        child: const Text('Okey',style: TextStyle(color: Color
                                            .fromRGBO(
                                            86,
                                            126,
                                            239,
                                            10),),))
                                  ]
                              ));
                             /* Get.defaultDialog(
                                title: 'Your Password has been Updated',
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.offAllNamed('/loginScreenGetx');
                                      },
                                      child: const Text('Okey'))
                                ]
                              );*/
                              /*showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Your Password has been Updated'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/login-screen',
                                                  (route) => false);
                                            },
                                            child: const Text('Okey'))
                                      ],
                                    );
                                  });*/
                            }
                          }
                        },
                        child: const Text('Save the Password')),
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
