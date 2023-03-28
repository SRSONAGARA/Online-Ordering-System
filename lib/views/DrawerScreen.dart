import 'package:flutter/material.dart';

import 'AccountScreen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.white, Colors.blue])),
              child: Container(
                child: Column(
                  children: [
                  Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/LoginImage.png'))),
                      ),
                      Text(
                        'Sagar Sonagara',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'sagar7777926900',
                        style: TextStyle(fontSize: 15),
                      )
                  ],
                ),
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
          Divider(
            color: Colors.black54,
          ),
          CustomListTile(Icons.settings, 'Setting', () => {}),
          CustomListTile(Icons.info_outlined, 'About',() => {}),
          Divider(
            color: Colors.black54,
          ),
          CustomListTile(Icons.logout_outlined, 'LogOut',() => {alertFunc(context)}),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text('App Version 1.0.0',textAlign: TextAlign.center,style: TextStyle(fontSize: 10),),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  VoidCallback onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 10,),
      child: InkWell(
        splashColor: Colors.blue,
        // onTap: onTap(),
        onTap: onTap,
        child: Container(
          height: 40,
          child: Row(
            children: [
              Icon(icon),
              SizedBox(
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
