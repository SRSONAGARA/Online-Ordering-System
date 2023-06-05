import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ControllersGetx/ApiConnection_Getx/AccountScreenGetxController.dart';
import '../../ControllersGetx/SearchGetxController.dart';

class AccountScreenGetx extends StatefulWidget {
  const AccountScreenGetx({Key? key}) : super(key: key);

  @override
  State<AccountScreenGetx> createState() => _AccountScreenGetxState();
}

class _AccountScreenGetxState extends State<AccountScreenGetx> {
  var accountScreenGetxController = Get.put(AccountScreenGetxController());
  var searchGetxController = Get.put(SearchGetxController());

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
    return WillPopScope(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
        title: Text('${'Hello'.tr} ${UserNameValue}'),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              onTap: () {
                Get.offAllNamed('/homeScreenGetx');
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
                Text(
                  'Account Details'.tr,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                  Get.toNamed('/orderHistoryScreenGetx');
                                },
                                child: Row(
                                  children:  [
                                    const Icon(
                                      Icons.assignment_turned_in_outlined,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'My Orders'.tr,
                                      style: const TextStyle(color: Colors.black),
                                    )
                                  ],
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
                                  Get.toNamed('/wishlistScreenGetx');
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Wishlist'.tr,
                                      style: const TextStyle(color: Colors.black),
                                    )
                                  ],
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
                                  Get.toNamed('/cartScreenGetx');
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'My Cart'.tr,
                                      style: const TextStyle(color: Colors.black),
                                    )
                                  ],
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
                                  languageAlertGetx(context);

                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.settings_outlined,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Setting'.tr,
                                      style: const TextStyle(color: Colors.black),
                                    )
                                  ],
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
                              Text(
                                'User Name:'.tr,
                                style: const TextStyle(fontSize: 10),
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
                              Text(
                                'Email Address:'.tr,
                                style: const TextStyle(fontSize: 10),
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
                              Text(
                                'Mobile No.:'.tr,
                                style: const TextStyle(fontSize: 10),
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
                                Get.toNamed('/changePswScreenGetx');
                              },
                              child: Text(
                                'Change Password ?'.tr,
                                style: const TextStyle(color: Color.fromRGBO(86, 126, 239, 15),),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                label: Text('Address of User'.tr),
                                hintText: 'Enter here'.tr,
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
                      child: Text('Save Data'.tr)),
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
                          logoutAlertGetx(context);
                        },
                        child: Text(
                          'Log Out'.tr,
                          style: const TextStyle(color: Colors.black),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ), onWillPop: ()async{
      if(searchGetxController.SearchButton == true){
        searchGetxController.searchButtonUnPress();
        Get.offNamedUntil('/homeScreenGetx', (route) => false);
        return true;
      }else{
        Get.offNamedUntil('/homeScreenGetx', (route) => false);
        return false;
      }
    });
  }
}
void logoutAlertGetx(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Text(
      'Log Out'.tr,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    content: Text('Are you Sure, you want to Log Out?'.tr),
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('No'.tr, style: const TextStyle(color: Color
              .fromRGBO(
              86,
              126,
              239,
              10),),)),
      TextButton(
          onPressed: () async {
            Get.rawSnackbar(
              message: 'Log out successful !'.tr,
              backgroundColor: const Color
                  .fromRGBO(
                  86,
                  126,
                  239,
                  10),
              duration: const Duration(seconds: 2),
            );
            final share = await SharedPreferences.getInstance();
            share.clear();
            Get.offNamedUntil('/loginScreenGetx', (route) => false);
          },
          child: Text(
            'Yes'.tr,
            style: const TextStyle(color: Colors.red),
          ))
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}
 void languageAlertGetx(BuildContext context) {
  var alertDialog = AlertDialog(
    title: Row(children: [
      Icon(Icons.translate, color: Color.fromRGBO(86, 126, 239, 15)),
      SizedBox(width: 10,),
      Text('Choose language'.tr)
    ],),
    content: SizedBox(
      height: 120,
      child: Column(
        children: [
          TextButton(onPressed: (){
            Get.updateLocale(Locale('en', 'US'));
            SharedPreferences.getInstance().then((prefs) => prefs.setString('lang_code', 'en_US'));
            Get.back();
          }, child: Text('English'.tr, style: TextStyle(color:Color.fromRGBO(86, 126, 239, 15)),)),
          Divider(),
          TextButton(onPressed: (){
            Get.updateLocale(Locale('hi', 'IN'));
            SharedPreferences.getInstance().then((prefs) => prefs.setString('lang_code', 'hi_IN'));
            Get.back();
          }, child: Text('Hindi'.tr, style: TextStyle(color: Color.fromRGBO(86, 126, 239, 15)),)),

        ],
      ),
    ),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      });
}

