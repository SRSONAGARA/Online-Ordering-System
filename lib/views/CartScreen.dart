import 'dart:convert';

import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/models/PlaceOrderData.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:oline_ordering_system/provider/placeOrder_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../common/ApiConstant.dart';
import '../models/CartListModelClass.dart';
import '../provider/ApiConnection/ApiConnection_Provider.dart';
import '../models/MainData.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var size, height, width;
  Widget CustomText = Text("My Cart");
  bool ListEmptyBool = false;

  // var total=0;
  // void increment(int Price)=>ProductData[Price];
  // void decrement(int Price)=>ProductData[Price];

  int counter = 0;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    getMyCart();
  }

  List<dynamic> ProductData = [
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
  List<dynamic> cart = [];

  Future<void> getMyCart() async {
    print('getMyCart');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    const url = ApiConstant.getMyCartApi;
    final header = {"Authorization": 'Bearer $jwtToken'};
    final response = await http.get(Uri.parse(url), headers: header);
    var item = jsonDecode(response.body);
    var product = item['data'];
    print(product);

    if (response.statusCode == 200) {
      setState(() {
        cart = [GetMyCart.fromJson(jsonDecode(response.body))];
      });
      print(cart);
    }
  }

  Future<void> increaseProductQuantity(String cartItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    try {
      String url = ApiConstant.increaseProductQuantityApi;
      var requestBody = {"cartItemId": cartItemId};
      print(url);
      print(requestBody);
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
          await http.post(Uri.parse(url), headers: header, body: requestBody);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print('product Quantity increased');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('ApiConnection_Provider.increaseProductQuantity: $error');
    }
    // notifyListeners();
  }

  Future<void> decreaseProductQuantity(String cartItemId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    try {
      String url = ApiConstant.decreaseProductQuantityApi;
      var requestBody = {"cartItemId": cartItemId};
      print(url);
      print(requestBody);
      final header = {"Authorization": 'Bearer $jwtToken'};
      final response =
          await http.post(Uri.parse(url), headers: header, body: requestBody);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
        print('product Quantity decreased');
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody);
      }
    } catch (error) {
      print('ApiConnection_Provider.decreaseProductQuantity: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favoriteProvider = Provider.of<FavouriteProvider>(context);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: MyDrawer(),
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
                  favoriteProvider.FavItems.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: const Icon(Icons.favorite_outline),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/wishlist-screen');
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      // body: !SearchButton ? AllProduct() : CustomProduct(),
      body: SingleChildScrollView(child: AllProduct()),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
              'Total Items: ${cart.isEmpty ? 0 : cart[0].data!.length}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
            Expanded(
                child: Text(
              'Total Price: \$${cart.isEmpty ? 0 : cart[0].cartTotal}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                for(int index =0;
                index < cart[0].data.length;
                index++){
                  print('pressed');
                  String cartId=cart[0].data![index].cartId.toString();
                  String cartTotal=cart[0].cartTotal.toString();
                  print('cartId= $cartId');
                  print('cartTotal= $cartTotal');
                  apiConnectionProvider.placeOrder(cartId, cartTotal);
                }
              },
             /* onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return cartProvider.CartItems.isNotEmpty
                        ? AlertDialog(
                            title: const Text("Confirm to Place Order"),
                            content: Text(
                                "You added ${cartProvider.allItemCount()} Product and Total Price ${cartProvider.allItemPrice()}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Not Now'),
                              ),
                              Consumer<PlaceOrderProvider>(
                                  builder: (context, value, child) {
                                return TextButton(
                                    child: const Text('Place Order'),
                                    onPressed: () {
                                      print('pressed');
                                      String cartId=apiConnectionProvider.cart[0].cartId;
                                      String cartTotal=cart[0].cartTotal.toString();
                                      apiConnectionProvider.placeOrder(cartId, cartTotal);

                                      *//*setState(() {
                                        for (int index = 0;
                                            index <
                                                cartProvider.CartItems.length;
                                            index++) {
                                          value.placeItem(PlaceOrderData(
                                              price: cartProvider
                                                      .CartItems[index].price *
                                                  cartProvider.CartItems[index]
                                                      .quantity,
                                              productName: cartProvider
                                                  .CartItems[index].productName,
                                              shortDescription: cartProvider
                                                  .CartItems[index]
                                                  .shortDescription,
                                              imgLink: cartProvider
                                                  .CartItems[index].imgLink,
                                              quantity: cartProvider
                                                  .CartItems[index].quantity,
                                              dateTime: DateTime.now()));
                                        }
                                        cartProvider.cleanCartItem();
                                        Navigator.pop(context);
                                      });*//*
                                    });
                              })
                            ],
                          )
                        : AlertDialog(
                            title: const Text("No Items Added in Cart"),
                            content: const Text("Please add item in cart"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Not Now'),
                              ),
                              TextButton(
                                  child: const Text('Okay'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ],
                          );
                  },
                );
              },*/
              child: Container(
                // height: size.height / 15,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                height: 30,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 37, 150, 190),
                      Colors.pinkAccent
                    ])),
                child: const Center(
                    child: Text(
                  "Place Order ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
      // body: AllProduct(),
    );
  }

  Widget AllProduct() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    final cartProvider = Provider.of<CartProvider>(context);
    final favoriteProvider = Provider.of<FavouriteProvider>(context);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return cart.length == 0
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 7,
              ),
              Container(
                child: Image.asset('assets/cartEmpty.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Oops...!',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              const Text('Your Cart is empty !',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
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
              bool isFavourite = favoriteProvider.FavItems.any((element) =>
                  element.productName
                      .contains(cartProvider.CartItems[index].productName));

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
                                  image: NetworkImage(cart[0]
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
                                    Consumer<FavouriteProvider>(
                                        builder: (context, value, child) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (isFavourite == true) {
                                                value.removeItem(
                                                    value.FavItems[index]);
                                              } else {
                                                value.addItem(MainData(
                                                    productId: cartProvider
                                                        .CartItems[index]
                                                        .productId,
                                                    productName: cartProvider
                                                        .CartItems[index]
                                                        .productName,
                                                    shortDescription:
                                                        cartProvider
                                                            .CartItems[index]
                                                            .shortDescription,
                                                    price: cartProvider
                                                        .CartItems[index].price,
                                                    imgLink: cartProvider
                                                        .CartItems[index]
                                                        .imgLink));
                                              }
                                            },
                                            child: isFavourite
                                                ? const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                    size: 20,
                                                  )
                                                : const Icon(
                                                    Icons.favorite_outline,
                                                    size: 20),
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                                Text(
                                  cart[0].data![index].productDetails.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  cart[0]
                                      .data![index]
                                      .productDetails
                                      .description,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  '\$${cart[0].data![index].itemTotal}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Consumer<CartProvider>(
                                            builder: (context, value, child) {
                                          return InkWell(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                                color: Colors.grey,
                                              ),
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 10.0),
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.delete_forever),
                                                  Text('Remove')
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              String cartItemId =
                                                  cart[0].data![index].id;
                                              apiConnectionProvider
                                                  .removeProductFromCart(
                                                      cartItemId);
                                              getMyCart();
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  if (cart[0]
                                                          .data![index]
                                                          .quantity >
                                                      1) {
                                                    String cartItemId =
                                                        cart[0].data![index].id;
                                                    await decreaseProductQuantity(
                                                        cartItemId);
                                                    getMyCart();
                                                  }
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  radius: 14,
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                cart[0]
                                                    .data![index]
                                                    .quantity
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await increaseProductQuantity(
                                                      cart[0].data![index].id);
                                                  getMyCart();
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  radius: 14,
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
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
            itemCount: cart[0].data!.length);
  }
}
