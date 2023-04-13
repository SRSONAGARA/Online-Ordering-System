import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AccountScreen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var UserNameValue="";
  var EmailAddressValue="";

  void getAccountDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userName = preferences.getString('name') ?? '';
    String emailAddress = preferences.getString('emailId') ?? '';

    setState(() {
      UserNameValue = userName ?? "";
      EmailAddressValue = emailAddress ?? "";
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.white, Colors.blue])),
              child: Column(
                children: [
                Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 70,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/LoginImage.png'))),
                    ),
                    Text(
                      UserNameValue,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      EmailAddressValue,
                      style: const TextStyle(fontSize: 15),
                    )
                ],
              )),
          CustomListTile(Icons.home_outlined, 'Product Screen',
              () => {Navigator.of(context).pushNamed('/product-screen')}),
          CustomListTile(Icons.favorite_border_outlined, 'WishList Screen',
              () => {Navigator.of(context).pushNamed('/wishlist-screen')}),
          CustomListTile(Icons.shopping_cart_outlined, 'Cart Screen',
              () => {Navigator.of(context).pushNamed('/cart-screen')}),
          CustomListTile(Icons.assignment_turned_in_outlined, 'Order History Screen',
              () => {Navigator.of(context).pushNamed('/orderhistory-screen')}),
          CustomListTile(Icons.account_circle_outlined, 'Account Screen',
              () => {Navigator.of(context).pushNamed('/account-screen')}),
          const Divider(
            color: Colors.black54,
          ),
          CustomListTile(Icons.settings, 'Setting', () => {}),
          CustomListTile(Icons.info_outlined, 'About',() => {}),
          const Divider(
            color: Colors.black54,
          ),
          CustomListTile(Icons.logout_outlined, 'LogOut',() => {alertFunc(context)}),
          const SizedBox(height: 30,),
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Text('App Version 1.0.0+1',textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.black54),),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  VoidCallback onTap;

  CustomListTile(this.icon, this.text, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 10,),
      child: InkWell(
        splashColor: Colors.blue,
        // onTap: onTap(),
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 10,
              ),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }
}
