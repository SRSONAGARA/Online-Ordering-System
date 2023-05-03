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
      body: authGetxController.isLoading.value? Center(child: CircularProgressIndicator()): SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                    height: 200,
                    width: 200,
                    child: Image(
                      image: AssetImage('assets/LoginImage.png'),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Welcome",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
                    )
                  ],
                ),
                TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person_outline),
                      labelText: 'Username',
                      hintText: 'Enter your Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username can't empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email_outlined),
                      labelText: 'E-mail',
                      hintText: 'Enter your E-mail'),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  inputFormatters: [new LengthLimitingTextInputFormatter(10),],
                  controller: mobileNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.phone_outlined),
                      labelText: 'Mobile No',
                      hintText: 'Enter your mobile no.'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mobile No can't empty";
                    } else if (value.length < 10) {
                      return "Mobile No is not less than 10 letter";
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
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password can't empty";
                    } else if (value.length < 6) {
                      return "Password is not less than 6 letter";
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
                      labelText: 'Confirm Password',
                      hintText: 'Re-Enter your Password',
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
                      return "Confirm Password Can't empty";
                    } else if (value.length < 6) {
                      return "Password is not less than 6 letter";
                    } else if (value != passwordController.text) {
                      return "Password not matched";
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
                          var result = await authGetxController.userRegisterGetx(
                              username: userNameController.text,
                              email: emailController.text,
                              phone: mobileNumberController.text,
                              password: passwordController.text);
                          // print(jsonEncode(result));
                          print('status: ${authGetxController.signupModelClassGetx.status}');
                          if (authGetxController.signupModelClassGetx.status == 1) {
                            // print('Hello');
                            String userId = authGetxController.signupModelClassGetx.data.id;
                            // print(jsonEncode(result));
                            print(userId);
                            Get.toNamed('/otpScreenGetx', arguments: userId.toString());
                            // Navigator.pushNamed(context, '/otp-screen',arguments: userId.toString());
                          }else{
                            // print('user already exist');
                            showDialog(context: context, builder: (_){
                              return AlertDialog(
                                title: Text('Already registered'),
                                content: Text('User Already Exist with same Email-Id try with different Email-Id!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("okay"),
                                  ),
                                ],
                              );
                            });
                          }
                          // authGetxController.isLoading.value = false;
                        }
                      },
                      child: Text('Sign Up')),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an Account?"),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Login', style: TextStyle(color: Color
                            .fromRGBO(
                            86,
                            126,
                            239,
                            10)),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
