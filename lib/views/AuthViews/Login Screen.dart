import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/ApiConnection/AuthRepo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;

    void permission() async{
      Map<Permission, PermissionStatus> status = await [
        Permission.notification,

        //add more permission to request here.
      ].request();
      if (status[Permission.notification] == PermissionStatus.denied){
        Permission.notification.request();
        log("Permission Denied");
        return;
      }else{
      }
    }

  void accessApi(BuildContext context) async {
    final authRepoProvider = Provider.of<AuthRepo>(context, listen: false);
    authRepoProvider.isLoading=false;

  }

  @override
  void initState() {
    // TODO: implement initState
    accessApi(context);
    super.initState();
    permission();
    _isObscure;
  }

  @override
  Widget build(BuildContext context) {
    final authRepoProvider= Provider.of<AuthRepo>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: authRepoProvider.isLoading? const Center(child: CircularProgressIndicator()):  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formkey,
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
                      image: AssetImage('assets/LoginImage.png'),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Welcome Back",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your E-mail',
                      icon: Icon(Icons.person)),
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
                  obscureText: _isObscure,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your Password',
                      icon: const Icon(Icons.lock),
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
                      return "Password can't empty";
                    } else if (value.length < 6) {
                      return "Password is not less than 6 letter";
                    }
                    return null;
                  },
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () async {
                          await Navigator.pushNamed(
                              context, '/forgotpsw-screen');
                        },
                        child: const Text('Forgot your Password?')),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
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
                        if (formkey.currentState!
                            .validate() /*!formkey.currentState!.validate()*/) {
                          formkey.currentState!.save();

                          var result = await authRepoProvider.userLogin(
                              emailId: emailController.text,
                              password: passwordController.text);

                          if (authRepoProvider.loginData[0].status == 1) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Log in successful !'),
                              backgroundColor: Colors.blue,
                              duration: Duration(seconds: 2),
                            ));
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'jwtToken', authRepoProvider.loginData[0].data.jwtToken);

                            print('jwttoken: ${prefs.get('jwtToken')}');

                            await prefs.setString(
                                'name', authRepoProvider.loginData[0].data.name);
                            await prefs.setString(
                                'emailId', authRepoProvider.loginData[0].data.emailId);
                            await prefs.setString(
                                'mobileNo', authRepoProvider.loginData[0].data.mobileNo);
                            // print(prefs.getString('name'));

                            // String emailId = result['data']['emailId'];
                            // await Future.delayed(const Duration(seconds: 3));
                            await Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen(
                                          from: '/login screen',
                                        )),
                                (route) => false);


                          } else if(authRepoProvider.loginData[0].status == 0){
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Please Register in App'),
                                    content: Text(
                                        'Your email id is not verified kindly register again with same details and verify your account to use app!'),
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
                          Navigator.pushNamed(context, '/registration-screen');
                        },
                        child: const Text('Register'))
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
