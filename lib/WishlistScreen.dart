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
  Widget CustomText = Text("Wishlist Screen");
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
      price: '₹110000',
    ),
    MainData(
      productId: '1002',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 12 pro max',
      shortDescription: 'Deep Purple',
      price: '₹120000',
    ),
    MainData(
      productId: '1003',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 13 pro max',
      shortDescription: 'Deep Purple',
      price: '₹130000',
    ),
    MainData(
      productId: '1004',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 14 pro max',
      shortDescription: 'Deep Purple',
      price: '₹110000',
    ),
    MainData(
      productId: '1005',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 15 pro max',
      shortDescription: 'Deep Purple',
      price: '₹120000',
    ),
    MainData(
      productId: '1006',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 16 pro max',
      shortDescription: 'Deep Purple',
      price: '₹130000',
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

  Widget CustomProduct() {
    FavouriteProvider favoriteProvider =
        Provider.of<FavouriteProvider>(context);
    return ListEmptyBool
        ? const Center(
            child: Text(
              "No items match your search...",
              style: TextStyle(fontSize: 15),
            ),
          )
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FavoriteButton(
                                      iconSize: 20,
                                      isFavorite: false,
                                      valueChanged: (_isFavorite) {},
                                    ),
                                  ],
                                ),
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
                                  SearchItems[index].price.toString(),
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



  Widget AllProduct() {
    final cartProvider = Provider.of<CartProvider>(context);
    FavouriteProvider favoriteProvider =
        Provider.of<FavouriteProvider>(context);
    return favoriteProvider.FavItems.isEmpty ? Center(  child: Container(child:Image.asset('assets/wishlistEmpty.png') )):

    // Text('Your WishList is Empty.')
      ListView.builder(
      itemBuilder: (context, index) {

        bool itemAddedToCart = cartProvider.CartItems.any((element) =>
            element.productId.contains(favoriteProvider.FavItems[index].productId));

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
                            favoriteProvider.FavItems[index].shortDescription,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            favoriteProvider.FavItems[index].price,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Consumer<CartProvider>(builder: (context,value, child){
                            return ElevatedButton(
                                onPressed: () {
                                  print(value.CartItems.length);
                                  if (itemAddedToCart == true) {
                                    // value.removeItem(value.CartItems[index]);
                                  } else {
                                    value.addItem(MainData(
                                        productId:
                                        favoriteProvider.FavItems[index].productId,
                                        productName:
                                        favoriteProvider.FavItems[index].productName,
                                        shortDescription: favoriteProvider.FavItems[index]
                                            .shortDescription,
                                        price: favoriteProvider.FavItems[index].price,
                                        imgLink: favoriteProvider.FavItems[index].imgLink));
                                  }

                                },
                                style: ElevatedButton.styleFrom( primary: itemAddedToCart ? Colors.red[200]: Colors.blue),
                                child: itemAddedToCart? Text('Item is already Added')
                                    : Text('Add To Cart'));
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
    FavouriteProvider favoriteProvider =
        Provider.of<FavouriteProvider>(context);
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
                    CustomText = const Text("Wishlist Screen");
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
                // AllData(context);
              }),
          !SearchButton
              ? IconButton(
                  onPressed: () {}, icon: Icon(Icons.filter_alt_outlined))
              : SizedBox(),
        ]),
      ),
      body: !SearchButton ? AllProduct() : CustomProduct(),

      // body:WishListIsEmpty?Text('Empty'):AllProduct(),
    );
  }
}
