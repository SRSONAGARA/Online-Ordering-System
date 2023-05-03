import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:get/get.dart';
import 'package:oline_ordering_system/GetX/ControllersGetx/ApiConnection_Getx/CartScreenGetxController.dart';

import '../../ControllersGetx/ApiConnection_Getx/ProductScreenGetxController.dart';
import '../../ControllersGetx/ApiConnection_Getx/WishlistScreenGetxController.dart';
import '../drawerGetx/DrawerScreenGetx.dart';

class ProductScreenGetx extends StatefulWidget {
  const ProductScreenGetx({Key? key}) : super(key: key);

  @override
  State<ProductScreenGetx> createState() => _ProductScreenGetxState();
}

class _ProductScreenGetxState extends State<ProductScreenGetx> {
  String cartItemCount = '';
  int currentIndex = 0;

  var productScreenGetxController = Get.put(ProductScreenGetxController());
  var cartScreenGetxController = Get.put(CartScreenGetxController());
  var wishlistScreenGetxController = Get.put(WishlistScreenGetxController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productScreenGetxController.getDataGetx();
    cartScreenGetxController.getMyCartGetx();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerScreenGetx(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(86, 126, 239, 15),
          title: Text('Ordefy'),
          centerTitle: true,
          leading: Builder(builder: (context) {
            return InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Icon(
                Icons.menu,
                // color: Colors.blue,
              ),
            );
          }),
          actions: ([
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            InkWell(
              child: Center(
                child: Badge.Badge(
                  badgeContent: Obx(() =>  productScreenGetxController.isLoading.value
                      ? SizedBox()
                      : Text(
                    productScreenGetxController.productDataListGetx.totalProduct.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    // color: Colors.blue,
                  ),
                ),
              ),
              onTap: () {
                Get.toNamed('/cartScreenGetx');
              },
              onDoubleTap: () {},
              onLongPress: () {},
            ),
            const SizedBox(
              width: 20,
            )
          ]),
        ),
        body: SingleChildScrollView(
          child: AllProduct(),
        ));
  }

  Widget AllProduct() {
    List imageList = [
      {"id": 1, "image_path": 'assets/sliderImages/img1.jpg'},
      {"id": 2, "image_path": 'assets/sliderImages/img2.jpg'},
      {"id": 3, "image_path": 'assets/sliderImages/img3.jpg'},
      {"id": 4, "image_path": 'assets/sliderImages/img4.jpg'},
      {"id": 5, "image_path": 'assets/sliderImages/img5.jpg'},
      {"id": 6, "image_path": 'assets/sliderImages/img6.jpg'},
      {"id": 7, "image_path": 'assets/sliderImages/img7.jpg'},
    ];

    final CarouselController carController = CarouselController();

    return /*productData.isEmpty
      ? SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: const Center(child: CircularProgressIndicator()))
      : */
        Obx(() => productScreenGetxController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                color: Color.fromRGBO(86, 126, 239, 10),
              ))
            : SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, right: 10, left: 10),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              // print(currentIndex);
                            },
                            child: CarouselSlider(
                              items: imageList
                                  .map(
                                    (item) => Image.asset(
                                      item['image_path'],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  )
                                  .toList(),
                              carouselController: carController,
                              options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 2,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                   setState(() {
                        currentIndex = index;
                      });
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imageList!.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      carController.animateToPage(entry.key),
                                  child: Container(
                                    width: currentIndex == entry.key ? 14 : 7,
                                    height: 7.0,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 3.0,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: currentIndex == entry.key
                                            ? Colors.red
                                            : Colors.blue),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Items in Stock',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          bool isFavourite = productScreenGetxController
                                  .productDataListGetx
                                  .data![index]
                                  .watchListItemId !=
                              '';
                          bool itemAddedToCart = productScreenGetxController
                                  .productDataListGetx.data[index].quantity !=
                              0;

                          return InkWell(
                            onTap: () {
                              /*Navigator.pushNamed(context, '/productDetails-screen',
                      arguments: productData[0].data![index]);*/
                            },
                            child: Card(
                              elevation: 6,
                              child: Column(
                                children: [
                                  Padding(
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
                                                    image: NetworkImage(
                                                      productScreenGetxController
                                                          .productDataListGetx
                                                          .data![index]
                                                          .imageUrl,
                                                    ),
                                                    height: 120,
                                                    // width: 100,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          if (isFavourite ==
                                                              true) {
                                                         await wishlistScreenGetxController.removeFromWatchListGetx(
                                                                productScreenGetxController
                                                                    .productDataListGetx
                                                                    .data![
                                                                        index]
                                                                    .watchListItemId
                                                                    .toString());
                                                         Get.rawSnackbar(message: 'Item removed from WatchList !',
                                                             backgroundColor: Color.fromRGBO(
                                                                 86,
                                                                 126,
                                                                 239,
                                                                 10),
                                                             duration:
                                                             Duration(seconds: 2));
                                                          } else {
                                                         await wishlistScreenGetxController
                                                              .addToWatchListGetx(
                                                                  productScreenGetxController
                                                                      .productDataListGetx
                                                                      .data![
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                         Get.rawSnackbar(message: 'Item Added to WatchList !',
                                                             backgroundColor: Color.fromRGBO(
                                                                 86,
                                                                 126,
                                                                 239,
                                                                 10),
                                                             duration:
                                                             Duration(seconds: 2));
                                                          }
                                                          await productScreenGetxController
                                                              .getDataGetx();
                                                          await wishlistScreenGetxController
                                                              .getWatchListGetx();
                                                        },
                                                        onDoubleTap: () {},
                                                        onLongPress: () {},
                                                        child: isFavourite
                                                      ? const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                    size: 20,
                                                  )
                                                      :
                                                            const Icon(
                                                                Icons
                                                                    .favorite_outline,
                                                                size: 20),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    productScreenGetxController
                                                        .productDataListGetx
                                                        .data[index]
                                                        .title,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    productScreenGetxController
                                                        .productDataListGetx
                                                        .data[index]
                                                        .description,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black54),
                                                  ),
                                                  Text(
                                                    '\$${productScreenGetxController.productDataListGetx.data[index].price}',
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              3)),
                                                              color: itemAddedToCart
                                                                  ? Colors
                                                                      .red[200]
                                                                  : Color
                                                                      .fromRGBO(
                                                                          86,
                                                                          126,
                                                                          239,
                                                                          10),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    if (itemAddedToCart !=
                                                                        true) {
                                                                      String productId = productScreenGetxController
                                                                          .productDataListGetx
                                                                          .data[
                                                                              index]
                                                                          .id;

                                                                      await cartScreenGetxController
                                                                          .addToCartGetx(
                                                                              productId);

                                                                      Get.rawSnackbar(
                                                                          message:
                                                                              'Item Added to Cart !',
                                                                          backgroundColor: Color.fromRGBO(
                                                                              86,
                                                                              126,
                                                                              239,
                                                                              10),
                                                                          duration:
                                                                              Duration(seconds: 2));
                                                                      await productScreenGetxController
                                                                          .getDataGetx();
                                                                      await cartScreenGetxController
                                                                          .getMyCartGetx();

                                                                    }
                                                                  },
                                                                  onDoubleTap:
                                                                      () {},
                                                                  onLongPress:
                                                                      () {},
                                                                  child: itemAddedToCart
                                                                      ? const Text(
                                                                          'Added',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )
                                                                      : const Text(
                                                                          'Add To Cart',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      !itemAddedToCart
                                                          ? SizedBox()
                                                          : Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    InkWell(
                                                                      onDoubleTap:
                                                                          () {},
                                                                      onLongPress:
                                                                          () {},
                                                                      onTap:
                                                                          () async {
                                                                        await cartScreenGetxController.decreaseProductQuantityGetx(productScreenGetxController
                                                                            .productDataListGetx
                                                                            .data[index]
                                                                            .cartItemId
                                                                            .toString());
                                                                        productScreenGetxController
                                                                            .getDataGetx();
                                                                        cartScreenGetxController
                                                                            .getMyCartGetx();
                                                                        if(productScreenGetxController
                                                                            .productDataListGetx.data[index].quantity == 1){
                                                                          Get.rawSnackbar(message: 'Item removed from Cart !',backgroundColor: Color.fromRGBO(
                                                                              86,
                                                                              126,
                                                                              239,
                                                                              10),
                                                                              duration:
                                                                              Duration(seconds: 2));
                                                                        }
                                                                      },
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.grey[200],
                                                                        radius:
                                                                            14,
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.remove,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      productScreenGetxController
                                                                          .productDataListGetx
                                                                          .data[
                                                                              index]
                                                                          .quantity
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    InkWell(
                                                                      onDoubleTap:
                                                                          () {},
                                                                      onLongPress:
                                                                          () {},
                                                                      onTap:
                                                                          () async {
                                                                        await cartScreenGetxController.increaseProductQuantityGetx(productScreenGetxController
                                                                            .productDataListGetx
                                                                            .data[index]
                                                                            .cartItemId
                                                                            .toString());
                                                                        productScreenGetxController
                                                                            .getDataGetx();
                                                                        cartScreenGetxController
                                                                            .getMyCartGetx();
                                                                      },
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.grey[200],
                                                                        radius:
                                                                            14,
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.add,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: productScreenGetxController
                            .productDataListGetx
                            .data
                            .length /* productData[0].data?.length*/)
                  ],
                ),
              ));
  }
}
