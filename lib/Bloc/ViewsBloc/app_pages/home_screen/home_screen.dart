import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/account_screen/account_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/cart_screen/cart_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/home_screen/home_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/search_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/wishlist_screen/wishlist_screen.dart';

import '../../../../notificationservice/local_notification_service.dart';
import '../order_history_screen/order_history_screen.dart';

class HomeScreenBloc extends StatefulWidget {
  const HomeScreenBloc({Key? key}) : super(key: key);

  @override
  State<HomeScreenBloc> createState() => _HomeScreenBlocState();
}

class _HomeScreenBlocState extends State<HomeScreenBloc> {
  late HomeScreenCubit homeScreenCubit;

  List screens = [
    const ProductScreenBloc(),
    const WishlistScreenBloc(),
    const CartScreenBloc(),
    const OrderHistoryScreenBloc(),
    const AccountScreenBloc()
  ];
  @override
  void initState() {
    // print('Home Screen Called ${DateTime.now().toString()}');
    homeScreenCubit = HomeScreenCubit();
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    homeScreenCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, int>(
        bloc: homeScreenCubit,
        builder: (context, currentIndex) {
          return Scaffold(
            body: OfflineBuilder(
              debounceDuration: Duration.zero,
              connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                  ) {
                if (connectivity == ConnectivityResult.none) {
                  final bool connected = connectivity != ConnectivityResult.none;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      //  child,
                      AlertDialog(
                        title: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('No Internet Connection'),
                                const Spacer(),
                                InkWell(
                                  onTap: () => exit(0),
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  child: const Icon(Icons.close),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Center(
                                child: Icon(
                                  Icons.warning_amber_sharp,
                                  size: 48,
                                ),
                              ),
                            )
                          ],
                        ),
                        content: const Text('Please check your internet connection.'),
                      ),
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        height: 40.0,
                        bottom: 1,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            color: connected ? Colors.green : Colors.indigo,
                            child: connected
                                ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "YOU ARE OFFLINE",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                                : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "YOU ARE OFFLINE",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                SizedBox(
                                  width: 12.0,
                                  height: 12.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return child;
              },
              child: SafeArea(
                top: false,
                child: Stack(
                  children: [
                    Center(
                        child: screens[currentIndex]
                    ),
                    Container(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),

            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: const Color.fromRGBO(86, 126, 239, 15),
              unselectedItemColor: Colors.black,
              showUnselectedLabels: true,
              currentIndex: currentIndex,
              onTap: (index) {
                homeScreenCubit.updateIndex(index);
                SearchCubit searchCubit =BlocProvider.of<SearchCubit>(context);
                searchCubit.searchButtonUnPress();
                searchCubit.searchController.clear();
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
        });
  }
}
