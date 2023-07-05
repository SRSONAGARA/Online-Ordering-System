import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/login_screen/login_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/login_screen/login_screen_state.dart';

import '../../../../GetX/viewsGetx/app_pagesGetx/homeScreenGetx.dart';
import '../forgot_psw_screen/forgot_psw_screen.dart';

class LoginScreenBloc extends StatefulWidget {
  const LoginScreenBloc({Key? key}) : super(key: key);

  @override
  State<LoginScreenBloc> createState() => _LoginScreenBlocState();
}

class _LoginScreenBlocState extends State<LoginScreenBloc> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LoginScreenCubit>().togglePasswordVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 350,
                decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/imagesGetx/loginImgGetx/clock.png'))),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                      obscureText: context.select((LoginScreenCubit cubit) => cubit.isObscure),
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your Password',
                          icon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<LoginScreenCubit>().togglePasswordVisibility();
                            },
                            icon: Icon(context.select((LoginScreenCubit cubit) => cubit.isObscure)
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
                              await Navigator.pushNamed(context, '/forgotPswScreen');
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
                    BlocConsumer<LoginScreenCubit,LoginScreenState>(builder: (context, state) {
                      if (state is LoginScreenLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(86, 126, 239, 15),
                          ),
                        );
                      }
                      return Container(
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
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                context.read<LoginScreenCubit>().userLoginBloc(
                                    emailId: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: const Text('Login')),
                      );
                    }, listener: (context, state) {
                      if (state is LoginScreenErrorState) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Invalid username or password'),
                              content: const Text(
                                'This email id and password is not verified, Please enter correct details!',
                                style: TextStyle(color: Colors.black54),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Okay',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromRGBO(86, 126, 239, 15),
                                      ),
                                    ))
                              ],
                            ));
                      }
                      if (state is LoginScreenSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Log in successful !')));
                        Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
                      }
                    }

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
                              Navigator.pushNamed(context, '/registrationScreen');
                              // Get.toNamed('/registrationScreenGetx');
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
      )
    );
  }
}
