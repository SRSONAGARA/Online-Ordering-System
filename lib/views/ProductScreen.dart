import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:oline_ordering_system/provider/ApiConnection/ApiConnection_Provider.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/search_provider.dart';
import 'package:provider/provider.dart';
import '../models/ProductListModelClass.dart';
import 'DrawerScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var size, height, width;
  bool isLoading = true;
  List<dynamic> SearchItems = [];
  int currentIndex = 0;
  String cartItemCount = '';

  List<ProductList> productData = [];
  void accessApi(BuildContext context) async {
    final apiConnectionProvider =
        Provider.of<ApiConnectionProvider>(context, listen: false);
    await apiConnectionProvider.getData(context);

    productData = apiConnectionProvider.productDataList.map((e) => e).toList();
    SearchItems = productData[0].data;
    cartItemCount = productData[0].totalProduct.toString();
    print('cartItemCount: $cartItemCount');
  }

  @override
  void initState() {
    super.initState();
    accessApi(context);
    currentIndex;
  }

  Widget CustomProduct() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    print('CustomProduct');
    return searchProvider.ListEmptyBool
        ? SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: Text(
                "No items match your search...",
                style: TextStyle(fontSize: 15),
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemBuilder: (context, index) {
                  print(SearchItems.length);

                  bool isFavourite = apiConnectionProvider
                          .productDataList[0].data![index].watchListItemId !=
                      '';
                  bool itemAddedToCart = apiConnectionProvider
                          .productDataList[0].data![index].quantity !=
                      0;
                  return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/productDetails-screen',
                            arguments: productData[0].data![index]);
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
                                              SearchItems[index].imageUrl),
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
                                            Consumer<ApiConnectionProvider>(
                                                builder: (context,
                                                    getDataProvider, child) {
                                              return InkWell(
                                                onTap: () async {
                                                  if (isFavourite == true) {
                                                    String? wathListItemId =
                                                        getDataProvider
                                                            .productDataList[0]
                                                            .data![index]
                                                            .watchListItemId;
                                                    await getDataProvider
                                                        .removeFromWatchList(
                                                            getDataProvider
                                                                .productDataList[
                                                                    0]
                                                                .data![index]
                                                                .watchListItemId!);
                                                    print(
                                                        'wathListItemId: $wathListItemId');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          'Item removed from WatchList !'),
                                                      backgroundColor:
                                                          Colors.blue,
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ));
                                                  } else {
                                                    String productId =
                                                        getDataProvider
                                                            .productDataList[0]
                                                            .data![index]
                                                            .id;
                                                    await getDataProvider
                                                        .addToWatchList(
                                                            productId);
                                                    print('Id: ${productId}');
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            content: Text(
                                                                'Item Added to WatchList !'),
                                                            backgroundColor:
                                                                Colors.blue,
                                                            duration: Duration(
                                                                seconds: 2)));
                                                  }
                                                  accessApi(context);
                                                },
                                                child: isFavourite
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                        size: 20,
                                                      )
                                                    : const Icon(
                                                        Icons.favorite_outline,
                                                        size: 20),
                                              );
                                            })
                                          ],
                                        ),
                                        Text(
                                          SearchItems[index].title.toString(),
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
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          '\$${SearchItems[index].price}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              if (itemAddedToCart != true) {
                                                String productId =
                                                    apiConnectionProvider
                                                        .productDataList[0]
                                                        .data![index]
                                                        .id;
                                                await apiConnectionProvider
                                                    .addToCart(productId);
                                                print('Id: ${productId}');
                                                ScaffoldMessenger.of(
                                                    context)
                                                    .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Item Added to Cart !'),
                                                      backgroundColor:
                                                      Colors.blue,
                                                      duration:
                                                      Duration(seconds: 2),
                                                    ));
                                              }
                                              accessApi(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: itemAddedToCart
                                                    ? Colors.red[200]
                                                    : Colors.blue),
                                            child: itemAddedToCart
                                                ? const Text(
                                                    'Item is already Added')
                                                : const Text('Add To Cart'))
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
                itemCount: SearchItems.length),
          );
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

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return productData.isEmpty
        ? SizedBox(
            height: size.height,
            child: const Center(child: CircularProgressIndicator()))
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
                          print(currentIndex);
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
                      bool isFavourite = apiConnectionProvider
                              .productDataList[0]
                              .data![index]
                              .watchListItemId !=
                          '';
                      bool itemAddedToCart = apiConnectionProvider
                              .productDataList[0].data![index].quantity !=
                          0;
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/productDetails-screen',
                              arguments: productData[0].data![index]);
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
                                                  productData[0]
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
                                                  Consumer<
                                                          ApiConnectionProvider>(
                                                      builder: (context,
                                                          getDataProvider,
                                                          child) {
                                                    return InkWell(
                                                      onTap: () async {
                                                        if (isFavourite ==
                                                            true) {
                                                          String?
                                                              wathListItemId =
                                                              getDataProvider
                                                                  .productDataList[
                                                                      0]
                                                                  .data![index]
                                                                  .watchListItemId;
                                                          await getDataProvider
                                                              .removeFromWatchList(
                                                                  getDataProvider
                                                                      .productDataList[
                                                                          0]
                                                                      .data![
                                                                          index]
                                                                      .watchListItemId!);
                                                          print(
                                                              'wathListItemId: $wathListItemId');
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                            content: Text(
                                                                'Item removed from WatchList !'),
                                                            backgroundColor:
                                                                Colors.blue,
                                                            duration: Duration(
                                                                seconds: 2),
                                                          ));
                                                        } else {
                                                          String productId =
                                                              getDataProvider
                                                                  .productDataList[
                                                                      0]
                                                                  .data![index]
                                                                  .id;
                                                          await getDataProvider
                                                              .addToWatchList(
                                                                  productId);
                                                          print(
                                                              'Id: ${productId}');
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(const SnackBar(
                                                                  content: Text(
                                                                      'Item Added to WatchList !'),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blue,
                                                                  duration: Duration(
                                                                      seconds:
                                                                          2)));
                                                        }
                                                        accessApi(context);
                                                      },
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
                                                    );
                                                  })
                                                ],
                                              ),
                                              Text(
                                                productData[0]
                                                    .data![index]
                                                    .title,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                productData[0]
                                                    .data![index]
                                                    .description,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                '\$${productData[0].data![index].price}',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    if (itemAddedToCart !=
                                                        true) {
                                                      String productId =
                                                          apiConnectionProvider
                                                              .productDataList[
                                                                  0]
                                                              .data![index]
                                                              .id;
                                                      await apiConnectionProvider
                                                          .addToCart(productId);
                                                      print('Id: ${productId}');
                                                      ScaffoldMessenger.of(
                                                          context)
                                                          .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                'Item Added to Cart !'),
                                                            backgroundColor:
                                                            Colors.blue,
                                                            duration:
                                                            Duration(seconds: 2),
                                                          ));
                                                    }
                                                    accessApi(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              itemAddedToCart
                                                                  ? Colors
                                                                      .red[200]
                                                                  : Colors
                                                                      .blue),
                                                  child: itemAddedToCart
                                                      ? const Text(
                                                          'Item is already Added')
                                                      : const Text(
                                                          'Add To Cart'))
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
                    itemCount: productData[0].data?.length)
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: searchProvider.CustomText,
          centerTitle: true,
          leading: Consumer<SearchProvider>(builder: (context, value, child) {
            return searchProvider.SearchButton
                ? IconButton(
                    onPressed: () {
                      value.searchButtonPress();
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.blue,
                    ))
                : Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.blue,
                      ),
                    );
                  });
          }),
          actions: ([
            IconButton(
                icon: searchProvider.CustomSearch,
                onPressed: () {
                  if (searchProvider.CustomSearch.icon == Icons.search) {
                    searchProvider.SearchButton = true;
                    searchProvider.CustomSearch = const Icon(
                      Icons.clear_outlined,
                      color: Colors.blue,
                    );
                    searchProvider.CustomText = TextField(
                      textInputAction: TextInputAction.go,
                      controller: searchProvider.search,
                      onChanged: (value) {
                        List<dynamic> results = [];
                        if (value.isEmpty) {
                          results = productData[0].data;
                        } else {
                          results = apiConnectionProvider
                              .productDataList[0].data
                              .where((element) => element.title
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toString()))
                              .toList();
                        }

                        if (results.isEmpty) {
                          searchProvider.searchListIsEmpty();
                        } else {
                          searchProvider.searchListIsNotEmpty();
                        }
                        SearchItems = results;
                      },
                      decoration: const InputDecoration(
                        hintText: "Search for products",
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.blue, fontSize: 20),
                    );
                    searchProvider.notifyListeners();
                  } else {
                    searchProvider.search.clear();
                    searchProvider.searchButtonUnPress();
                  }
                }),
            !searchProvider.SearchButton
                ? Consumer<ApiConnectionProvider>(
                    builder: (context, getMyCartProvider, child) {
                    return InkWell(
                        child: Center(
                          child: Badge.Badge(
                            badgeContent: Text(
                              cartItemCount,
                              style: const TextStyle(color: Colors.white),
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/cart-screen');
                        });
                  })
                : const SizedBox(),
            const SizedBox(
              width: 20,
            )
          ]),
        ),
        body: SingleChildScrollView(
          child: !searchProvider.SearchButton ? AllProduct() : CustomProduct(),
        ));
  }
}
