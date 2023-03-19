import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/placeOrder_provider.dart';
import 'package:provider/provider.dart';

import 'DrawerScreen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  TextEditingController search = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = const Icon(Icons.search);
  Widget CustomText = Text("My Orders");
  List<dynamic> SearchItems = [];
  bool ListEmptyBool = false;
  List<dynamic> ProductData = [
    Product(
      ImgLink: 'assets/ProductImage.jpg',
      ProductName: 'Iphone 11 pro max',
      ShortDescription: 'Deep Purple',
      Price: '₹110000',
    ),
    Product(
      ImgLink: 'assets/ProductImage.jpg',
      ProductName: 'Iphone 12 pro max',
      ShortDescription: 'Deep Purple',
      Price: '₹120000',
    ),
    Product(
      ImgLink: 'assets/ProductImage.jpg',
      ProductName: 'Iphone 13 pro max',
      ShortDescription: 'Deep Purple',
      Price: '₹130000',
    ),
    Product(
      ImgLink: 'assets/ProductImage.jpg',
      ProductName: 'Iphone 14 pro max',
      ShortDescription: 'Deep Purple',
      Price: '₹110000',
    ),
    Product(
      ImgLink: 'assets/ProductImage.jpg',
      ProductName: 'Iphone 15 pro max',
      ShortDescription: 'Deep Purple',
      Price: '₹120000',
    ),
    Product(
      ImgLink: 'assets/ProductImage.jpg',
      ProductName: 'Iphone 16 pro max',
      ShortDescription: 'Deep Purple',
      Price: '₹130000',
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
    final placeOrderProvider = Provider.of<PlaceOrderProvider>(context);
    return placeOrderProvider.PlaceOrderItmes.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              Text("You didn't place any Order till now !", style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ))
        : ListView.builder(
            itemBuilder: (context, index) {
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
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Re Order'))
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText,centerTitle: true,
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
                  '0',
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(Icons.shopping_cart_outlined),
              ),
            ),
            onTap: (){},
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: AllProduct(),
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
