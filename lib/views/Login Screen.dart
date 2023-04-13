import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/ApiConnection/AuthRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home Screen.dart';

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
      body: SingleChildScrollView(
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
                SizedBox(
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

                          var result = await AuthRepo.userLogin(
                              emailId: emailController.text,
                              password: passwordController.text);

                          if (result['status'] == 1) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Log in successful !'),
                              backgroundColor: Colors.blue,
                              duration: Duration(seconds: 2),
                            ));
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'jwtToken', result['data']['jwtToken']);

                            print('jwttoken: ${prefs.get('jwtToken')}');

                            await prefs.setString(
                                'name', result['data']['name']);
                            await prefs.setString(
                                'emailId', result['data']['emailId']);
                            await prefs.setString(
                                'mobileNo', result['data']['mobileNo']);
                            print(prefs.getString('name'));

                            // String emailId = result['data']['emailId'];
                            await Future.delayed(const Duration(seconds: 1));
                            await Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen(
                                          from: '/login screen',
                                        )),
                                (route) => false);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Unable to Login'),
                                    content: Text(
                                        'Please check your emailId and password.'),
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
