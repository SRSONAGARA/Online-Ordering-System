import 'package:badges/badges.dart' as Badge;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_state.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/drawer_screen/drawer_screen.dart';

class ProductScreenBloc extends StatefulWidget {
  const ProductScreenBloc({Key? key}) : super(key: key);

  @override
  State<ProductScreenBloc> createState() => _ProductScreenBlocState();
}

class _ProductScreenBlocState extends State<ProductScreenBloc> {
  ProductScreenCarouselCubit? productScreenCarouselCubit;
  ProductListCubit? productListCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    BlocProvider.of<ProductListCubit>(context).getDataBloc();
    productScreenCarouselCubit = ProductScreenCarouselCubit();
    productListCubit = ProductListCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerScreenBloc(),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
          title: Text('') /*searchGetxController.CustomText*/,
          centerTitle: true,
          leading: /*searchGetxController.SearchButton
              ? IconButton(
              onPressed: () {
                searchGetxController.searchButtonPress();

                // value.searchButtonPress();
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ))
              :*/
              Builder(builder: (context) {
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
            /*IconButton(
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
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: "Search for products",
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
                }),*/
            InkWell(
              child: Center(
                child: Badge.Badge(
                  badgeContent: Text(''),
                  /*Obx(() => productScreenGetxController
                      .isLoading.value
                      ? SizedBox()
                      : Text(
                    productScreenGetxController
                        .productDataListGetx.totalProduct
                        .toString(),
                    style: const TextStyle(color: Colors.white),
                  )),*/
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    // color: Colors.blue,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/cartScreen');
                // Get.toNamed('/cartScreenGetx');
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
            child: /*!searchGetxController.SearchButton
              ? AllProduct()
              : CustomProduct(),*/
                AllProduct()));
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
            padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
            child: BlocBuilder<ProductScreenCarouselCubit, int>(
                bloc: productScreenCarouselCubit,
                builder: (context, currentIndex) {
                  return Stack(
                    children: [
                      CarouselSlider(
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
                            productScreenCarouselCubit!
                                .updateCarouselPage(index);
                          },
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
                  );
                }),
          ),
          const SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
          BlocConsumer<ProductListCubit, ProductScreenState>(
            builder: (context, state) {
              ProductListCubit productListCubit =
                  BlocProvider.of<ProductListCubit>(context);
              if (state is ProductScreenLoadingState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: const Center(
                    child: AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Color.fromRGBO(86, 126, 239, 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Loading...')
                        ],
                      ),
                    ),
                  ),
                );
              }
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    bool isFavourite = productListCubit
                            .productDataListBloc.data![index].watchListItemId !=
                        '';
                    bool itemAddedToCart = productListCubit
                            .productDataListBloc.data[index].quantity !=
                        0;

                    return InkWell(
                      onTap: () {
                        /*Get.toNamed('/productDetailScreenGetx', arguments: {
                      'Price': productScreenGetxController.productDataListGetx.data[index].price,
                      'Name': productScreenGetxController.productDataListGetx.data[index].title,
                      'ImageURL': productScreenGetxController.productDataListGetx.data[index].imageUrl,
                      'ShortDescription': productScreenGetxController.productDataListGetx.data[index].description,
                      'Index': index,
                    } );*/
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
                                                productListCubit!
                                                    .productDataListBloc
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
                                                BlocConsumer<ProductListCubit,
                                                    ProductScreenState>(
                                                  builder: (context, state) {
                                                    ProductListCubit
                                                        productListCubit =
                                                        BlocProvider.of(
                                                            context);
                                                    if (productListCubit
                                                        .isLoadingList[index]) {
                                                      return const SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Color.fromRGBO(
                                                              86, 126, 239, 15),
                                                        ),
                                                      );
                                                    } else {
                                                      return InkWell(
                                                        onTap: () async {
                                                          if (isFavourite ==
                                                              true) {
                                                            productListCubit
                                                                .updateButtonState(
                                                                    index);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(const SnackBar(
                                                                    content: Text(
                                                                        'Please wait, Item will remove from WatchList !'),
                                                                    duration: Duration(
                                                                        seconds:
                                                                            2)));

                                                            await productListCubit.removeFromWatchListBloc(
                                                                wathListItemId: productListCubit
                                                                    .productDataListBloc
                                                                    .data![
                                                                        index]
                                                                    .watchListItemId
                                                                    .toString(),
                                                                index: index);
                                                            productListCubit
                                                                .updateButtonDisableState(
                                                                    index);
                                                          } else {
                                                            productListCubit
                                                                .updateButtonState(
                                                                    index);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(const SnackBar(
                                                                    content: Text(
                                                                        'Please wait, Item will be Added to WatchList !'),
                                                                    duration: Duration(
                                                                        seconds:
                                                                            2)));

                                                            await productListCubit
                                                                .addToWatchListBloc(
                                                                    productId: productListCubit
                                                                        .productDataListBloc
                                                                        .data[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    index:
                                                                        index);
                                                            productListCubit
                                                                .updateButtonDisableState(
                                                                    index);
                                                          }
                                                        },
                                                        child: isFavourite
                                                            ? const Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red,
                                                                size: 20,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .favorite_outline,
                                                                size: 20),
                                                      );
                                                    }
                                                  },
                                                  listener: (context, state) {},
                                                )
                                              ],
                                            ),
                                            Text(
                                              productListCubit!
                                                  .productDataListBloc
                                                  .data[index]
                                                  .title,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              productListCubit!
                                                  .productDataListBloc
                                                  .data[index]
                                                  .description,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              '\$${productListCubit!.productDataListBloc.data[index].price}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    3)),
                                                        color: /*cartButtonDisabledList[
                                                    index]
                                                        ? Colors.red[200]
                                                        : itemAddedToCart
                                                        ? Colors
                                                        .red[200]
                                                        : */
                                                            const Color
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
                                                            onTap: /*cartButtonDisabledList[index]
                                                            ?() async {

                                                        }  :*/
                                                                () async {
                                                              /*  setState(() {
                                                            cartButtonDisabledList[
                                                            index] =
                                                            true;
                                                          });*/
                                                              /* if (itemAddedToCart !=
                                                              true) {
                                                            Get.rawSnackbar(
                                                                message: 'Please wait, Item will be Added to Cart !',
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
                                                              message: 'Added successfully !',
                                                              backgroundColor: const Color.fromRGBO(
                                                                  86,
                                                                  126,
                                                                  239,
                                                                  10),
                                                              duration:
                                                              const Duration(seconds: 2));*/
                                                            },
                                                            onDoubleTap: () {},
                                                            onLongPress: () {},
                                                            child: /*cartButtonDisabledList[
                                                        index]
                                                            ? Text(
                                                          'Added',
                                                          style: const TextStyle(
                                                              color:
                                                              Colors.white),
                                                        )
                                                            : itemAddedToCart
                                                            ? Text(
                                                          'Added',
                                                          style:
                                                          const TextStyle(color: Colors.white),
                                                        )
                                                            : */
                                                                Text(
                                                              'Add To Cart',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                /* !itemAddedToCart
                                                ? SizedBox()
                                                :
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            /* if (productScreenGetxController
                                                            .productDataListGetx
                                                            .data[index]
                                                            .quantity ==
                                                            1) {
                                                          Get.rawSnackbar(
                                                              message: 'Please wait, Item will remove from Cart !',
                                                              backgroundColor: const Color.fromRGBO(
                                                                  86,
                                                                  126,
                                                                  239,
                                                                  10),
                                                              duration:
                                                              Duration(seconds: 2));
                                                        } else {
                                                          Get.rawSnackbar(
                                                              message: 'Please wait, Quantity will be decreased !',
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
                                                            .getMyCartGetx();*/
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[200],
                                                            radius: 14,
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.remove,
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
                                                            '1' /*productScreenGetxController
                                                          .productDataListGetx
                                                          .data[
                                                      index]
                                                          .quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),*/
                                                            ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            /*   Get.rawSnackbar(
                                                            message:
                                                            'Please wait, Quantity will be increased !',
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
                                                            .getMyCartGetx();*/
                                                          },
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[200],
                                                            radius: 14,
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )*/
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
                  itemCount:
                      productListCubit!.productDataListBloc.data.length);
            },
            listener: (context, state) {},
          ),
        ],
      ),
    );
  }
}
