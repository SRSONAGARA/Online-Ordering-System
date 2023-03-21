import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'DrawerScreen.dart';
import 'models/MainData.dart';
import 'models/PlaceOrderData.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController search = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = const Icon(Icons.search);
  Widget CustomText = Text("Online Ordering System");
  List<dynamic> SearchItems = [];
  bool ListEmptyBool = false;
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
      price:120000,
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
      results = ProductData.where((element) => element.productName
          .toString()
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

  Widget CustomProduct() {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    return ListEmptyBool
        ? const Center(
            child: Text(
              "No items match your search...",
              style: TextStyle(fontSize: 15),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              bool isFavourite = favouriteProvider.FavItems.any((element) =>
                  element.productId.contains(ProductData[index].productId));
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
                                  image: AssetImage(SearchItems[index].imgLink),
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
                                      Container(
                                        child: InkWell(
                                          onTap: () {
                                            if (isFavourite == true) {
                                              value.removeItem(
                                                  value.FavItems[index]);
                                            } else {
                                              value.addItem(MainData(
                                                  productId: ProductData[index]
                                                      .productId,
                                                  productName:
                                                      ProductData[index]
                                                          .productName,
                                                  shortDescription:
                                                      ProductData[index]
                                                          .shortDescription,
                                                  price:
                                                      ProductData[index].price,
                                                  imgLink: ProductData[index]
                                                      .imgLink));
                                              // print(value.FavItems[index].productName);
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
                                      ),
                                    ],
                                  );
                                }),
                                Text(
                                  SearchItems[index].productName.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  SearchItems[index]
                                      .shortDescription
                                      .toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text('₹${SearchItems[index].price}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Add To Cart'))
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
            itemCount: SearchItems.length);
  }

  ListView AllProduct() {
    // print('object');
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return ListView.builder(
        itemBuilder: (context, index) {
          bool isFavourite = favouriteProvider.FavItems.any((element) =>
              element.productId.contains(ProductData[index].productId));
          bool itemAddedToCart = cartProvider.CartItems.any((element) =>
              element.productId.contains(ProductData[index].productId));

          return Card(
            elevation: 6,
            // color: Colors.red,
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
                              image: AssetImage(ProductData[index].imgLink),
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
                                      if (isFavourite == true) {
                                        value.removeItem(value.FavItems[index]);
                                      } else {
                                        value.addItem(MainData(
                                            productId:
                                                ProductData[index].productId,
                                            productName:
                                                ProductData[index].productName,
                                            shortDescription: ProductData[index]
                                                .shortDescription,
                                            price: ProductData[index].price,
                                            imgLink:
                                                ProductData[index].imgLink));
                                        // print(value.FavItems[index].productName);
                                      }
                                    },
                                    child: isFavourite
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : const Icon(Icons.favorite_outline,
                                            size: 20),
                                  ),
                                ],
                              );
                            }),
                            Text(
                              ProductData[index].productName.toString(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              ProductData[index].shortDescription.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            Text('₹${ProductData[index].price}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                                          productId:
                                              ProductData[index].productId,
                                          productName:
                                              ProductData[index].productName,
                                          shortDescription: ProductData[index]
                                              .shortDescription,
                                          price: ProductData[index].price,
                                          imgLink: ProductData[index].imgLink, quantity: 1,
                                          // quantity: 1
                                      ));
                                    }

                                  },
                                  style: ElevatedButton.styleFrom( primary: itemAddedToCart ? Colors.red[200]: Colors.blue),
                                  child: itemAddedToCart? Text('Item is already Added')
                                      : Text('Add To Cart'));
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
        itemCount: ProductData.length);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: CustomText,
        leading: SearchButton
            ? IconButton(
                onPressed: () {
                  setState(() {
                    SearchButton = false;
                    CustomSearch = const Icon(Icons.search);
                    CustomText = const Text("Product Screen");
                  });
                },
                icon: const Icon(Icons.arrow_back_outlined))
            : Builder(builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(Icons.menu),
                );
              }),
        actions: ([
          IconButton(
              icon: CustomSearch,
              onPressed: () {
                setState(() {
                  if (CustomSearch.icon == Icons.search) {
                    SearchButton = true;
                    CustomSearch = const Icon(Icons.clear);
                    CustomText = TextField(
                      textInputAction: TextInputAction.go,
                      controller: search,
                      onChanged: (value) => onSearchTextChanged(value),
                      decoration: const InputDecoration(
                          hintText: "Search here...",
                          hintStyle: TextStyle(color: Colors.white),
                          //
                          border: UnderlineInputBorder()),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    search.clear();
                    onSearchTextChanged("");
                  }
                });
              }),
          !SearchButton
              ? IconButton(
                  onPressed: () {}, icon: Icon(Icons.filter_alt_outlined))
              : SizedBox(),
          !SearchButton
              ? InkWell(
                child:  Center(
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
              )
              : SizedBox(),
          SizedBox(
            width: 20,
          )
        ]),
      ),
      body: !SearchButton ? AllProduct() : CustomProduct(),
    );
  }
}
