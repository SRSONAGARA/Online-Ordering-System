import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_otp_screen/forgot_psw_otp_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/forgot_psw_otp_screen/forgot_psw_otp_screen_state.dart';

class ForgotPswOtpScreenBloc extends StatefulWidget {
  final String userId;

  const ForgotPswOtpScreenBloc({Key? key, required this.userId})
      : super(key: key);

  @override
  State<ForgotPswOtpScreenBloc> createState() => _ForgotPswOtpScreenBlocState();
}

class _ForgotPswOtpScreenBlocState extends State<ForgotPswOtpScreenBloc> {
  String verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
            create: (context) => ForgotPswOtpScreenCubit(),
            child: SingleChildScrollView(
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
                        image: AssetImage('assets/Otpimage.png'),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'OTP Verification',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter the OTP sent to - ',
                      ),
                      const Icon(Icons.email_outlined),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Get.back();
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Form(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpTextField(
                        numberOfFields: 4,
                        borderColor: const Color(0xFF512DA8),
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {
                          verificationCode = code;
                        },
                        onSubmit: (String code) {
                          verificationCode = code;
                          print(verificationCode);
                        }, // end onSubmit
                      )
                    ],
                  )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't Receive the OTP?"),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('OTP resent successfully !')));

                            await context
                                .read<ForgotPswOtpScreenCubit>()
                                .resendOtpBloc(
                                    userId: widget.userId.toString());
                            print('otp resend successfully');
                          },
                          child: const Text(
                            'RESEND OTP',
                            style: TextStyle(color: Colors.pinkAccent),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<ForgotPswOtpScreenCubit, ForgotPswOtpScreenState>(
                    builder: (context, state) {
                      if (state is ForgotPswOtpScreenLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(86, 126, 239, 15),
                          ),
                        );
                      }
                      return Container(
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
                              await context
                                  .read<ForgotPswOtpScreenCubit>()
                                  .verifyOtpOnForgotPasswordBloc(
                                      userId: widget.userId.toString(),
                                      otp: verificationCode.toString());
                            },
                            child: const Text('VERIFY & PROCEED')),
                      );
                    },
                    listener: (context, state) {
                      if (state is ForgotPswOtpScreenSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'You will get your new password in registered email !')));
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/loginScreen', (route) => false);
                      }
                      if (state is ForgotPswOtpScreenErrorState) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: const Text('OTP is Invalid'),
                                  content: const Text(
                                    'Please insert correct OTP.',
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
            )));
  }
}
