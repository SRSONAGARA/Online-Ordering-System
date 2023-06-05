import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oline_ordering_system/GetX/ModelsGetx/ProductListModelClassGetx.dart';
import 'package:get/get.dart';

import '../../ControllersGetx/ApiConnection_Getx/CartScreenGetxController.dart';
import '../../ControllersGetx/ApiConnection_Getx/ProductScreenGetxController.dart';
import '../../ControllersGetx/ApiConnection_Getx/WishlistScreenGetxController.dart';
import '../../ControllersGetx/SearchGetxController.dart';

class ProductDetailScreenGetx extends StatefulWidget {
  const ProductDetailScreenGetx({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreenGetx> createState() =>
      _ProductDetailScreenGetxState();
}

class _ProductDetailScreenGetxState extends State<ProductDetailScreenGetx> {
  var size;
  Widget CustomText = const Text("Product Details Screen");
  // bool isLoading = true;

  dynamic argument = Get.arguments;
  // List<bool> cartButtonDisabledList = List.generate(25, (index) => false);
  bool cartButtonDisable = false;

  var cartScreenGetxController = Get.put(CartScreenGetxController());
  var wishlistScreenGetxController = Get.put(WishlistScreenGetxController());
  var productScreenGetxController = Get.put(ProductScreenGetxController());
  var searchGetxController = Get.put(SearchGetxController());

  @override
  Widget build(BuildContext context) {
    /*late String watchListItemId = argument.watchListItemId.toString();
    late String cartItemId = argument.cartItemId.toString();
    bool isFavourite = watchListItemId != '';
    bool itemAddedToCart = cartItemId != '';*/

    size = MediaQuery.of(context).size;

    return GetBuilder<WishlistScreenGetxController>(
        builder: (wishlistScreenGetxController) {
      return GetBuilder<CartScreenGetxController>(
          builder: (cartScreenGetxController) {
        return GetBuilder<ProductScreenGetxController>(
            builder: (productScreenGetxController) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                    onTap: () {
                      Get.back();
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
                          cartScreenGetxController.cartGetx.data!.length
                              .toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: const Icon(Icons.shopping_cart_outlined),
                      ),
                    ),
                    onTap: () {
                      Get.toNamed('/cartScreenGetx');
                      // Navigator.pushNamed(context, '/cart-screen');
                    }),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            body: /*isLoading
          ? const Center(child: CircularProgressIndicator())
          :*/
                SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                              image: NetworkImage(argument!['ImageURL']),
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
                              child: productScreenGetxController
                                          .productDataListGetx
                                          .data[argument!['Index']]
                                          .watchListItemId !=
                                      ''
                                  ? InkWell(
                                      onTap: () async {
                                        Get.rawSnackbar(
                                            message:
                                                'Please wait, Item will remove from WatchList !'
                                                    .tr,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    86, 126, 239, 10),
                                            duration:
                                                const Duration(seconds: 2));
                                        await wishlistScreenGetxController
                                            .removeFromWatchListGetx(
                                                productScreenGetxController
                                                    .productDataListGetx
                                                    .data[argument!['Index']]
                                                    .watchListItemId
                                                    .toString());
                                        await productScreenGetxController
                                            .getDataGetx();
                                        await wishlistScreenGetxController
                                            .getWatchListGetx();
                                      },
                                      onLongPress: () {},
                                      onDoubleTap: () {},
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        Get.rawSnackbar(
                                            message:
                                                'Please wait, Item will be Added to WatchList !'
                                                    .tr,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    86, 126, 239, 10),
                                            duration:
                                                const Duration(seconds: 2));
                                        await wishlistScreenGetxController
                                            .addToWatchListGetx(
                                                productScreenGetxController
                                                    .productDataListGetx
                                                    .data[argument!['Index']]
                                                    .id);

                                        await productScreenGetxController
                                            .getDataGetx();
                                        await wishlistScreenGetxController
                                            .getWatchListGetx();
                                        /*Get.rawSnackbar(
                                            message: 'Added successfully !'
                                                .tr,
                                            backgroundColor: const Color.fromRGBO(
                                                86,
                                                126,
                                                239,
                                                10),
                                            duration:
                                            const Duration(seconds: 2));*/
                                      },
                                      onLongPress: () {},
                                      onDoubleTap: () {},
                                      child: const Icon(Icons.favorite_outline,
                                          size: 20),
                                    )),
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(children: [
                            Flexible(
                              child: Text(
                                argument!['Name'],
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
                                argument!['ShortDescription'],
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
            bottomNavigationBar: /*isLoading
          ? const SizedBox()
          :*/
                SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Text('\$${argument!['Price']}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  Expanded(
                      child: cartButtonDisable
                          ? InkWell(
                              onTap: () {},
                              onLongPress: () {},
                              onDoubleTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red[200],
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Center(
                                    child: Text(
                                  "Added in Cart".tr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          : productScreenGetxController.productDataListGetx
                                      .data[argument!['Index']].quantity !=
                                  0
                              ? InkWell(
                                  onTap: () {},
                                  onLongPress: () {},
                                  onDoubleTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red[200],
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Center(
                                        child: Text(
                                      "Added in Cart".tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                )
                              : InkWell(
                                  onTap: cartButtonDisable
                                      ? () async {}
                                      : () async {
                                          setState(() {
                                            cartButtonDisable = true;
                                          });
                                          Get.rawSnackbar(
                                              message: 'Please wait, Item will be Added to Cart !'
                                                  .tr,
                                              backgroundColor: const Color.fromRGBO(
                                                  86,
                                                  126,
                                                  239,
                                                  10),
                                              duration:
                                              const Duration(seconds: 2));
                                          await cartScreenGetxController
                                              .addToCartGetx(
                                                  productScreenGetxController
                                                      .productDataListGetx
                                                      .data[argument!['Index']]
                                                      .id);
                                          Get.rawSnackbar(
                                              message: 'Added successfully !'
                                                  .tr,
                                              backgroundColor: const Color.fromRGBO(
                                                  86,
                                                  126,
                                                  239,
                                                  10),
                                              duration:
                                              const Duration(seconds: 2));
                                          await productScreenGetxController
                                              .getDataGetx();
                                          await cartScreenGetxController
                                              .getMyCartGetx();
                                          setState(() {
                                            cartButtonDisable = false;
                                            productScreenGetxController
                                                .getDataGetx();
                                          });

                                        },
                                  onDoubleTap: () {},
                                  onLongPress: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            86, 126, 239, 15),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Center(
                                        child: Text(
                                      "Add To Cart".tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ))
                ],
              ),
            ),
          );
        });
      });
    });
  }
}
