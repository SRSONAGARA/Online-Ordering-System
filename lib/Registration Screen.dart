import 'package:flutter/material.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),centerTitle: true,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                    height: 200,
                    width: 200,
                    child:Image(image: AssetImage('assets/LoginImage.png'),)
                ),
                TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person_outline),
                      labelText: 'Username',
                      hintText: 'Enter your Name'),
                  validator: (value){
                    if(value!.isEmpty){
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
                  validator: (value){
                    if(value!.isEmpty){
                      return "Email can't empty";
                    }else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value!)){
                      return "Enter Correct email";
                    }else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.lock_outline),
                      labelText: 'Password',
                      hintText: 'Enter your Password'),
                  validator: (value){
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
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock_outline),
                      labelText: 'Confirm Password',
                      hintText: 'Re-Enter your Password'),
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
                  height: 20,
                ),
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      gradient: LinearGradient(
                          colors: [Color.fromARGB(255, 37, 150, 190), Colors.pinkAccent])
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: ()async{
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          await Future.delayed(const Duration(seconds: 1));
                          await Navigator.pushNamed(context, '/otp-screen');
                        }

                      },child:const Text('Sign Up') ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have an Account?"),
                    const SizedBox(width: 10,),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, '/login-screen');
                    }, child: const Text('Login'))
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
