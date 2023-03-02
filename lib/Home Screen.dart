import 'dart:ffi';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = const Icon(Icons.search);
  Widget CustomText = Text("Product Screen");
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
  ];
  int currentIndex=0;

  final tabs=[
    Navigator.pushNamed(context, '/product-screen'),

  ]

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

  Widget CustomProduct() {
    return ListEmptyBool
        ? const Center(
            child: Text(
              "No items match your search...",
              style: TextStyle(fontSize: 15),
            ),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(SearchItems[index].ImgLink),
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
                                  FavoriteButton(
                                    iconSize: 20,
                                    isFavorite: false,
                                    valueChanged: (_isFavorite) {
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                SearchItems[index].ProductName.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                SearchItems[index].ShortDescription.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                SearchItems[index].Price.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                  onPressed: () {}, child: Text('Add To Cart'))
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemCount: SearchItems.length);
  }

  ListView AllProduct() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(ProductData[index].ImgLink),
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
                              FavoriteButton(
                                iconSize: 20,
                                isFavorite: false,
                                valueChanged: (_isFavorite) {
                                  // print('Is Favorite : $_isFavorite');
                                },
                              ),
                            ],
                          ),
                          Text(
                            ProductData[index].ProductName.toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            ProductData[index].ShortDescription.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            ProductData[index].Price.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Text('Add To Cart'))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: ProductData.length);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
            : Container(),
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
        ]),
      ),
      body: !SearchButton ? AllProduct() : CustomProduct(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
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
              icon: Icon(Icons.person_rounded),
              label: 'Account'
          ),
          // BottomNavigationBarItem(icon: Icon(Icons.card_travel)),
        ],
      ),
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
