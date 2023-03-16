import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import 'DrawerScreen.dart';
import 'models/MainData.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController search = TextEditingController();
  bool SearchButton = false;
  Icon CustomSearch = const Icon(Icons.search);
  Widget CustomText = Text("Cart Screen");
  List<dynamic> SearchItems = [];
  bool ListEmptyBool = false;
  // var total=0;
  // void increment(int Price)=>ProductData[Price];
  // void decrement(int Price)=>ProductData[Price];

  int counter=0;

  List<dynamic> ProductData = [
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
                                  valueChanged: (_isFavorite) {},
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
            ),
          );
        },
        itemCount: SearchItems.length);
  }

  Widget AllProduct() {
    final cartProvider=Provider.of<CartProvider>(context);
    return cartProvider.CartItems.isEmpty?Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(child: Image.asset('assets/cartEmpty.png'),),
        SizedBox(height: 20,),
        Text('Oops...!',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
        Text('Your Cart list is currently empty')
      ],
    )):

      ListView.builder(
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
                              image: AssetImage(cartProvider.CartItems[index].imgLink),
                              height: 100,
                              width: 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:<Widget> [
                                counter!=0? IconButton(onPressed: (){
                                  setState(() {
                                    counter--;
                                    // decrement(ProductData[index].Price);
                                  });
                                }, icon: Icon(Icons.remove)): Container(),
                                Text('$counter',style: TextStyle(fontSize: 20),),
                                IconButton(onPressed: (){
                                  setState(() {
                                    counter++;
                                    // increment(ProductData[index].Price);
                                  });
                                }, icon: Icon(Icons.add))
                              ],
                            )
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
                              cartProvider.CartItems[index].productName.toString(),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              cartProvider.CartItems[index].shortDescription.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              cartProvider.CartItems[index].price.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Consumer<CartProvider>(builder: (context, vlaue,child){
                                  return InkWell(
                                    child: Icon(Icons.delete_forever),
                                    onTap: (){
                                      cartProvider.removeItem(cartProvider.CartItems[index]);
                                    },
                                  );
                                }),

                                SizedBox(width: 15,),
                                ElevatedButton(
                                    onPressed: () {

                                    }, child: Text('Place Order'))
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
        itemCount: cartProvider.CartItems.length);
  }

  @override
  Widget build(BuildContext context) {
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
                CustomText = const Text("Cart Screen");
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
        ]),
      ),
      body: !SearchButton ? AllProduct() : CustomProduct(),
      // body: AllProduct(),
    );
  }
}
