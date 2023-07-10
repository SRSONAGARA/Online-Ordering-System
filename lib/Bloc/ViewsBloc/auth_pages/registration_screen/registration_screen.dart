import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_otp_screen/registration_otp_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_otp_screen/registration_otp_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_screen/registration_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/registration_screen/registration_screen_state.dart';

class RegistrationScreenBloc extends StatefulWidget {
  const RegistrationScreenBloc({Key? key}) : super(key: key);

  @override
  State<RegistrationScreenBloc> createState() => _RegistrationScreenBlocState();
}

class _RegistrationScreenBlocState extends State<RegistrationScreenBloc> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegistrationScreenCubit>().togglePasswordVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                      margin: const EdgeInsets.only(top: 50),
                      child: const Center(
                        child: Text(
                          "REGISTER NOW!",
                          style: TextStyle(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
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
                        obscureText: context.select(
                            (RegistrationScreenCubit cubit) => cubit.isObscure),
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock_outline),
                            labelText: 'Confirm Password',
                            hintText: 'Re-Enter your Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<RegistrationScreenCubit>()
                                      .togglePasswordVisibility();
                                },
                                icon: Icon(context.select(
                                        (RegistrationScreenCubit cubit) =>
                                            cubit.isObscure)
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
                      BlocConsumer<RegistrationScreenCubit,
                          RegistrationScreenState>(
                        builder: (context, state) {
                          if (state is RegistrationScreenLoadingState) {
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
                                        .read<RegistrationScreenCubit>()
                                        .userRegisterBloc(
                                            username: userNameController.text,
                                            email: emailController.text,
                                            phone: mobileNumberController.text,
                                            password: passwordController.text);
                                  }
                                },
                                child: const Text('Sign Up')),
                          );
                        },
                        listener: (context, state) {
                          if (state is RegistrationScreenErrorState) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('Already registered'),
                                    content: const Text(
                                        'User Already Exist with same Email-Id try with different Email-Id!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Okay"),
                                      ),
                                    ],
                                  );
                                });
                          }
                          if (state is RegistrationScreenSuccessState) {
                            String userId = state.userId;
                            print('userId:$userId');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RegistrationOtpScreenBloc(
                                        userId: userId)));
                          }
                        },
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
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Color.fromRGBO(86, 126, 239, 10)),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
