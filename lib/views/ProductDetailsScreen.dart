import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oline_ordering_system/models/ProductListModelClass.dart';
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
  // Map<String, dynamic> argument = {};
  Widget CustomText = Text("Product Details Screen");
  bool isLoading = true;
  late Data argument;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      argument = ModalRoute.of(context)!.settings.arguments as Data;
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
    // bool isFavourite = favouriteProvider.FavItems.any(
    //     (element) => element.productName.contains(argument!['productName']));
    // bool itemAddedToCart = cartProvider.CartItems.any(
    //     (element) => element.productName.contains(argument!['productName']));
    size = MediaQuery.of(context).size;
    return Scaffold(
      /*appBar: AppBar(
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
      ),*/
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed('/home-screen');
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: InkWell(
                              child: Center(
                                child: Badge.Badge(
                                  badgeContent: Text(cartProvider.CartItems.length.toString()),
                                  child: Icon(Icons.shopping_cart_outlined, color: Colors.black,),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/cart-screen');
                              }),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.white,
                          height: size.height / 2,
                          width: size.width,
                          child: Image(
                            image: NetworkImage(argument.imageUrl),
                            width: size.width / 2,
                            height: size.height / 2,
                          ),
                        ),

                        /*Padding(
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
                        ),*/
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  Container(
                    height: size.height / 2,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(children: [
                            Flexible(
                              child: Text(
                                argument!.title,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.blue,
                                size: 5,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                argument!.description,
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: isLoading
          ? SizedBox()
          : Container(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                      child: Text('\$${argument!.price}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  Expanded(
                      child: Container(
                    color: Colors.blue,
                    child: TextButton(
                      // style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ))

                  /*Expanded(
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
                )*/
                ],
              ),
            ),
    );
  }
}
