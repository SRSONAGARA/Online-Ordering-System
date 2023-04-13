import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/ApiConnection/AuthRepo.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  Widget CustomText = const Text("Reset Your Password");
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
    final favoriteProvider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                  Container(
                      height: 300,
                      width: 400,
                      child: const Image(
                        image: AssetImage('assets/ResetPswImage.jpeg'),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                          hintText: 'Enter New Password'),
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
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            var result = await AuthRepo.changePassword(
                                newPass: newPassword.text,
                                confirmPass: confirmPassword.text);
                            if (result['status'] == 1) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Your Password has been Updated'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/login-screen',
                                                  (route) => false);
                                            },
                                            child: const Text('Okey'))
                                      ],
                                    );
                                  });
                            }
                          }
                        },
                        child: const Text('Save the Password')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
