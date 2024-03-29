import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreenBloc extends StatefulWidget {
  const AccountScreenBloc({Key? key}) : super(key: key);

  @override
  State<AccountScreenBloc> createState() => _AccountScreenBlocState();
}

class _AccountScreenBlocState extends State<AccountScreenBloc> {
  TextEditingController UserName = TextEditingController();
  TextEditingController EmailAddress = TextEditingController();
  TextEditingController MobileNo = TextEditingController();
  TextEditingController AddressOfUser = TextEditingController();
  var UserNameValue = "";
  var EmailAddressValue = "";
  var MobileNumberValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountDetails();
  }

  void getAccountDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userName = preferences.getString('name') ?? '';
    String emailAddress = preferences.getString('emailId') ?? '';
    String mobileNo = preferences.getString('mobileNo') ?? '';

    setState(() {
      UserNameValue = userName ?? "";
      EmailAddressValue = emailAddress ?? "";
      MobileNumberValue = mobileNo ?? "";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
        title: Text('${'Hello'} ${UserNameValue}'),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
                // Get.offAllNamed('/homeScreenGetx');
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
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(
                      image: AssetImage('assets/LoginImage.png'),
                    )),
                const Text(
                  'Account Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              height: 30,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                  color:  Colors.black12
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/orderHistoryScreen');
                                },
                                child: const FittedBox(
                                  child: Row(
                                    children:  [
                                      Icon(
                                        Icons.assignment_turned_in_outlined,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'My Orders',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              height: 30,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                  color:   Colors.black12
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/wishlistScreen');
                                },
                                child: const FittedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Wishlist',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              height: 30,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                  color:   Colors.black12
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/cartScreen');
                                },
                                child: const FittedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'My Cart',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              height: 30,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                                  color:  Colors.black12
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent),
                                onPressed: () {
                                  // languageAlertGetx(context);

                                },
                                child: const FittedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.settings_outlined,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Setting',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 25,
                            color: Color.fromRGBO(86, 126, 239, 15),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'User Name:',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                UserNameValue,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.mail_outline,
                            size: 25,
                            color: Color.fromRGBO(86, 126, 239, 15),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Email Address:',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                EmailAddressValue,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone_outlined,
                            size: 25,
                            color: Color.fromRGBO(86, 126, 239, 15),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Mobile No.:',
                                style: TextStyle(fontSize: 10),
                              ),
                              Text(
                                MobileNumberValue,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '');
                                // Get.toNamed('/changePswScreenGetx');
                              },
                              child: const Text(
                                'Change Password ?',
                                style: TextStyle(color: Color.fromRGBO(86, 126, 239, 15),),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Address of User'),
                                hintText: 'Enter here',
                              ),
                              controller: AddressOfUser,
                              keyboardType: TextInputType.text,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color.fromRGBO(86, 126, 239, 15),
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      onPressed: () {},
                      child: const Text('Save Data')),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.black12),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          logoutAlertBloc(context);
                        },
                        child: const Text(
                          'Log Out',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void logoutAlertBloc(BuildContext context) {
  var alertDialog = AlertDialog(
    title: const Text(
      'Log Out',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    content: const Text('Are you Sure, you want to Log Out?'),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No', style: TextStyle(color: Color
              .fromRGBO(
              86,
              126,
              239,
              10),),)),
      TextButton(
          onPressed: () async {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
                content: Text(
                    'Log out successful !'),
                duration: Duration(
                    seconds: 2)));
            final share = await SharedPreferences.getInstance();
            share.clear();
            Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (route) => false);
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.red),
          ))
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}