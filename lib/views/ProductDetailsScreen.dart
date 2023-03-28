import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as Badge;
import '../models/MainData.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var size;
  Map<String, dynamic> argument = {};
  Widget CustomText = Text("Product Details Screen");
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      argument =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool isFavourite = favouriteProvider.FavItems.any(
        (element) => element.productName.contains(argument!['productName']));
    bool itemAddedToCart = cartProvider.CartItems.any(
        (element) => element.productName.contains(argument!['productName']));
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: CustomText,
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
                  badgeContent: Text(cartProvider.CartItems.length.toString()),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/cart-screen');
              }),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.white,
                          height: size.height / 2,
                          width: size.width,
                          child: Image(
                            image: AssetImage(argument!['imgLink']),
                            width: size.width / 2,
                            height: size.height / 2,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                if (isFavourite == true) {
                                  favouriteProvider.removeItem(favouriteProvider
                                      .FavItems[argument!['index']]);
                                } else {
                                  // favouriteProvider.addItem(MainData(
                                  //     productId: argument!['productId'],
                                  //     productName: argument!['productName'],
                                  //     shortDescription:
                                  //         argument!['shortDescription'],
                                  //     price: argument!['price'],
                                  //     imgLink: argument!['imgLink']));
                                  // print(value.FavItems[index].productName);
                                }
                              },
                              child: isFavourite
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    )
                                  : const Icon(Icons.favorite_outline, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(children: [
                      Text(
                        argument!['productName'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      children: [Text(argument!['shortDescription'])],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: isLoading
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text('₹${argument!['price']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  )),
                  Expanded(
                    child: Consumer<CartProvider>(builder: (context, value, child) {
                      return ElevatedButton(
                          onPressed: () {
                            print(value.CartItems.length);
                            if (itemAddedToCart == true) {
                              // value.removeItem(value.CartItems[index]);
                            } else {
                              cartProvider.addItem(MainData(
                                productId: argument!['productId'],
                                productName: argument!['productName'],
                                shortDescription: argument!['shortDescription'],
                                price: argument!['price'],
                                imgLink: argument!['imgLink'],
                                quantity: 1,
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
                    }),
                  )
                ],
              ),
            ),
    );
  }
}
