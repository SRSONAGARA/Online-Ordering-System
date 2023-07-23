import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/change_psw_screen/change_psw_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/auth_pages/change_psw_screen/change_psw_screen_state.dart';

class ChangePswScreenBloc extends StatefulWidget {
  const ChangePswScreenBloc({Key? key}) : super(key: key);

  @override
  State<ChangePswScreenBloc> createState() => _ChangePswScreenBlocState();
}

class _ChangePswScreenBlocState extends State<ChangePswScreenBloc> {
  final formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  Widget CustomText =  const Text("Reset Your Password");
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
                  const SizedBox(
                      height: 300,
                      width: 400,
                      child: Image(
                        image: AssetImage('assets/imagesGetx/resetPswImgGetx.jpeg'),
                      )),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          hintText: 'Enter a new password'),
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
                  BlocConsumer<ChangePswScreenCubit, ChangePswScreenState>(builder: (context, state) {
                    ChangePswScreenCubit changePswScreenCubit = BlocProvider.of<ChangePswScreenCubit>(context);
                    if(state is ChangePswScreenLoadingState){
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(86, 126, 239, 15),
                        ),
                      );
                    }return Container(
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
                            var result = await changePswScreenCubit
                                .changePasswordBloc(
                                newPass: newPassword.text,
                                confirmPass: confirmPassword.text);
                          }
                        },
                        child: const Text('Save the Password')),
                  );
                  }, listener: (context, state) {
                    if(state is ChangePswScreenSuccessState){
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Your Password has been Updated'),
                            content: const Text(
                              'Your password has been changed successfully,Please login again!',
                              style: TextStyle(color: Colors.black54),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
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
                  },)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
