import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  // String newPassword = "";
  Widget CustomText = Text("Reset Your Password");
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
                      child: Image(
                        image: AssetImage('assets/ResetPswImage.jpeg'),
                      )),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Current Password',
                        hintText: 'Enter your Current Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Current Password Can't empty";
                      } else if (value.length < 6) {
                        return "Password is not less than 6 letter";
                      }
                    },
                  ),
                  TextFormField(
                      controller: newPassword,
                      decoration: InputDecoration(
                          labelText: 'New Password',
                          hintText: 'Enter New Password'),
                      // onChanged: (value) {
                      //   print(Password.text);
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "New Password Can't empty";
                        } else if (value.length < 6) {
                          return "Password is not less than 6 letter";
                        }
                      }),
                  TextFormField(
                      controller: confirmPassword,
                      decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Re-Enter your New Password'),
                      // onChanged: (value) {
                      //   print(value);
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password Can't empty";
                        } else if (value.length < 6) {
                          return "Password is not less than 6 letter";
                        } else if (value != newPassword.text) {
                          return "Password not matched";
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 37, 150, 190),
                          Colors.pinkAccent
                        ])),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title:
                                        Text('Your Password has been Updated'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(
                                                context, '/account-screen');
                                          },
                                          child: Text('Okey'))
                                    ],
                                  );
                                });
                          }
                        },
                        child: Text('Save the Password')),
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
