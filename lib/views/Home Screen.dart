import 'package:flutter/material.dart';
import 'package:oline_ordering_system/views/AccountScreen.dart';
import 'package:oline_ordering_system/views/CartScreen.dart';
import 'package:oline_ordering_system/views/OrderHistoryScreen.dart';
import 'package:oline_ordering_system/views/ProductScreen.dart';

import 'WishlistScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key,required String from})  : super(key: key)  {
   print('Home Screen from $from') ;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [
    ProductScreen(),
    WishlistScreen(),
    CartScreen(),
    OrderHistoryScreen(),
    AccountScreen()
  ];

  int currentIndex = 0;


  @override
  void initState() {
    print('Home Screen Called ${DateTime.now().toString()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Account'),
        ],
      ),

    );

  }
}
