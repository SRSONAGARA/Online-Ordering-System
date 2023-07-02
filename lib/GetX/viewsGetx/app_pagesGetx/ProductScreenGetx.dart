import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:get/get.dart';
import 'package:oline_ordering_system/GetX/ControllersGetx/ApiConnection_Getx/CartScreenGetxController.dart';
import 'package:oline_ordering_system/GetX/ControllersGetx/SearchGetxController.dart';

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
  List<dynamic> SearchItems = [];
  // bool isDisable= false;
  List<bool> cartButtonDisabledList = List.generate(25, (index) => false);

  var productScreenGetxController = Get.put(ProductScreenGetxController());
  var cartScreenGetxController = Get.put(CartScreenGetxController());
  var wishlistScreenGetxController = Get.put(WishlistScreenGetxController());
  var searchGetxController = Get.put(SearchGetxController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    SearchItems = productScreenGetxController.productDataListGetx.data;
    productScreenGetxController.getDataGetx();

  }

  getData() async {
    productScreenGetxController.getDataGetx();
    cartScreenGetxController.getMyCartGetx();

    print(SearchItems);
    print('length:${SearchItems.length}');
  }

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchGetxController>(
      builder: (searchGetxController) {
        return GetBuilder<ProductScreenGetxController>(
            builder: (productScreenGetxController) {
          return WillPopScope(
              onWillPop: () async {
                if (searchGetxController.SearchButton == true) {
                  searchGetxController.searchButtonPress();
                  //searchGetxController.SearchButton = false;
                  Get.back();
                  return false;
                } else {
                  final timegap = DateTime.now().difference(pre_backpress);
                  print('timegap${timegap}');
                  final cantExit = timegap >= const Duration(seconds: 2);
                  print('canExist: ${cantExit}');
                  pre_backpress = DateTime.now();
                  print('pre_backpress : ${pre_backpress}');
                  if (cantExit) {
                    final snack = SnackBar(
                      content: Text('Press Back button again to Exit'.tr),
                      duration: const Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snack);
                    return true;
                  }
                  return false;
                }
              },
              child: Scaffold(
                  drawer: DrawerScreenGetx(),
                  appBar: AppBar(
                    backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
                    title: searchGetxController.CustomText,
                    // title: Text('app_name'.tr),
                    centerTitle: true,
                    leading: searchGetxController.SearchButton
                        ? IconButton(
                            onPressed: () {
                              searchGetxController.searchButtonPress();

                              // value.searchButtonPress();
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.white,
                            ))
                        : Builder(builder: (context) {
                            return InkWell(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: const Icon(
                                Icons.menu,
                              ),
                            );
                          })
                    // })
                    ,
                    actions: ([
                      IconButton(
                          icon: searchGetxController.CustomSearch,
                          onPressed: () {
                            SearchItems = productScreenGetxController
                                .productDataListGetx.data;
                            setState(() {});

                            if (searchGetxController.CustomSearch.icon ==
                                Icons.search) {
                              searchGetxController.SearchButton = true;
                              searchGetxController.CustomSearch = const Icon(
                                Icons.clear_outlined,
                                color: Colors.white,
                              );
                              searchGetxController.CustomText = TextField(
                                textInputAction: TextInputAction.go,
                                controller:
                                    searchGetxController.searchController,
                                onChanged: (value) {
                                  List<dynamic> results = [];
                                  if (value.isEmpty) {
                                    results = SearchItems;
                                  } else {
                                    results = productScreenGetxController
                                        .productDataListGetx.data
                                        .where((element) => element.title
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toString()))
                                        .toList();
                                  }

                                  setState(() {});
                                  if (results.isEmpty) {
                                    searchGetxController.searchListIsEmpty();
                                  } else {
                                    searchGetxController.searchListIsNotEmpty();
                                  }
                                  SearchItems = results;
                                  // productScreenGetxController.getDataGetx();
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: "Search for products".tr,
                                  hintStyle: TextStyle(color: Colors.white60),
                                ),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              );
                            } else {
                              searchGetxController.searchController.clear();
                              searchGetxController.searchButtonUnPress();
                              setState(() {});
                            }
                          }),
                      InkWell(
                        child: Center(
                          child: Badge.Badge(
                            badgeContent: Obx(() => productScreenGetxController
                                    .isLoading.value
                                ? SizedBox()
                                : Text(
                                    productScreenGetxController
                                        .productDataListGetx.totalProduct
                                        .toString(),
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
                    child: !searchGetxController.SearchButton
                        ? AllProduct()
                        : CustomProduct(),
                  )));
        });
      },
    );
  }

  Widget CustomProduct() {
    print('CustomProduct');
    return searchGetxController.ListEmptyBool
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: Text(
                "No items match your search...",
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        : Obx(() => productScreenGetxController.isLoading.value ||
                wishlistScreenGetxController.isLoading.value ||
                cartScreenGetxController.isLoading.value
            ? Container(
                height: Get.height / 1.3,
                child: Center(
                    child: AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: const Color.fromRGBO(86, 126, 239, 15),), SizedBox(width: 20,),Text('Loading...'.tr)],),),
                ),
              )
            : GetBuilder<SearchGetxController>(builder: (searchGetxController) {
                return GetBuilder<ProductScreenGetxController>(
                    builder: (productScreenGetxController) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print(SearchItems.length);

                        bool isFavourite =
                            SearchItems[index].watchListItemId != '';
                        bool itemAddedToCart = SearchItems[index].quantity != 0;
                        return InkWell(
                            onTap: () {
                              Get.toNamed('/productDetailScreenGetx', arguments: {
                                'Price': SearchItems[index].price,
                                'Name': SearchItems[index].title,
                                'ImageURL': SearchItems[index].imageUrl,
                                'ShortDescription': SearchItems[index].description,
                                'Index': index,
                              });
                            },
                            child: Card(
                              elevation: 6,
                              child: Padding(
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
                                                    SearchItems[index]
                                                        .imageUrl),
                                                height: 100,
                                                width: 100,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      if (isFavourite == true) {
                                                        Get.rawSnackbar(
                                                            message:
                                                                'Please wait, Item will remove from WatchList !'
                                                                    .tr,
                                                            backgroundColor:
                                                                const Color
                                                                        .fromRGBO(
                                                                    86,
                                                                    126,
                                                                    239,
                                                                    10),
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                        await wishlistScreenGetxController
                                                            .removeFromWatchListGetx(
                                                                SearchItems[
                                                                        index]
                                                                    .watchListItemId
                                                                    .toString());
                                                      } else {
                                                        Get.rawSnackbar(
                                                            message:
                                                                'Please wait, Item will be Added to WatchList !'
                                                                    .tr,
                                                            backgroundColor:
                                                                const Color
                                                                        .fromRGBO(
                                                                    86,
                                                                    126,
                                                                    239,
                                                                    10),
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                        await wishlistScreenGetxController
                                                            .addToWatchListGetx(
                                                                SearchItems[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                      }
                                                      searchGetxController
                                                          .searchController
                                                          .clear();
                                                      await productScreenGetxController
                                                          .getDataGetx();
                                                      await wishlistScreenGetxController
                                                          .getWatchListGetx();
                                                      SearchItems =
                                                          productScreenGetxController
                                                              .productDataListGetx
                                                              .data;
                                                      setState(() {});
                                                    },
                                                    onDoubleTap: () {},
                                                    onLongPress: () {},
                                                    child: isFavourite
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                            size: 20,
                                                          )
                                                        : const Icon(
                                                            Icons
                                                                .favorite_outline,
                                                            size: 20),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                SearchItems[index]
                                                    .title
                                                    .toString(),
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                SearchItems[index]
                                                    .description
                                                    .toString(),
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                '\$${SearchItems[index].price}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(3)),
                                                  color: cartButtonDisabledList[
                                                     index]
                                                      ? Colors.red[200]
                                                      : itemAddedToCart
                                                      ? Colors.red[200]
                                                      : const Color.fromRGBO(
                                                          86, 126, 239, 10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: cartButtonDisabledList[index]
                                                          ?() async {

                                                      }  : () async {
                                                        setState(() {
                                                          cartButtonDisabledList[
                                                          index] =
                                                          true;
                                                        });
                                                        if (itemAddedToCart !=
                                                            true) {
                                                          Get.rawSnackbar(
                                                              message:
                                                                  'Please wait, Item will be Added to Cart !'
                                                                      .tr,
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromRGBO(
                                                                      86,
                                                                      126,
                                                                      239,
                                                                      10),
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2));
                                                          String productId =
                                                              SearchItems[index]
                                                                  .id;

                                                          await cartScreenGetxController
                                                              .addToCartGetx(
                                                                  productId);
                                                          searchGetxController
                                                              .searchController
                                                              .clear();
                                                          await productScreenGetxController
                                                              .getDataGetx();
                                                          await cartScreenGetxController
                                                              .getMyCartGetx();
                                                          SearchItems =
                                                              productScreenGetxController
                                                                  .productDataListGetx
                                                                  .data;
                                                          setState(() {
                                                            cartButtonDisabledList[
                                                            index] =
                                                            false;
                                                          });
                                                        }
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
                                                      },
                                                      onDoubleTap: () {},
                                                      onLongPress: () {},
                                                      child: cartButtonDisabledList[index]
                                                          ?Text(
                                                        'Added'.tr,
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .white),
                                                      )
                                                          :itemAddedToCart
                                                          ? Text(
                                                              'Added'.tr,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text(
                                                              'Add To Cart'.tr,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                      },
                      itemCount: SearchItems.length);
                });
              }));
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

    return SizedBox(
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
                                        : const Color.fromRGBO(
                                            86, 126, 239, 15)),
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
                    children: [
                      Text(
                        'Items in Stock'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Obx(() => productScreenGetxController.isLoading.value
                    ? Container(
                  height: Get.height/1.7,
                      child: Center(
                        child: AlertDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const CircularProgressIndicator(color: Color.fromRGBO(86, 126, 239, 15),), SizedBox(width: 20,),Text('Loading...'.tr)],),),
                      ),
                    )
                    : ListView.builder(
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
                          Get.toNamed('/productDetailScreenGetx', arguments: {
                            'Price': productScreenGetxController.productDataListGetx.data[index].price,
                            'Name': productScreenGetxController.productDataListGetx.data[index].title,
                            'ImageURL': productScreenGetxController.productDataListGetx.data[index].imageUrl,
                            'ShortDescription': productScreenGetxController.productDataListGetx.data[index].description,
                            'Index': index,
                          } );
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
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      /* setState(() {
                                                        buttonDisabledList[index]=true;
                                                      });*/
                                                      if (isFavourite == true) {
                                                        Get.rawSnackbar(
                                                            message:
                                                                'Please wait, Item will remove from WatchList !'
                                                                    .tr,
                                                            backgroundColor:
                                                                const Color
                                                                        .fromRGBO(
                                                                    86,
                                                                    126,
                                                                    239,
                                                                    10),
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                        await wishlistScreenGetxController
                                                            .removeFromWatchListGetx(
                                                                productScreenGetxController
                                                                    .productDataListGetx
                                                                    .data![
                                                                        index]
                                                                    .watchListItemId
                                                                    .toString());
                                                      } else {
                                                        Get.rawSnackbar(
                                                            message:
                                                                'Please wait, Item will be Added to WatchList !'
                                                                    .tr,
                                                            backgroundColor:
                                                                const Color
                                                                        .fromRGBO(
                                                                    86,
                                                                    126,
                                                                    239,
                                                                    10),
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                        await wishlistScreenGetxController
                                                            .addToWatchListGetx(
                                                                productScreenGetxController
                                                                    .productDataListGetx
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
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
                                                        : const Icon(
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
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          3)),
                                                          color: cartButtonDisabledList[
                                                                  index]
                                                              ? Colors.red[200]
                                                              : itemAddedToCart
                                                                  ? Colors
                                                                      .red[200]
                                                                  : const Color
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
                                                              onTap: cartButtonDisabledList[index]
                                                                  ?() async {

                                                              }  :  () async {
                                                                setState(() {
                                                                  cartButtonDisabledList[
                                                                          index] =
                                                                      true;
                                                                });
                                                                if (itemAddedToCart !=
                                                                    true) {
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
                                                                  String productId = productScreenGetxController
                                                                      .productDataListGetx
                                                                      .data[
                                                                  index]
                                                                      .id;

                                                                  await cartScreenGetxController
                                                                      .addToCartGetx(
                                                                      productId);

                                                                  await cartScreenGetxController
                                                                      .getMyCartGetx();
                                                                  await productScreenGetxController
                                                                      .getDataGetx();
                                                                  setState(
                                                                          () {
                                                                        cartButtonDisabledList[index] =
                                                                        false;
                                                                        productScreenGetxController
                                                                            .getDataGetx();
                                                                      });
                                                                }
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
                                                              },
                                                              onDoubleTap:
                                                                  () {},
                                                              onLongPress:
                                                                  () {},
                                                              child: cartButtonDisabledList[
                                                                      index]
                                                                  ? Text(
                                                                      'Added'
                                                                          .tr,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  : itemAddedToCart
                                                                      ? Text(
                                                                          'Added'
                                                                              .tr,
                                                                          style:
                                                                              const TextStyle(color: Colors.white),
                                                                        )
                                                                      : Text(
                                                                          'Add To Cart'
                                                                              .tr,
                                                                          style:
                                                                              const TextStyle(color: Colors.white),
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
                                                                  /*onDoubleTap:
                                                                      () {},
                                                                  onLongPress:
                                                                      () {},*/
                                                                  onTap:
                                                                      () async {
                                                                    if (productScreenGetxController
                                                                            .productDataListGetx
                                                                            .data[index]
                                                                            .quantity ==
                                                                        1) {
                                                                      Get.rawSnackbar(
                                                                          message: 'Please wait, Item will remove from Cart !'
                                                                              .tr,
                                                                          backgroundColor: const Color.fromRGBO(
                                                                              86,
                                                                              126,
                                                                              239,
                                                                              10),
                                                                          duration:
                                                                              Duration(seconds: 2));
                                                                    } else {
                                                                      Get.rawSnackbar(
                                                                          message: 'Please wait, Quantity will be decreased !'
                                                                              .tr,
                                                                          backgroundColor: const Color.fromRGBO(
                                                                              86,
                                                                              126,
                                                                              239,
                                                                              10),
                                                                          duration:
                                                                              Duration(seconds: 2));
                                                                    }
                                                                    await cartScreenGetxController.decreaseProductQuantityGetx(productScreenGetxController
                                                                        .productDataListGetx
                                                                        .data[
                                                                            index]
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
                                                                        Colors.grey[
                                                                            200],
                                                                    radius: 14,
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .black,
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
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                InkWell(
                                                                  /*onDoubleTap:
                                                                      () {},
                                                                  onLongPress:
                                                                      () {},*/
                                                                  onTap:
                                                                      () async {
                                                                    Get.rawSnackbar(
                                                                        message:
                                                                            'Please wait, Quantity will be increased !'
                                                                                .tr,
                                                                        backgroundColor: const Color.fromRGBO(
                                                                            86,
                                                                            126,
                                                                            239,
                                                                            10),
                                                                        duration:
                                                                            Duration(seconds: 2));
                                                                    await cartScreenGetxController.increaseProductQuantityGetx(productScreenGetxController
                                                                        .productDataListGetx
                                                                        .data[
                                                                            index]
                                                                        .cartItemId
                                                                        .toString());

                                                                    await productScreenGetxController
                                                                        .getDataGetx();
                                                                    await cartScreenGetxController
                                                                        .getMyCartGetx();
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.grey[
                                                                            200],
                                                                    radius: 14,
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .black,
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
                    itemCount: productScreenGetxController.productDataListGetx
                        .data.length /* productData[0].data?.length*/))
              ],
            ),
          );
  }
}
