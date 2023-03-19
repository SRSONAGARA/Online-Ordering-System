

import 'package:badges/badges.dart' as Badge;
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'DrawerScreen.dart';
import 'models/MainData.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  TextEditingController search = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = const Icon(Icons.search);
  Widget CustomText = Text("Wishlist",);
  List<dynamic> SearchItems = [];
  List<int> FavItems = [];
  bool ListEmptyBool = false;
  // bool WishListIsEmpty=true;
  final List<dynamic> ProductData = [
    MainData(
      productId: '1001',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 11 pro max',
      shortDescription: 'Deep Purple',
      price: 110000,
    ),
    MainData(
      productId: '1002',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 12 pro max',
      shortDescription: 'Deep Purple',
      price: 120000,
    ),
    MainData(
      productId: '1003',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 13 pro max',
      shortDescription: 'Deep Purple',
      price: 130000,
    ),
    MainData(
      productId: '1004',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 14 pro max',
      shortDescription: 'Deep Purple',
      price: 110000,
    ),
    MainData(
      productId: '1005',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 15 pro max',
      shortDescription: 'Deep Purple',
      price: 120000,
    ),
    MainData(
      productId: '1006',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 16 pro max',
      shortDescription: 'Deep Purple',
      price: 130000,
    ),
  ];

  @override
  void initState() {
    //  SearchItems = ProductData;
    SearchItems = ProductData;
    super.initState();
  }

  void onSearchTextChanged(String text) {
    List<dynamic> results = [];
    if (text.isEmpty) {
      results = ProductData;
    } else {
      results = ProductData.where((element) => element.ProductName.toString()
          .toLowerCase()
          .contains(text.toString())).toList();
    }

    setState(() {
      if (results.isEmpty) {
        ListEmptyBool = true;
      } else {
        ListEmptyBool = false;
      }
      SearchItems = results!;
    });
  }

  Widget AllProduct() {
    final cartProvider = Provider.of<CartProvider>(context);
    FavouriteProvider favoriteProvider =
        Provider.of<FavouriteProvider>(context);
    return favoriteProvider.FavItems.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/shopcart-box.png'),
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
            itemBuilder: (context, index) {
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
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                      favoriteProvider.FavItems[index].imgLink),
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<FavouriteProvider>(
                                    builder: (context, value, child) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          favoriteProvider.removeItem(
                                              favoriteProvider.FavItems[index]);
                                        },
                                        child: Icon(Icons.favorite,
                                            color: Colors.red, size: 20),
                                      ),
                                    ],
                                  );
                                }),
                                Text(
                                  favoriteProvider.FavItems[index].productName,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  favoriteProvider
                                      .FavItems[index].shortDescription,
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '₹${favoriteProvider.FavItems[index].price}',
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
            itemCount: favoriteProvider.FavItems.length,
            // itemCount: ProductData.length
          );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider=Provider.of<CartProvider>(context);
    FavouriteProvider favoriteProvider =
        Provider.of<FavouriteProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText, centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed('/home-screen');
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
              onTap: (){
              Navigator.pushNamed(context, '/cart-screen');
              }
          ),
          SizedBox(width: 20,)
        ],

      ),
      // body: !SearchButton ? AllProduct() : CustomProduct(),
      body: AllProduct(),
    );
  }
}
