import 'dart:convert';

import 'package:badges/badges.dart' as Badge;
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import '../common/ApiConstant.dart';
import '../models/WatchListModelClass.dart';
import '../provider/ApiConnection/ApiConnection_Provider.dart';
import 'DrawerScreen.dart';
import '../models/MainData.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  var size, height, width;
  Widget CustomText = Text(
    "Wishlist",
  );
  List<int> FavItems = [];

  final List<dynamic> ProductData = [
    MainData(
      productId: '1001',
      imgLink: 'assets/iphone14.jpg',
      productName: 'Iphone 11 pro max',
      shortDescription: 'Deep Purple',
      price: 110000,
    ),
    MainData(
      productId: '1002',
      imgLink: 'assets/iphone14.jpg',
      productName: 'Iphone 12 pro max',
      shortDescription: 'Deep Purple',
      price: 120000,
    ),
    MainData(
      productId: '1003',
      imgLink: 'assets/iphone14.jpg',
      productName: 'Iphone 13 pro max',
      shortDescription: 'Deep Purple',
      price: 130000,
    ),
    MainData(
      productId: '1004',
      imgLink: 'assets/iphone14.jpg',
      productName: 'Iphone 14 pro max',
      shortDescription: 'Deep Purple',
      price: 110000,
    ),
    MainData(
      productId: '1005',
      imgLink: 'assets/iphone14.jpg',
      productName: 'Iphone 15 pro max',
      shortDescription: 'Deep Purple',
      price: 120000,
    ),
    MainData(
      productId: '1006',
      imgLink: 'assets/iphone14.jpg',
      productName: 'Iphone 16 pro max',
      shortDescription: 'Deep Purple',
      price: 130000,
    ),
  ];

  @override
  void initState() {
    super.initState();
    getWatchList();
  }


  List<dynamic> watchList = [];
  Future<void> getWatchList() async {
    print('MyWatchlist');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    const url = ApiConstant.getWatchListApi;
    final header = {"Authorization": 'Bearer $jwtToken'};
    final response = await http.get(Uri.parse(url), headers: header);
    var item = jsonDecode(response.body);
    var empty=item['msg'];
    var product = item['data'];
    print(product);

    if (response.statusCode == 200) {
        setState(() {
          watchList = [GetWatchList.fromJson(jsonDecode(response.body))];
        });
        print(watchList);

    }/* else if (response.statusCode == 400) {
      watchList = [GetWatchList.fromJson(jsonDecode(response.body))];
    }*/
  }

  Widget AllProduct() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    final cartProvider = Provider.of<CartProvider>(context);
    final favoriteProvider = Provider.of<FavouriteProvider>(context);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);
    return watchList.length==0
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 5,
              ),
              Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/wishlistEmptyImage.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Oops...!',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text("You haven't added any products yet",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Click "),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 15,
                  ),
                  Text(
                    " to save products",
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/home-screen");
                  },
                  child: Text('Find items to save')),
            ],
          ))
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              print('list builder');
              bool itemAddedToCart = cartProvider.CartItems.any((element) =>
                  element.productId
                      .contains(favoriteProvider.FavItems[index].productId));

              return Card(
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Image(
                                  image: NetworkImage(watchList[0]
                                      .data![index]
                                      .productDetails
                                      .imageUrl),
                                  height: 120,
                                  // width: 100,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        String wathListItemId =
                                            watchList[0].data![index].id;
                                        apiConnectionProvider
                                            .removeFromWatchList(
                                                wathListItemId);
                                        print('Id: ${wathListItemId}');
                                        getWatchList();
                                        /*favoriteProvider.removeItem(
                                                favoriteProvider.FavItems[index]);*/
                                      },
                                      child: Icon(Icons.favorite,
                                          color: Colors.red, size: 20),
                                    ),
                                  ],
                                ),
                                Text(
                                  watchList[0]
                                      .data![index]
                                      .productDetails
                                      .title,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  watchList[0]
                                      .data![index]
                                      .productDetails
                                      .description,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '\$${watchList[0].data![index].productDetails.price}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Consumer<CartProvider>(
                                    builder: (context, value, child) {
                                  return ElevatedButton(
                                      onPressed: () {
                                        print(value.CartItems.length);
                                        if (itemAddedToCart == true) {
                                          // value.removeItem(value.CartItems[index]);
                                        } else {
                                          value.addItem(MainData(
                                              productId: favoriteProvider
                                                  .FavItems[index].productId,
                                              productName: favoriteProvider
                                                  .FavItems[index].productName,
                                              shortDescription: favoriteProvider
                                                  .FavItems[index]
                                                  .shortDescription,
                                              price: favoriteProvider
                                                  .FavItems[index].price,
                                              imgLink: favoriteProvider
                                                  .FavItems[index].imgLink));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: itemAddedToCart
                                              ? Colors.red[200]
                                              : Colors.blue),
                                      child: itemAddedToCart
                                          ? const Text('Item is already Added')
                                          : const Text('Add To Cart'));
                                }),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: watchList[0].data.length,
          );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    FavouriteProvider favoriteProvider =
        Provider.of<FavouriteProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/home-screen');
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
        actions: [
          InkWell(
              child: Center(
                child: Badge.Badge(
                  badgeContent: Text(
                    cartProvider.CartItems.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/cart-screen');
              }),
          SizedBox(
            width: 20,
          )
        ],
      ),
      // body: !SearchButton ? AllProduct() : CustomProduct(),
      body: SingleChildScrollView(child: AllProduct()),
    );
  }
}
