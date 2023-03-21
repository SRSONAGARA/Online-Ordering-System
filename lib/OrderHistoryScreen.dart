import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/placeOrder_provider.dart';
import 'package:provider/provider.dart';

import 'models/MainData.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  var size, height, width;

  TextEditingController search = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = const Icon(Icons.search);
  Widget CustomText = Text("My Orders");
  List<dynamic> SearchItems = [];
  bool ListEmptyBool = false;
  List<dynamic> ProductData = [
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
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final placeOrderProvider = Provider.of<PlaceOrderProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return placeOrderProvider.PlaceOrderItmes.isEmpty
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
                child: Image.asset('assets/OrderEmptyImage.png'),
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
              Text(
                "You didn't place any Order till now !",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ))
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              bool itemAddedToCart = cartProvider.CartItems.any((element) =>
                  element.productName.contains(
                      placeOrderProvider.PlaceOrderItmes[index].productName));
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
                                  image: AssetImage(placeOrderProvider
                                      .PlaceOrderItmes[index].imgLink),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: AutoSizeText(
                                          'Order Place Date:- ${placeOrderProvider.PlaceOrderItmes[index].dateTime}',
                                          style: TextStyle(fontSize: 10),
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  placeOrderProvider
                                      .PlaceOrderItmes[index].productName
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  placeOrderProvider
                                      .PlaceOrderItmes[index].shortDescription
                                      .toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹${placeOrderProvider.PlaceOrderItmes[index].price}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Total quantity: ${placeOrderProvider.PlaceOrderItmes[index].quantity}',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<CartProvider>(builder: (context,value,child){
                                  return ElevatedButton(
                                      onPressed: () {
                                        if (itemAddedToCart == true) {
                                          // value.removeItem(value.CartItems[index]);
                                        } else {
                                          value.addItem(MainData(
                                            productId:
                                            ProductData[index].productId,
                                            productName:
                                            ProductData[index].productName,
                                            shortDescription: ProductData[index]
                                                .shortDescription,
                                            price: ProductData[index].price,
                                            imgLink: ProductData[index].imgLink,
                                          quantity: 1
                                          ));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom( primary: itemAddedToCart ? Colors.red[200]: Colors.blue),
                                      child: itemAddedToCart? Text('Item is already Added')
                                          : Text('Re Order'));
                                })
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
            itemCount: placeOrderProvider.PlaceOrderItmes.length);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
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
            },
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(child: AllProduct()),
      // body: !SearchButton ? AllProduct() : CustomProduct(),
    );
  }
}

class Product {
  String ImgLink;
  String ProductName;
  String ShortDescription;
  String Price;

  Product({
    required this.ImgLink,
    required this.ProductName,
    required this.ShortDescription,
    required this.Price,
  });
}
