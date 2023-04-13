import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oline_ordering_system/models/ProductListModelClass.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as Badge;
import '../provider/ApiConnection/ApiConnection_Provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var size;
  Widget CustomText = const Text("Product Details Screen");
  bool isLoading = true;
  late Data argument;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () {
      argument = ModalRoute.of(context)!.settings.arguments as Data;
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late String watchListItemId = argument.watchListItemId.toString();
    late String cartItemId = argument.cartItemId.toString();
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    bool isFavourite = watchListItemId != '';
    bool itemAddedToCart = cartItemId != '';
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // title: CustomText,
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
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/cart-screen');
              }),
          const SizedBox(
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image(
                              image: NetworkImage(argument.imageUrl),
                              width: size.width / 2,
                              height: size.height / 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 10.0),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Consumer<ApiConnectionProvider>(
                                  builder: (context, value, child) {
                                return InkWell(
                                  onTap: () {
                                    if (isFavourite == true) {
                                      String wathListItemId =
                                          argument.watchListItemId.toString();
                                      value.removeFromWatchList(wathListItemId);
                                      print('wathListItemId: $wathListItemId');
                                    } else {
                                      String productId = argument.id;
                                      value.addToWatchList(productId);
                                      print('Id: ${productId}');
                                      setState(() {

                                      });
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
                                );
                              })),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
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
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                          const SizedBox(
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                argument!.description,
                                style: const TextStyle(fontSize: 15),
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
          ? const SizedBox()
          : SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Text('\$${argument!.price}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  Expanded(
                  child: Consumer<ApiConnectionProvider>(builder: (context, value, child) {
                    return ElevatedButton(
                        onPressed: () {
                          if (itemAddedToCart == true) {
                          } else {
                            String productId =
                                argument.id;
                            apiConnectionProvider
                                .addToCart(productId);
                            print('Id: ${productId}');
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
