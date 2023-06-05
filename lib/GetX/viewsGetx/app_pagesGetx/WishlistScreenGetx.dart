import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ControllersGetx/ApiConnection_Getx/ProductScreenGetxController.dart';
import '../../ControllersGetx/ApiConnection_Getx/WishlistScreenGetxController.dart';
import '../../ControllersGetx/SearchGetxController.dart';

class WishlistScreenGetx extends StatefulWidget {
  const WishlistScreenGetx({Key? key}) : super(key: key);

  @override
  State<WishlistScreenGetx> createState() => _WishlistScreenGetxState();
}

class _WishlistScreenGetxState extends State<WishlistScreenGetx> {
  /* @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var wishlistScreenGetxController = Get.put(WishlistScreenGetxController());
    wishlistScreenGetxController.getWatchListGetx();
  }*/

  var wishlistScreenGetxController = Get.put(WishlistScreenGetxController());
  var productScreenGetxController = Get.put(ProductScreenGetxController());
  var searchGetxController = Get.put(SearchGetxController());


  @override
  Widget build(BuildContext context) {
    return  GetBuilder<WishlistScreenGetxController>(builder: (wishlistScreenGetxController){
      return WillPopScope(child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(86, 126, 239, 15),
            title: Text('Wishlist'.tr),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                  onTap: () {
                    // Navigator.of(context).canPop();
                    Get.offAllNamed('/homeScreenGetx');
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
          )), onWillPop: ()async{
        if(searchGetxController.SearchButton == true){
          searchGetxController.searchButtonUnPress();
          Get.offNamedUntil('/homeScreenGetx', (route) => false);
          return true;
        }
        else{
          Get.offNamedUntil('/homeScreenGetx', (route) => false);
          return false;
        }
      });
    });
  }

  Widget AllProduct() {
    return wishlistScreenGetxController.watchListGetx.data!.isEmpty? Center(
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
                 Text(
                  'Oops...!'.tr,
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                 Text("You haven't added any products yet".tr,
                    style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text("Click ".tr),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 15,
                    ),
                    Text(
                      ' to save products'.tr,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
               /* ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(86, 126, 239, 15),),
                    onPressed: () {
                    Get.offNamedUntil('/homeScreenGetx', (route) => false);
                    },
                    child: const Text('Find items to save')),*/
              ],
            ))
            : Obx(() => productScreenGetxController.isLoading.value || wishlistScreenGetxController.isLoading.value
            ?  Container(
      height: Get.height/1.3,
              child: Center(
                  child:  AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: const Color.fromRGBO(86, 126, 239, 15),), SizedBox(width: 20,),Text('Loading...'.tr)],),),
              ),
            )
            : ListView.builder(
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
                                image: NetworkImage(
                                    wishlistScreenGetxController
                                        .watchListGetx
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
                                  InkWell(
                                    onTap: () async {
                                      Get.rawSnackbar(message: 'Please wait, Item will remove from WatchList !'.tr,
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
                                      await productScreenGetxController.getDataGetx();
                                    },
                                    onDoubleTap: () {},
                                    onLongPress: () {},
                                    child: const Icon(Icons.favorite,
                                        color: Colors.red, size: 20),
                                  )
                                ],
                              ),
                              Text(
                                wishlistScreenGetxController.watchListGetx
                                    .data![index].productDetails.title,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                wishlistScreenGetxController
                                    .watchListGetx
                                    .data![index]
                                    .productDetails
                                    .description,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                              Text(
                                '\$${wishlistScreenGetxController.watchListGetx.data![index].productDetails.price}',
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
          itemCount:
          wishlistScreenGetxController.watchListGetx.data?.length,
        ));
  }
}
