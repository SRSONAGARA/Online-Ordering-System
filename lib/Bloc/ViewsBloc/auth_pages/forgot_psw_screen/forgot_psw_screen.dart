import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_otp_screen/forgot_psw_otp_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_screen/forgot_psw_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_screen/forgot_psw_screen_state.dart';

class ForgotPswScreenBloc extends StatefulWidget {
  const ForgotPswScreenBloc({Key? key}) : super(key: key);

  @override
  State<ForgotPswScreenBloc> createState() => _ForgotPswScreenBlocState();
}

class _ForgotPswScreenBlocState extends State<ForgotPswScreenBloc> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
          title: const Text("Forgot Password"),
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
                    const Image(
                      height: 200,
                      width: 200,
                      image:
                          AssetImage('assets/imagesGetx/forgetPswImgGetx.png'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot your Password?',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "Please enter the email address you'd like \n  your password reset information sent to",
                          maxLines: 2,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock_outline),
                        labelText: 'Email Address',
                        hintText: 'Enter your Email',
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
                    const SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    BlocConsumer<ForgotPswScreenCubit, ForgotPswScreenState>(
                      builder: (context, state) {
                        if (state is ForgotPswScreenLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(86, 126, 239, 15),
                            ),
                          );
                        }
                        return Container(
                          height: 30,
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

                                  await context
                                      .read<ForgotPswScreenCubit>()
                                      .forgotPasswordBloc(
                                          emailId: emailController.text);
                                }
                              },
                              child: const Text('Send otp')),
                        );
                      },
                      listener: (context, state) {
                        if (state is ForgotPswScreenSuccessState) {
                          String userId = state.userId;
                          print('userId:$userId');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  ForgotPswOtpScreenBloc(userId: userId)));
                        }
                        if (state is ForgotPswScreenErrorState) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title:
                                        const Text('Email is not registered'),
                                    content: const Text(
                                      'This Email Id is not Registered With us kindly register first!',
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
                                              color: Color.fromRGBO(
                                                  86, 126, 239, 15),
                                            ),
                                          ))
                                    ],
                                  ));
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
