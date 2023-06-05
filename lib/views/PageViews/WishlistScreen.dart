import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import '../../provider/ApiConnection/ApiConnection_Provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  Widget CustomText = const Text(
    "Wishlist",
  );
  List<int> FavItems = [];

  int cartItemCount = 0;
  List<dynamic> watchListData = [];
  void accessApi(BuildContext context) async {
    final apiConnectionProvider =
        Provider.of<ApiConnectionProvider>(context, listen: false);
    // apiConnectionProvider.isLoading=false;
    apiConnectionProvider.showItemBool = false;
    apiConnectionProvider.isLoading=false;
    await apiConnectionProvider.getWatchList(context);
    watchListData = apiConnectionProvider.productDataList.map((e) => e).toList();
    apiConnectionProvider.showItem();
    cartItemCount = apiConnectionProvider.productDataList[0].totalProduct;
    print('watchListItemCount: $cartItemCount');
  }

  @override
  void initState() {
    super.initState();
    accessApi(context);
  }

  Widget AllProduct() {
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);
    return !apiConnectionProvider.showItemBool
        ? SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(child: CircularProgressIndicator()))
        : apiConnectionProvider.watchList[0].data.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/ 5,
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Click "),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 15,
                      ),
                      Text(
                        " to save products",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/home-screen");
                      },
                      child: const Text('Find items to save')),
                ],
              ))
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool itemAddedToCart = apiConnectionProvider
                      .productDataList[0].data![index].quantity !=
                      0;
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
                                      image: NetworkImage(apiConnectionProvider
                                          .watchList[0]
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Consumer<ApiConnectionProvider>(builder:
                                            (context,
                                                removeFromWatchListProvider,
                                                child) {
                                          return InkWell(
                                            onTap: () async {
                                              String wathListItemId =
                                                  removeFromWatchListProvider
                                                      .watchList[0]
                                                      .data![index]
                                                      .id;
                                              await removeFromWatchListProvider
                                                  .removeFromWatchList(
                                                      wathListItemId);
                                              print('Id: ${wathListItemId}');
                                              removeFromWatchListProvider
                                                  .getWatchList(context);
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
                                              accessApi(context);
                                            },
                                            onDoubleTap: (){},
                                            onLongPress: (){},
                                            child: const Icon(Icons.favorite,
                                                color: Colors.red, size: 20),
                                          );
                                        })
                                      ],
                                    ),
                                    Text(
                                      apiConnectionProvider.watchList[0]
                                          .data![index].productDetails.title,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      apiConnectionProvider
                                          .watchList[0]
                                          .data![index]
                                          .productDetails
                                          .description,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                    Text(
                                      '\$${apiConnectionProvider.watchList[0].data![index].productDetails.price}',
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
                                          color: *//*itemAddedToCart?Colors.red[200]:*//*Colors.blue,

                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              onTap: () async {
                                                *//*if (itemAddedToCart !=
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

                                                }*//*
                                              },
                                              child:  *//*itemAddedToCart
                                                  ? const Text(
                                                'Added', style: TextStyle(color: Colors.white),)
                                                  :*//*const Text('Add To Cart', style: TextStyle(color: Colors.white),)),
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
                itemCount: apiConnectionProvider.watchList[0].data.length,
              );
  }

  @override
  Widget build(BuildContext context) {
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home-screen', (route) => false);
        return false;
      },      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: CustomText,
          centerTitle: true,
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
                    badgeContent: Text(cartItemCount.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    child:  const Icon(Icons.shopping_cart_outlined, color: Colors.white,),
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
        body:  apiConnectionProvider.isLoading? const Center(child: CircularProgressIndicator()):  SingleChildScrollView(child: AllProduct()),
      ),
    );
  }
}
