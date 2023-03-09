import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController UserName =
      TextEditingController(text: 'Sagar Sonagara');
  TextEditingController EmailAddress =
  TextEditingController(text: 'sagar7777926900@gmail.com');
  TextEditingController MobileNo = TextEditingController();
  TextEditingController AddressOfUser = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Account Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 200,
                    width: 200,
                    child: Image(
                      image: AssetImage('assets/LoginImage.png'),
                    )),
                Text(
                  'Account Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text('User Name:', textAlign: TextAlign.left),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: UserName,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text('Email Address:', textAlign: TextAlign.left),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: EmailAddress,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        // maxLength: 10,
                        decoration: InputDecoration(
                          label: Text('Mobile Number'),
                          hintText: 'Enter here',
                        ),
                        controller: MobileNo,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('Address of User'),
                          hintText: 'Enter here',
                        ),
                        controller: AddressOfUser,
                        keyboardType: TextInputType.phone,

                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      gradient: LinearGradient(
                          colors: [Color.fromARGB(255, 37, 150, 190), Colors.pinkAccent])
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: (){},child:Text('Save the Data') ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/resetpsw-screen');
                }, child: Text('Reset Password')),
                SizedBox(height: 20,),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      gradient: LinearGradient(
                          colors: [Color.fromARGB(255, 37, 150, 190), Colors.pinkAccent])
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: (){
                        alertFunc(context);
                      },child:Text('Log Out') ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

void alertFunc( BuildContext context){
  var alertDialog=AlertDialog(
    title: Text('Log Out',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
    content: Text('Are you Sure, you want to Log Out?'),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text('No')),
      TextButton(onPressed: (){
        Navigator.pushNamedAndRemoveUntil(context, '/login-screen', (route) => false);
      }, child: Text('Yes'))
    ],
  );
  showDialog(context: context, builder: (BuildContext context){
    return alertDialog;
  });
}