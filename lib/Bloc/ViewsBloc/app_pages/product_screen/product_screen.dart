import 'package:badges/badges.dart' as Badge;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_detail_screen/product_detail_screen.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_state.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/search_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/search_state.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/drawer_screen/drawer_screen.dart';

class ProductScreenBloc extends StatefulWidget {
  const ProductScreenBloc({Key? key}) : super(key: key);

  @override
  State<ProductScreenBloc> createState() => _ProductScreenBlocState();
}

class _ProductScreenBlocState extends State<ProductScreenBloc> {
  ProductScreenCarouselCubit? productScreenCarouselCubit;
  ProductListCubit? productListCubit;
  SearchCubit? searchCubit;

  List<dynamic> searchItems = [];

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
    searchItems = productListCubit!.productDataListBloc.data;
  }

  void updateSearchItems() {
    ProductListCubit productListCubit =
        BlocProvider.of<ProductListCubit>(context);
    searchItems = productListCubit.productDataListBloc.data;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        SearchCubit searchCubit = BlocProvider.of<SearchCubit>(context);
        return Scaffold(
            drawer: const DrawerScreenBloc(),
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
              title: searchCubit.customText,
              centerTitle: true,
              leading: searchCubit.searchButton
                  ? IconButton(
                      onPressed: () {
                        if (state is SearchButtonPressedState) {
                          searchCubit.searchButtonPress();
                        }
                        searchCubit.searchButtonUnPress();
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
                    }),
              actions: ([
                BlocBuilder<ProductListCubit, ProductScreenState>(
                  builder: (context, state) {
                    ProductListCubit productListCubit =
                        BlocProvider.of<ProductListCubit>(context);

                    return IconButton(
                        icon: searchCubit.customSearchIcon,
                        onPressed: () {
                          searchItems =
                              productListCubit.productDataListBloc.data;
                          setState(() {});
                          if (searchCubit.customSearchIcon.icon ==
                              Icons.search) {
                            searchCubit.searchButton = true;
                            searchCubit.customSearchIcon = const Icon(
                              Icons.clear_outlined,
                              color: Colors.white,
                            );
                            searchCubit.customText = TextField(
                              textInputAction: TextInputAction.go,
                              controller: searchCubit.searchController,
                              onChanged: (value) {
                                List<dynamic> results = [];
                                if (value.isEmpty) {
                                  results = searchItems;
                                } else {
                                  results = productListCubit
                                      .productDataListBloc.data
                                      .where((element) => element.title
                                          .toString()
                                          .toLowerCase()
                                          .contains(value.toString()))
                                      .toList();
                                }
                                setState(() {});
                                if (results.isEmpty) {
                                  searchCubit.searchListIsEmpty();
                                } else {
                                  searchCubit.searchListIsNotEmpty();
                                }
                                searchItems = results;
                                setState(() {});
                              },
                              decoration: const InputDecoration(
                                hintText: "Search for products",
                                hintStyle: TextStyle(color: Colors.white60),
                              ),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            );
                          } else {
                            searchCubit.searchController.clear();
                            // searchCubit.searchButtonUnPress();
                            setState(() {});
                          }
                        });
                  },
                ),
                InkWell(
                  child: Center(
                    child: Badge.Badge(
                      badgeContent:
                          BlocBuilder<ProductListCubit, ProductScreenState>(
                        builder: (context, state) {
                          ProductListCubit productListCubit =
                              BlocProvider.of<ProductListCubit>(context);
                          if (state is ProductScreenLoadingState) {}
                          return Text(
                              productListCubit.productDataListBloc.totalProduct
                                  .toString(),
                              style: const TextStyle(color: Colors.white));
                        },
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        // color: Colors.blue,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/cartScreen');
                  },
                  onDoubleTap: () {},
                  onLongPress: () {},
                ),
                const SizedBox(
                  width: 20,
                )
              ]),
            ),
            body: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                SearchCubit searchCubit = BlocProvider.of<SearchCubit>(context);
                return SingleChildScrollView(
                    child: searchCubit.searchButton
                        ? CustomProduct()
                        : AllProduct());
              },
            ));
      },
    );
  }

  Widget CustomProduct() {
    /*final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);
*/
    print('CustomProduct');
    return BlocConsumer<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchListEmptyState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: const Center(
              child: Text(
                "No items match your search...",
                style: TextStyle(fontSize: 15),
              ),
            ),
          );
        }
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<ProductListCubit, ProductScreenState>(
              builder: (context, state) {
                ProductListCubit productListCubit =
                    BlocProvider.of<ProductListCubit>(context);
                return ListView.builder(
                    itemBuilder: (context, index) {
                      bool isFavourite =
                          searchItems[index].watchListItemId != '';
                      bool itemAddedToCart = searchItems[index].quantity != 0;
                      return InkWell(
                          onTap: () {
                            /*Navigator.pushNamed(context, '/productDetails-screen',
                      arguments: productData[0].data![index]);*/
                          },
                          child: Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 5),
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
                                                  searchItems[index].imageUrl),
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
                                                BlocBuilder<ProductListCubit,
                                                    ProductScreenState>(
                                                  builder: (context, state) {
                                                    ProductListCubit
                                                        productListCubit =
                                                        BlocProvider.of<
                                                                ProductListCubit>(
                                                            context);
                                                    if (state
                                                            is WatchListBtnLoadingState ||
                                                        state
                                                            is CartListBtnLoadingState) {
                                                      if (productListCubit
                                                              .isLoadingList[
                                                          index]) {
                                                        return const SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color:
                                                                Color.fromRGBO(
                                                                    86,
                                                                    126,
                                                                    239,
                                                                    15),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                    return InkWell(
                                                      onTap: () async {
                                                        if (isFavourite ==
                                                            true) {
                                                          productListCubit
                                                              .updateFavButtonState(
                                                                  index);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(const SnackBar(
                                                                  content: Text(
                                                                      'Please wait, Item will remove from WatchList !'),
                                                                  duration: Duration(
                                                                      seconds:
                                                                          2)));

                                                          await productListCubit
                                                              .removeFromWatchListBloc(
                                                                  wathListItemId: searchItems[
                                                                          index]
                                                                      .watchListItemId
                                                                      .toString());
                                                          updateSearchItems();
                                                          productListCubit
                                                              .updateFavButtonDisableState(
                                                                  index);
                                                        } else {
                                                          productListCubit
                                                              .updateFavButtonState(
                                                                  index);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(const SnackBar(
                                                                  content: Text(
                                                                      'Please wait, Item will be Added to WatchList !'),
                                                                  duration: Duration(
                                                                      seconds:
                                                                          2)));

                                                          await productListCubit
                                                              .addToWatchListBloc(
                                                                  productId: searchItems[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                          updateSearchItems();

                                                          productListCubit
                                                              .updateFavButtonDisableState(
                                                                  index);
                                                        }
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
                                                  },
                                                )
                                              ],
                                            ),
                                            Text(
                                              searchItems[index]
                                                  .title
                                                  .toString(),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              searchItems[index]
                                                  .description
                                                  .toString(),
                                              maxLines: 2,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              '\$${searchItems[index].price}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            BlocBuilder<ProductListCubit,
                                                ProductScreenState>(
                                              builder: (context, state) {
                                                ProductListCubit
                                                    productListCubit =
                                                    BlocProvider.of(context);
                                                if (state
                                                        is CartListBtnLoadingState ||
                                                    state
                                                        is WatchListBtnLoadingState) {
                                                  if (productListCubit
                                                      .isLoadingList1[index]) {
                                                    return const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color:
                                                                Color.fromRGBO(
                                                                    86,
                                                                    126,
                                                                    239,
                                                                    15),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                }
                                                return ElevatedButton(
                                                    onPressed: () async {
                                                      if (itemAddedToCart !=
                                                          true) {
                                                        productListCubit
                                                            .updateCartButtonState(
                                                                index);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(const SnackBar(
                                                                content: Text(
                                                                    'Please wait, Item will be Added to Cart !'),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            2)));
                                                        await productListCubit
                                                            .addToCartBloc(
                                                                productId:
                                                                    searchItems[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                index: index);
                                                        updateSearchItems();

                                                        productListCubit
                                                            .updateCartButtonDisableState(
                                                                index);
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: itemAddedToCart
                                                          ? Colors.red[200]
                                                          : const Color
                                                                  .fromRGBO(
                                                              86, 126, 239, 10),
                                                    ),
                                                    child: itemAddedToCart
                                                        ? const Text(
                                                            'Item is already Added')
                                                        : const Text(
                                                            'Add To Cart'));
                                              },
                                            )
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
                    itemCount: searchItems.length);
              },
            ));
      },
      listener: (context, state) {},
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
            listener: (context, state) {
              if (state is ProductScreenErrorState) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/loginScreen', (route) => false);
              }
            },
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
                            .productDataListBloc.data![index].quantity !=
                        0;

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductDetailScreenBloc(),
                            settings: RouteSettings(arguments: {
                              'Price': productListCubit
                                  .productDataListBloc.data[index].price,
                              'Name': productListCubit
                                  .productDataListBloc.data[index].title,
                              'ImageURL': productListCubit
                                  .productDataListBloc.data[index].imageUrl,
                              'ShortDescription': productListCubit
                                  .productDataListBloc.data[index].description,
                              'Index': index,
                            })));
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
                                                BlocBuilder<ProductListCubit,
                                                    ProductScreenState>(
                                                  builder: (context, state) {
                                                    ProductListCubit
                                                        productListCubit =
                                                        BlocProvider.of(
                                                            context);
                                                    if (state
                                                            is WatchListBtnLoadingState ||
                                                        state
                                                            is CartListBtnLoadingState) {
                                                      if (productListCubit
                                                              .isLoadingList[
                                                          index]) {
                                                        return const SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color:
                                                                Color.fromRGBO(
                                                                    86,
                                                                    126,
                                                                    239,
                                                                    15),
                                                          ),
                                                        );
                                                      }
                                                    }
                                                    return InkWell(
                                                      onTap: () async {
                                                        if (isFavourite ==
                                                            true) {
                                                          productListCubit
                                                              .updateFavButtonState(
                                                                  index);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(const SnackBar(
                                                                  content: Text(
                                                                      'Please wait, Item will remove from WatchList !'),
                                                                  duration: Duration(
                                                                      seconds:
                                                                          2)));

                                                          await productListCubit
                                                              .removeFromWatchListBloc(
                                                                  wathListItemId: productListCubit
                                                                      .productDataListBloc
                                                                      .data![
                                                                          index]
                                                                      .watchListItemId
                                                                      .toString());
                                                          productListCubit
                                                              .updateFavButtonDisableState(
                                                                  index);
                                                        } else {
                                                          productListCubit
                                                              .updateFavButtonState(
                                                                  index);
                                                          ScaffoldMessenger.of(
                                                                  context)
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
                                                                      .toString());
                                                          productListCubit
                                                              .updateFavButtonDisableState(
                                                                  index);
                                                        }
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
                                                  },
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
                                            BlocBuilder<ProductListCubit,
                                                ProductScreenState>(
                                              builder: (context, state) {
                                                ProductListCubit
                                                    productListCubit =
                                                    BlocProvider.of(context);
                                                if (state
                                                        is CartListBtnLoadingState ||
                                                    state
                                                        is WatchListBtnLoadingState) {
                                                  if (productListCubit
                                                      .isLoadingList1[index]) {
                                                    return const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color:
                                                                Color.fromRGBO(
                                                                    86,
                                                                    126,
                                                                    239,
                                                                    15),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                }
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                            color: itemAddedToCart
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
                                                                onTap:
                                                                    () async {
                                                                  if (itemAddedToCart !=
                                                                      true) {
                                                                    productListCubit
                                                                        .updateCartButtonState(
                                                                            index);
                                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                        content:
                                                                            Text(
                                                                                'Please wait, Item will be Added to Cart !'),
                                                                        duration:
                                                                            Duration(seconds: 2)));
                                                                    await productListCubit.addToCartBloc(
                                                                        productId: productListCubit
                                                                            .productDataListBloc
                                                                            .data[
                                                                                index]
                                                                            .id
                                                                            .toString(),
                                                                        index:
                                                                            index);
                                                                    productListCubit
                                                                        .updateCartButtonDisableState(
                                                                            index);
                                                                  }
                                                                },
                                                                child: itemAddedToCart
                                                                    ? const Text(
                                                                        'Added',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    : const Text(
                                                                        'Add To Cart',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    !itemAddedToCart
                                                        ? const SizedBox()
                                                        : Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      productListCubit
                                                                          .updateCartButtonState(
                                                                              index);
                                                                      if (productListCubit
                                                                              .productDataListBloc
                                                                              .data[index]
                                                                              .quantity ==
                                                                          1) {
                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Please wait, Item will remove from Cart !'),
                                                                            duration: Duration(seconds: 2)));
                                                                      } else {
                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text('Please wait, Quantity will be decreased !'),
                                                                            duration: Duration(seconds: 2)));
                                                                      }

                                                                      await productListCubit.decreaseProductQuantityBloc(
                                                                          cartItemId: productListCubit
                                                                              .productDataListBloc
                                                                              .data[index]
                                                                              .cartItemId
                                                                              .toString());

                                                                      productListCubit
                                                                          .updateCartButtonDisableState(
                                                                              index);
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      radius:
                                                                          14,
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove,
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
                                                                    productListCubit
                                                                        .productDataListBloc
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
                                                                    onTap:
                                                                        () async {
                                                                      productListCubit
                                                                          .updateCartButtonState(
                                                                              index);
                                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                          content: Text(
                                                                              'Please wait, Quantity will be increased !'),
                                                                          duration:
                                                                              Duration(seconds: 2)));
                                                                      await productListCubit.increaseProductQuantityBloc(
                                                                          cartItemId: productListCubit
                                                                              .productDataListBloc
                                                                              .data[index]
                                                                              .cartItemId
                                                                              .toString());

                                                                      productListCubit
                                                                          .updateCartButtonDisableState(
                                                                              index);
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .grey[200],
                                                                      radius:
                                                                          14,
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
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
                                                );
                                              },
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
                  itemCount: productListCubit!.productDataListBloc.data.length);
            },
          )
        ],
      ),
    );
  }
}
