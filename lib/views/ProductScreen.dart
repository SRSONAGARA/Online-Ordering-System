import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:oline_ordering_system/provider/ApiConnection/ApiConnection_Provider.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:oline_ordering_system/provider/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/ApiConstant.dart';
import '../models/ProductListModelClass.dart';
import 'DrawerScreen.dart';
import '../models/MainData.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isLoading = true;
  List<dynamic> SearchItems = [];

  /*List<Data> data = [];

  Future<List<Data>> getData() async {
    print('function');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jwtToken = preferences.getString('jwtToken') ?? '';
    final api =
        'https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct';
    final header = {"Authorization": 'Bearer $jwtToken'};
    final response = await http.get(Uri.parse(api), headers: header);
    var item = jsonDecode(response.body);
    var product = item['data'];
    print(product);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in product) {
        data.add(Data.fromJson(index));
      }
      return data;
    } else {
      return data;
    }
  }*/

  final List<dynamic> ProductData = [
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

  @override
  void initState() {
    // SearchItems = data;
    super.initState();
    // accessApi(context);
    // getProductData();
  }

  Widget CustomProduct() {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);

    return searchProvider.ListEmptyBool
        ? const Center(
            child: Text(
              "No items match your search...",
              style: TextStyle(fontSize: 15),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              bool isFavourite = favouriteProvider.FavItems.any((element) =>
                  element.productId.contains(SearchItems[index].productId));
              bool itemAddedToCart = cartProvider.CartItems.any((element) =>
                  element.productId.contains(SearchItems[index].productId));
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
                                                  productId: SearchItems[index]
                                                      .productId,
                                                  productName:
                                                      SearchItems[index]
                                                          .productName,
                                                  shortDescription:
                                                      SearchItems[index]
                                                          .shortDescription,
                                                  price:
                                                      SearchItems[index].price,
                                                  imgLink: SearchItems[index]
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
                                Text(
                                  '₹${SearchItems[index].price}',
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
                                            productId:
                                                SearchItems[index].productId,
                                            productName:
                                                SearchItems[index].productName,
                                            shortDescription: SearchItems[index]
                                                .shortDescription,
                                            price: SearchItems[index].price,
                                            imgLink: SearchItems[index].imgLink,
                                            quantity: 1,
                                            // quantity: 1
                                          ));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: itemAddedToCart
                                              ? Colors.red[200]
                                              : Colors.blue),
                                      child: itemAddedToCart
                                          ? Text('Item is already Added')
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
            itemCount: SearchItems.length);
  }

  FutureBuilder AllProduct() {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return FutureBuilder(
        future: apiConnectionProvider.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('snapshot: ${snapshot}');
            return ListView.builder(
                itemBuilder: (context, index) {
                  bool isFavourite = favouriteProvider.FavItems.any((element) =>
                      element.productId.contains(ProductData[index].productId));
                  bool itemAddedToCart = cartProvider.CartItems.any((element) =>
                      element.productId.contains(ProductData[index].productId));

                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/productDetails-screen',
                          arguments: snapshot.data[index]

                          /*{
                          'price': ProductData[index].price.toString(),
                          'productName': ProductData[index].productName,
                          'productId': ProductData[index].productId,
                          'imgLink': ProductData[index].imgLink,
                          'shortDescription': ProductData[index].shortDescription,
                        }*/
                          );
                    },
                    child: Card(
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
                                        image: NetworkImage(
                                          snapshot.data![index].imageUrl,
                                        ),
                                        height: 100,
                                        width: 100,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  /*value.addItem(MainData(
                                                  productId:
                                                      mainData[index].productId,
                                                  productName: mainData[index]
                                                      .productName,
                                                  shortDescription:
                                                      mainData[index]
                                                          .shortDescription,
                                                  price: mainData[index].price,
                                                  imgLink:
                                                      mainData[index].imgLink));*/
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
                                          ],
                                        );
                                      }),
                                      Text(
                                        snapshot.data![index].title,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data![index].description,
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        '\$${snapshot.data![index].price}',
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
                                                /*value.addItem(MainData(
                                              productId:
                                                  ProductData[index].productId,
                                              productName:
                                                  ProductData[index].productName,
                                              shortDescription: ProductData[index]
                                                  .shortDescription,
                                              price: ProductData[index].price,
                                              imgLink: ProductData[index].imgLink,
                                              quantity: 1,
                                              // quantity: 1
                                            ));*/
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: itemAddedToCart
                                                    ? Colors.red[200]
                                                    : Colors.blue),
                                            child: itemAddedToCart
                                                ? Text('Item is already Added')
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
                    ),
                  );
                },
                itemCount: snapshot.data?.length);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MyDrawer(),
        appBar: AppBar(
          title: searchProvider.CustomText,centerTitle: true,
          leading: Consumer<SearchProvider>(builder: (context, value, child) {
            return searchProvider.SearchButton
                ? IconButton(
                    onPressed: () {
                      value.searchButtonPress();
                    },
                    icon: const Icon(Icons.arrow_back_outlined))
                : Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(Icons.menu),
                    );
                  });
          }),
          actions: ([
            IconButton(
                icon: searchProvider.CustomSearch,
                onPressed: () {
                  if (searchProvider.CustomSearch.icon == Icons.search) {
                    searchProvider.SearchButton = true;
                    searchProvider.CustomSearch =
                        const Icon(Icons.clear_outlined);
                    searchProvider.CustomText = TextField(
                      textInputAction: TextInputAction.go,
                      controller: searchProvider.search,
                      onChanged: (value) {
                        List<dynamic> results = [];
                        if (value.isEmpty) {
                          results = ProductData;
                        } else {
                          results = ProductData.where((element) => element
                              .productName
                              .toString()
                              .toLowerCase()
                              .contains(value.toString())).toList();
                        }

                        if (results.isEmpty) {
                          searchProvider.searchListIsEmpty();
                          // ListEmptyBool = true;
                        } else {
                          // ListEmptyBool = false;
                          searchProvider.searchListIsNotEmpty();
                        }
                        SearchItems = results!;
                      },
                      decoration: const InputDecoration(
                        hintText: "Search for products",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ), /*border: UnderlineInputBorder()*/
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    );
                    searchProvider.notifyListeners();
                  } else {
                    searchProvider.search.clear();
                    searchProvider.searchButtonUnPress();
                    // onSearchTextChanged("");
                  }
                  // });
                }),
            !searchProvider.SearchButton
                ? IconButton(
                    onPressed: () {}, icon: Icon(Icons.filter_alt_outlined))
                : SizedBox(),
            !searchProvider.SearchButton
                ? InkWell(
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
                    })
                : SizedBox(),
            SizedBox(
              width: 20,
            )
          ]),
        ),
        body: !searchProvider.SearchButton ? AllProduct() : CustomProduct());
  }
}
