import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/AccountScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/CartScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/OrderHistoryScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/ProductScreenGetx.dart';
import 'package:oline_ordering_system/GetX/viewsGetx/app_pagesGetx/WishlistScreenGetx.dart';

import '../../ControllersGetx/HomeScreenGetxController.dart';

class HomeScreenGetx extends StatefulWidget {
  const HomeScreenGetx({Key? key}) : super(key: key);

  @override
  State<HomeScreenGetx> createState() => _HomeScreenGetxState();
}

class _HomeScreenGetxState extends State<HomeScreenGetx> {
  var landingPageController = Get.put(LandingPageController(),permanent: false);
  int currentIndex = 1;

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
  const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: const Color.fromRGBO(86,126,239,15),
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.home,
                    size: 20.0,
                  ),
                ),
                label: 'Home',
                backgroundColor: const Color.fromRGBO(86,126,239,15),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.favorite_border_outlined,
                    size: 20.0,
                  ),
                ),
                label: 'Favorite',
                backgroundColor: const Color.fromRGBO(86,126,239,15),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 20.0,
                  ),
                ),
                label: 'Cart',
                backgroundColor: const Color.fromRGBO(86,126,239,15),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.assignment_turned_in_outlined,
                    size: 20.0,
                  ),
                ),
                label: 'Orders',
                backgroundColor: const Color.fromRGBO(86,126,239,15),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.person,
                    size: 20.0,
                  ),
                ),
                label: 'Account',
                backgroundColor: const Color.fromRGBO(86,126,239,15),
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {

    
    return SafeArea(child: Scaffold(
      bottomNavigationBar: buildBottomNavigationMenu(context, landingPageController),
      body: Obx(()=>IndexedStack(
        index: landingPageController.tabIndex.value,
        children:  [
          ProductScreenGetx(),
          WishlistScreenGetx(),
          CartScreenGetx(),
          OrderHistoryScreenGetx(),
          AccountScreenGetx()
        ],
      )),
    ));
  }
}
