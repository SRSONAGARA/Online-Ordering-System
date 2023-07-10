import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/wishlist_screen/wishlist_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/wishlist_screen/wishlist_screen_state.dart';

import '../product_screen/product_screen_cubit.dart';
import '../product_screen/product_screen_state.dart';

class WishlistScreenBloc extends StatefulWidget {
  const WishlistScreenBloc({Key? key}) : super(key: key);

  @override
  State<WishlistScreenBloc> createState() => _WishlistScreenBlocState();
}

class _WishlistScreenBlocState extends State<WishlistScreenBloc> {
  WishlistScreenCubit? wishlistScreenCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishlistData();
  }

  getWishlistData() async {
    BlocProvider.of<WishlistScreenCubit>(context).getWishListBloc();
    wishlistScreenCubit = WishlistScreenCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
          title: const Text('Wishlist'),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
                  // Navigator.of(context).canPop();
                  // Get.offAllNamed('/homeScreenGetx');
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
          /*actions: [
            InkWell(
                child: Center(
                  child: Badge.Badge(
                    badgeContent: Text(
                      productScreenGetxController.productDataListGetx.totalProduct.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  Get.toNamed('/cartScreenGetx');
                }),
            const SizedBox(
              width: 20,
            )
          ],*/
        ),
        body: SingleChildScrollView(
          child: AllProduct(),
        ));
  }

  Widget AllProduct() {
    return BlocConsumer<WishlistScreenCubit, WishlistScreenState>(
      builder: (context, state) {
        WishlistScreenCubit wishlistScreenCubit =
            BlocProvider.of<WishlistScreenCubit>(context);
        if (state is WishlistScreenLoadingState) {
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
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
        if (state is WishlistEmptyState) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/wishlistEmptyImage.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Oops...!',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const Text("You haven't added any products yet",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Click "),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 15,
                  ),
                  Text(
                    ' to save products',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
               ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(86, 126, 239, 15),),
                    onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
                    },
                    child: const Text('Find items to save')),
            ],
          ));
        }
        if (state is WishlistScreenSuccessState) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              /* bool itemAddedToCart = apiConnectionProvider
            .productDataList[0].data![index].quantity !=
            0;*/
              print('list builder');
              return Card(
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
                                  image: NetworkImage(wishlistScreenCubit
                                      .getWishList
                                      .data![index]
                                      .productDetails
                                      .imageUrl),
                                  height: 120,
                                  // width: 100,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BlocConsumer<ProductListCubit,
                                        ProductScreenState>(
                                      builder: (context, state) {
                                        ProductListCubit productListCubit =
                                            BlocProvider.of(context);
                                        if (productListCubit
                                            .isLoadingList[index]) {
                                          return const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Color.fromRGBO(
                                                  86, 126, 239, 15),
                                            ),
                                          );
                                        } else {
                                          return InkWell(
                                            onTap: () async {
                                              productListCubit
                                                  .updateButtonState(index);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'Please wait, Item will remove from WatchList !'),
                                                      duration: Duration(
                                                          seconds: 2)));

                                              await productListCubit
                                                  .removeFromWatchListBloc(
                                                      wathListItemId:
                                                          wishlistScreenCubit
                                                              .getWishList
                                                              .data![index]
                                                              .id
                                                              .toString(),
                                                      index: index);
                                              await context
                                                  .read<WishlistScreenCubit>()
                                                  .updateWishListBloc();
                                              productListCubit
                                                  .updateButtonDisableState(
                                                      index);
                                            },
                                            child: const Icon(Icons.favorite,
                                                color: Colors.red, size: 20),
                                          );
                                        }
                                      },
                                      listener: (context, state) {},
                                    ),
                                    /* InkWell(
                                      onTap: () async {
                                        */ /* Get.rawSnackbar(message: 'Please wait, Item will remove from WatchList !',
                                      backgroundColor: const Color.fromRGBO(
                                          86,
                                          126,
                                          239,
                                          10),
                                      duration:
                                      const Duration(seconds: 2));
                                  await wishlistScreenGetxController
                                      .removeFromWatchListGetx(
                                      wishlistScreenGetxController
                                          .watchListGetx
                                          .data![index]
                                          .id
                                          .toString());

                                  await wishlistScreenGetxController.getWatchListGetx();
                                  setState(() { });
                                  await productScreenGetxController.getDataGetx();*/ /*
                                      },
                                      child: const Icon(Icons.favorite,
                                          color: Colors.red, size: 20),
                                    )*/
                                  ],
                                ),
                                Text(
                                  wishlistScreenCubit.getWishList.data![index]
                                      .productDetails.title,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  wishlistScreenCubit.getWishList.data![index]
                                      .productDetails.description,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                                Text(
                                  '\$${wishlistScreenCubit.getWishList.data![index].productDetails.price}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                /*Consumer<CartProvider>(
                                        builder: (context, value, child) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(3)),
                                          color: */ /*itemAddedToCart?Colors.red[200]:*/ /*Colors.blue,

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              onTap: () async {
                                                */ /*if (itemAddedToCart !=
                                                    true) {
                                                  String productId =
                                                      apiConnectionProvider
                                                          .watchList[
                                                      0]
                                                          .data![index]
                                                          .productDetails.id;
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

                                                }*/ /*
                                              },
                                              child:  */ /*itemAddedToCart
                                                  ? const Text(
                                                'Added', style: TextStyle(color: Colors.white),)
                                                  :*/ /*const Text('Add To Cart', style: TextStyle(color: Colors.white),)),
                                        ),
                                      );
                                    }),*/
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
            itemCount: wishlistScreenCubit.getWishList.data?.length,
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
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
      },
      listener: (context, state) {},
    );
  }
}
