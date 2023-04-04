import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/placeOrder_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../common/ApiConstant.dart';
import '../models/ConfirmOrderModelClass.dart';
import '../models/MainData.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  var size, height, width;
  Widget CustomText = Text("My Orders");
  bool ListEmptyBool = false;
  List<dynamic> ProductData = [
    MainData(
      productId: '1001',
      imgLink: 'assets/Products/iphone11.png',
      productName: 'Iphone 11 pro max',
      shortDescription: 'Deep Purple',
      price: 110000,
    ),
    MainData(
      productId: '1002',
      imgLink: 'assets/Products/iphone12.jpg',
      productName: 'Iphone 12 pro max',
      shortDescription: 'Deep Purple',
      price: 120000,
    ),
    MainData(
      productId: '1003',
      imgLink: 'assets/Products/iphone13.jpg',
      productName: 'Iphone 13 pro max',
      shortDescription: 'Deep Purple',
      price: 130000,
    ),
    MainData(
      productId: '1004',
      imgLink: 'assets/Products/iphone14.jpg',
      productName: 'Iphone 14 pro max',
      shortDescription: 'Deep Purple',
      price: 140000,
    ),
    MainData(
      productId: '1005',
      imgLink: 'assets/Products/iphone15.jpeg',
      productName: 'Iphone 15 pro max',
      shortDescription: 'Deep Purple',
      price: 150000,
    ),
    MainData(
      productId: '1006',
      imgLink: 'assets/Products/iphone16.jpeg',
      productName: 'Iphone 16 pro max',
      shortDescription: 'Deep Purple',
      price: 160000,
    ),
  ];

  List<dynamic> confirmOrderList=[];
  Future<void> getOrderHistory()async{
    print('getOrderHistory');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    const url = ApiConstant.getOrderHistoryApi;
    final header = {"Authorization": 'Bearer $jwtToken'};
    final response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      setState(() {
        confirmOrderList = [ConfirmOrderList.fromJson(jsonDecode(response.body))];
      });
      print(confirmOrderList);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderHistory();
  }


  Widget AllProduct() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final placeOrderProvider = Provider.of<PlaceOrderProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return confirmOrderList.isEmpty
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
/*              bool itemAddedToCart = cartProvider.CartItems.any((element) =>
                  element.productName.contains(
                      placeOrderProvider.PlaceOrderItmes[index].productName));*/
              // bool itemAddedToCart = confirmOrderList[0].data![index].quantity != 0;
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
                                  image: NetworkImage(confirmOrderList[0].data![index].imageUrl),
                                  height: 120,
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
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: AutoSizeText(
                                          'Order Place Date:- ${confirmOrderList[0].data![index].updatedAt}',
                                          style: TextStyle(fontSize: 10),
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                 confirmOrderList[0].data![index].title,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  confirmOrderList[0].data![index].description,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${confirmOrderList[0].data![index].productTotalAmount}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Total quantity: ${confirmOrderList[0].data![index].quantity}',
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
                                        Navigator.of(context).pushReplacementNamed('/home-screen');
                                        /*if (itemAddedToCart == true) {
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
                                        }*/
                                      },
                                      style: ElevatedButton.styleFrom( primary: /*itemAddedToCart ? Colors.red[200]:*/ Colors.blue),
                                      child: /*itemAddedToCart? Text('Item is already Added')
                                          :*/ Text('Re Order'));
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
            itemCount: confirmOrderList[0].data?.length);
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
