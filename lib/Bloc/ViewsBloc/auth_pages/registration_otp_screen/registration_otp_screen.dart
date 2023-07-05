import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_otp_screen/registration_otp_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_otp_screen/registration_otp_screen_state.dart';

class RegistrationOtpScreenBloc extends StatefulWidget {
  final String userId;

  const RegistrationOtpScreenBloc({Key? key, required this.userId})
      : super(key: key);

  @override
  State<RegistrationOtpScreenBloc> createState() =>
      _RegistrationOtpScreenBlocState();
}

class _RegistrationOtpScreenBlocState extends State<RegistrationOtpScreenBloc> {
  String verificationCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                          // moveToHome(context);
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
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('OTP resent successfully !')));
                        await context.read<RegistrationOtpScreenCubit>().resendOtpBloc(userId: widget.userId.toString());
                      },
                      child: const Text(
                        'RESEND OTP',
                        style: TextStyle(color: Colors.pinkAccent),
                      ))
                ],
              ),
              const SizedBox(height: 20),
              BlocConsumer<RegistrationOtpScreenCubit,
                  RegistrationOtpScreenState>(
                builder: (context, state) {
                  if (state is RegistrationOtpScreenLoadingState) {
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
                              .read<RegistrationOtpScreenCubit>()
                              .verifyOtpOnRegisterBloc(
                              userId: widget.userId.toString(),
                              otp: verificationCode.toString());
                        },
                        child: const Text('VERIFY & PROCEED')),
                  );
                },
                listener: (context, state) {
                  if (state is RegistrationOtpScreenErrorState) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('OTP is Invalid'),
                            content: const Text('Please insert correct OTP.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Okay'))
                            ],
                          );
                        });
                  }
                  if (state is RegistrationOtpScreenSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Account created successfully')));
                    Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
                  }
                },
              )
            ],
          ),
        ),);
  }
}
