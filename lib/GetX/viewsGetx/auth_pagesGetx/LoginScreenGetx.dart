import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ControllersGetx/ApiConnection_Getx/AuthGetx.dart';
import '../../animationGetx/FadeAnimationGetx.dart';

class LoginScreenGetx extends StatefulWidget {
  const LoginScreenGetx({Key? key}) : super(key: key);

  @override
  State<LoginScreenGetx> createState() => _LoginScreenGetxState();
}

class _LoginScreenGetxState extends State<LoginScreenGetx> {
  final authGetxController = Get.put(AuthGetxController());
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void initState() {
    // TODO: implement initState
    // accessApi(context);
    super.initState();
    // permission();
    _isObscure;
    authGetxController.isLoading.value=false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:authGetxController.isLoading.value ? Center(child: CircularProgressIndicator(),): /*authRepoProvider.isLoading? const Center(child: CircularProgressIndicator()): */
          SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/imagesGetx/loginImgGetx/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/imagesGetx/loginImgGetx/light-1.png'))),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/imagesGetx/loginImgGetx/light-2.png'))),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/imagesGetx/loginImgGetx/clock.png'))),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextFormField(
                              cursorColor: Colors.black54,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your Email",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400]),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.black54,
                                  ),
                                // labelText: 'Username',
                              ),

                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Username can't empty";
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                    .hasMatch(value!)) {
                                  return "Enter Correct email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              cursorColor: Colors.black54,
                              obscureText: _isObscure,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your Password",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400]),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black54,
                                ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                    icon: Icon(
                                      _isObscure ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.black54,
                                    ),
                                  )
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password can't empty";
                                } else if (value.length < 6) {
                                  return "Password is not less than 6 letter";
                                }
                                return null;
                              },
                              onChanged: (value) {},
                            ),
                          )
                        ],
                      ),
                    ),
                    /*TextFormField(
                      cursorColor: Colors.white,
                      controller: emailController,
                      decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your E-mail',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username can't empty";
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
                      cursorColor: Colors.white,
                      obscureText: _isObscure,
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password can't empty";
                        } else if (value.length < 6) {
                          return "Password is not less than 6 letter";
                        }
                        return null;
                      },
                      onChanged: (value) {},
                    ),*/
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () async {
                              await Get.toNamed('/forgotPswScreenGetx');
                            },
                            child: const Text(
                              'Forgot your Password?',
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1)),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      width: 200,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          // color: Colors.indigo
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          onPressed: () async {
                            if (formkey.currentState!
                                .validate() /*!formkey.currentState!.validate()*/) {
                              formkey.currentState!.save();

                              var result =
                                  await authGetxController.userLoginGetx(
                                      emailId: emailController.text,
                                      password: passwordController.text
                                 /* emailId: 'felitej727@larland.com',
                                    password: '123456'*/
                                  );
                              print('status: ${authGetxController.loginModelClassGetx.status}');
                              if (authGetxController
                                      .loginModelClassGetx.status ==
                                  1) {
                                Get.rawSnackbar(
                                  message: 'Log in successful !',
                                  backgroundColor:
                                      Color.fromRGBO(86, 126, 239, 15),
                                );

                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString(
                                    'jwtToken',
                                    authGetxController
                                        .loginModelClassGetx.data.jwtToken);
                                print('jwttoken: ${prefs.get('jwtToken')}');
                                await prefs.setString(
                                    'name',
                                    authGetxController
                                        .loginModelClassGetx.data.name);
                                await prefs.setString(
                                    'emailId',
                                    authGetxController
                                        .loginModelClassGetx.data.emailId);
                                await prefs.setString(
                                    'mobileNo',
                                    authGetxController
                                        .loginModelClassGetx.data.mobileNo);

                                await Get.offNamedUntil(
                                    '/homeScreenGetx', (route) => false);
                              } else if (authGetxController
                                      .loginModelClassGetx.status ==
                                  0) {
                                // print('please register in app');
                                Get.defaultDialog(
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'okey',
                                          style: TextStyle(fontSize: 15,
                                              color: Color.fromRGBO(
                                                  143, 148, 251, 1)),
                                        ))
                                  ],
                                  title: 'Please Register in App',
                                  content: Padding(
                                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                            'You are not registered with us kindly register first!', style: TextStyle(color: Colors.black54),),
                                      ],
                                    ),
                                  )
                                );
                              }
                              // authRepoProvider.isLoading = false;
                            }
                          },
                          child: const Text('LOGIN')),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an Account?"),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed('/registrationScreenGetx');
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1)),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
