import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/cart_screen/cart_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/cart_screen/cart_screen_state.dart';

class CartScreenBloc extends StatefulWidget {
  const CartScreenBloc({Key? key}) : super(key: key);

  @override
  State<CartScreenBloc> createState() => _CartScreenBlocState();
}

class _CartScreenBlocState extends State<CartScreenBloc> {
  CartScreenCubit? cartScreenCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartListData();
  }

  getCartListData() async {
    BlocProvider.of<CartScreenCubit>(context).getMyCartBloc();
    cartScreenCubit = CartScreenCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
          title: const Text('Cart'),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
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
                    wishlistScreenGetxController.watchListGetx.data.length
                        .toString(),
                    // watchListItemCount.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.favorite_outline),
                ),
              ),
              onTap: () {
                Get.toNamed('/wishlistScreenGetx');
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],*/
        ),
        body: SingleChildScrollView(child: AllProduct()),
        bottomNavigationBar: /*Obx(() => cartScreenGetxController.isLoading.value
            ? Container(
          padding: const EdgeInsets.all(10.0),
          color: const Color.fromRGBO(86, 126, 239, 205),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                    '${'Total Items'}${cartScreenGetxController.cartGetx.data!.isEmpty ? 0 : cartScreenGetxController.cartGetx.data!.length}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Expanded(
                  child: Text(
                    '${'Total Price'} \$${cartScreenGetxController.cartGetx.data!.isEmpty ? 0 : cartScreenGetxController.cartGetx.cartTotal!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return cartScreenGetxController
                              .cartGetx.data!.isNotEmpty
                              ? AlertDialog(
                            title:  Text(
                                "Confirm to Place Order"),
                            content: Text(
                                "You added"+" ${cartScreenGetxController.cartGetx.data!.isEmpty ? 0 : cartScreenGetxController.cartGetx.data!.length} "+"Product and Total Price"+" \$${cartScreenGetxController.cartGetx.data!.isEmpty ? 0 : cartScreenGetxController.cartGetx.cartTotal}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child:  Text('Not Now'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(3)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: () async {
                                        String cartId =
                                        cartScreenGetxController
                                            .cartGetx
                                            .data![0]
                                            .cartId
                                            .toString();
                                        String cartTotal =
                                        cartScreenGetxController
                                            .cartGetx.cartTotal
                                            .toString();
                                        print('cartId= $cartId');
                                        print('cartTotal= $cartTotal');
                                        Get.back();
                                        // AlertDialog(content: Container(child: ,),);
                                        */ /*Get.rawSnackbar(
                                              message:
                                              'Please wait, Your order will be placed !',
                                              backgroundColor:
                                              const Color.fromRGBO(
                                                  86, 126, 239, 10),
                                              duration: const Duration(
                                                  seconds: 2));*/ /*

                                        await orderScreenGetxController
                                            .placeOrderGetx(
                                            cartId, cartTotal);
                                        firebaseGetxController.sendPushNotification('Online Ordering System', 'Your order has been placed !');

                                        await cartScreenGetxController
                                            .getMyCartGetx();
                                        await orderScreenGetxController
                                            .getOrderHistoryGetx();
                                        await productScreenGetxController
                                            .getDataGetx();

                                      },

                                      onDoubleTap: () {},
                                      onLongPress: () {},
                                      child: Text('Place Order', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),
                                ),
                              )
                            ],
                          )
                              : AlertDialog(
                            title:  Text(
                                "No Items Added in Cart"),
                            content:  Text(
                                "Please add item in cart"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child:  Text('Not Now'),
                              ),
                              TextButton(
                                  child:  Text('Okay'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ],
                          );
                        });
                  },
                  child: Container(
                    // height: size.height / 15,
                    padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: Colors.red[400]
                      */ /*gradient: LinearGradient(colors: [
                              Colors.redAccent,
                              Colors.redAccent
                            ])*/ /*
                    ),
                    child:  Center(
                        child: Text(
                          "Place Order",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
            ],
          ),
        )
            :*/
            BlocConsumer<CartScreenCubit, CartScreenState>(
          builder: (context, state) {
            CartScreenCubit cartScreenCubit =
                BlocProvider.of<CartScreenCubit>(context);
            if (state is CartScreenLoadingState) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                color: Color.fromRGBO(86, 126, 239, 205),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      '${'Total Items'}${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.data!.length}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Expanded(
                        child: Text(
                      '${'Total Price'} \$${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.cartTotal!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return cartScreenCubit
                                        .getMyCart.data!.isNotEmpty
                                    ? AlertDialog(
                                        title: Text("Confirm to Place Order"),
                                        content: Text("You added" +
                                            " ${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.data!.length} " +
                                            "Product and Total Price" +
                                            " \$${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.cartTotal}"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Not Now'),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () async {
                                                    /*        String cartId =
                                            cartScreenGetxController
                                                .cartGetx
                                                .data![0]
                                                .cartId
                                                .toString();
                                            String cartTotal =
                                            cartScreenGetxController
                                                .cartGetx.cartTotal
                                                .toString();
                                            print('cartId= $cartId');
                                            print('cartTotal= $cartTotal');
                                            Get.back();

                                            await orderScreenGetxController
                                                .placeOrderGetx(
                                                cartId, cartTotal);
                                            firebaseGetxController.sendPushNotification('Online Ordering System', 'Your order has been placed !');

                                            await cartScreenGetxController
                                                .getMyCartGetx();
                                            await orderScreenGetxController
                                                .getOrderHistoryGetx();
                                            await productScreenGetxController
                                                .getDataGetx();*/
                                                  },
                                                  onDoubleTap: () {},
                                                  onLongPress: () {},
                                                  child: Text(
                                                    'Place Order',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ),
                                          )
                                        ],
                                      )
                                    : AlertDialog(
                                        title: Text("No Items Added in Cart"),
                                        content:
                                            Text("Please add item in cart"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Not Now'),
                                          ),
                                          TextButton(
                                              child: Text('Okay'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      );
                              });
                        },
                        child: Container(
                          // height: size.height / 15,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: Colors.red[400]
                              /*gradient: LinearGradient(colors: [
                              Colors.redAccent,
                              Colors.redAccent
                            ])*/
                              ),
                          child: Center(
                              child: Text(
                            "Place Order",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is CartScreenSuccessState) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                color: Color.fromRGBO(86, 126, 239, 205),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      '${'Total Items'}${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.data!.length}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Expanded(
                        child: Text(
                      '${'Total Price'} \$${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.cartTotal!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return cartScreenCubit
                                        .getMyCart.data!.isNotEmpty
                                    ? AlertDialog(
                                        title: Text("Confirm to Place Order"),
                                        content: Text("You added" +
                                            " ${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.data!.length} " +
                                            "Product and Total Price" +
                                            " \$${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.cartTotal}"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Not Now'),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                  onTap: () async {
                                                    /* String cartId =
                                        cartScreenGetxController
                                            .cartGetx
                                            .data![0]
                                            .cartId
                                            .toString();
                                        String cartTotal =
                                        cartScreenGetxController
                                            .cartGetx.cartTotal
                                            .toString();
                                        print('cartId= $cartId');
                                        print('cartTotal= $cartTotal');
                                        Get.back();
                                        Get.rawSnackbar(
                                            message:
                                            'Please wait, Your order will be placed !',
                                            backgroundColor:
                                            const Color.fromRGBO(
                                                86, 126, 239, 10),
                                            duration: const Duration(
                                                seconds: 2));
                                        await orderScreenGetxController
                                            .placeOrderGetx(
                                            cartId, cartTotal);

                                        firebaseGetxController.sendPushNotification('Online Ordering System', 'Your order has been placed !');
                                        await cartScreenGetxController
                                            .getMyCartGetx();
                                        await orderScreenGetxController
                                            .getOrderHistoryGetx();
                                        await productScreenGetxController
                                            .getDataGetx();*/
                                                  },
                                                  onDoubleTap: () {},
                                                  onLongPress: () {},
                                                  child: Text(
                                                    'Place Order',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ),
                                          )
                                        ],
                                      )
                                    : AlertDialog(
                                        title: Text("No Items Added in Cart"),
                                        content:
                                            Text("Please add item in cart"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Not Now'),
                                          ),
                                          TextButton(
                                              child: Text('Okay'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      );
                              });
                        },
                        child: Container(
                          // height: size.height / 15,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: Colors.red[400]
                              /*gradient: LinearGradient(colors: [
                              Colors.redAccent,
                              Colors.redAccent
                            ])*/
                              ),
                          child: const Center(
                              child: Text(
                            "Place Order",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.all(10.0),
              color: Color.fromRGBO(86, 126, 239, 205),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    '${'Total Items'}${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.data!.length}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Expanded(
                      child: Text(
                    '${'Total Price'} \$${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.cartTotal!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return cartScreenCubit.getMyCart.data!.isNotEmpty
                                  ? AlertDialog(
                                      title: Text("Confirm to Place Order"),
                                      content: Text("You added" +
                                          " ${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.data!.length} " +
                                          "Product and Total Price" +
                                          " \$${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.cartTotal}"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Not Now'),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                                onTap: () async {
                                                  /*        String cartId =
                                            cartScreenGetxController
                                                .cartGetx
                                                .data![0]
                                                .cartId
                                                .toString();
                                            String cartTotal =
                                            cartScreenGetxController
                                                .cartGetx.cartTotal
                                                .toString();
                                            print('cartId= $cartId');
                                            print('cartTotal= $cartTotal');
                                            Get.back();

                                            await orderScreenGetxController
                                                .placeOrderGetx(
                                                cartId, cartTotal);
                                            firebaseGetxController.sendPushNotification('Online Ordering System', 'Your order has been placed !');

                                            await cartScreenGetxController
                                                .getMyCartGetx();
                                            await orderScreenGetxController
                                                .getOrderHistoryGetx();
                                            await productScreenGetxController
                                                .getDataGetx();*/
                                                },
                                                onDoubleTap: () {},
                                                onLongPress: () {},
                                                child: const Text(
                                                  'Place Order',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                        )
                                      ],
                                    )
                                  : AlertDialog(
                                      title: Text("No Items Added in Cart"),
                                      content: Text("Please add item in cart"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Not Now'),
                                        ),
                                        TextButton(
                                            child: Text('Okay'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    );
                            });
                      },
                      child: Container(
                        // height: size.height / 15,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            color: Colors.red[400]
                            /*gradient: LinearGradient(colors: [
                              Colors.redAccent,
                              Colors.redAccent
                            ])*/
                            ),
                        child: const Center(
                            child: Text(
                          "Place Order",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context, state) {},
        ));
  }

  Widget AllProduct() {
    return /*cartScreenGetxController.cartGetx.data!.isEmpty
        ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Image.asset('assets/cartEmpty.png'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Oops...!',
              style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text('Your Cart is empty !',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            */ /*ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeScreenGetx()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(86, 126, 239, 15),
                  ),
                  child: const Text('Find items to save')),*/ /*
          ],
        ))
        : Obx(() => cartScreenGetxController.isLoading.value
        ?
      Container(
      height: MediaQuery.of(context).size.height/1.3,
      child:  Center(
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: const Color.fromRGBO(86, 126, 239, 15),), SizedBox(width: 20,),Text('Loading...')],),),
      ),
    )
        :*/
        BlocConsumer<CartScreenCubit, CartScreenState>(
      builder: (context, state) {
        CartScreenCubit cartScreenCubit =
            BlocProvider.of<CartScreenCubit>(context);
        if (state is CartScreenLoadingState) {
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
        }
        if(state is CartEmptyState){
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  Image.asset('assets/cartEmpty.png'),
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
                  const SizedBox(
                    height: 5,
                  ),
                  const Text('Your Cart is empty !',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(
                    height: 20,
                  ),
                  /*ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomeScreenGetx()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(86, 126, 239, 15),
                  ),
                  child: const Text('Find items to save')),*/
                ],
              ));
        }
        if (state is CartScreenSuccessState) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                /* bool isFavourite = favoriteProvider.FavItems.any((element) =>
              element.productName
                  .contains(cartProvider.CartItems[index].productName));*/

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
                                    image: NetworkImage(cartScreenCubit
                                        .getMyCart
                                        .data![index]
                                        .productDetails
                                        .imageUrl),
                                    height: 120,
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
                                  Text(
                                    cartScreenCubit.getMyCart.data![index]
                                        .productDetails.title,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    cartScreenCubit.getMyCart.data![index]
                                        .productDetails.description,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                  Text(
                                    '\$${cartScreenCubit.getMyCart.data![index].productDetails.price}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                                color: Colors.grey,
                                              ),
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 10.0),
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                      Icons.delete_forever),
                                                  Text('Remove')
                                                ],
                                              ),
                                            ),
                                            onTap: () async {
                                              /*if (cartScreenCubit.getMyCart.data!.isEmpty) {
                                            print('your cart is empty');
                                          } else {
                                            Get.rawSnackbar(
                                                message:
                                                'Please wait, Item will remove from Cart !',
                                                backgroundColor:
                                                const Color.fromRGBO(
                                                    86, 126, 239, 10),
                                                duration: const Duration(
                                                    seconds: 2));
                                            await cartScreenGetxController
                                                .removeProductFromCartGetx(
                                                cartScreenGetxController
                                                    .cartGetx
                                                    .data![index]
                                                    .id
                                                    .toString());
                                          }
                                          await cartScreenGetxController
                                              .getMyCartGetx();
                                          await productScreenGetxController
                                              .getDataGetx();
*/
                                            },
                                            onDoubleTap: () {},
                                            onLongPress: () {},
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, right: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      /* if (cartScreenCubit.getMyCart
                                                      .data![index]
                                                      .quantity == 1) {
                                                    Get.rawSnackbar(
                                                        message:
                                                        'Please wait, Item will remove from Cart !',
                                                        backgroundColor:
                                                        const Color.fromRGBO(
                                                            86,
                                                            126,
                                                            239,
                                                            10),
                                                        duration: const Duration(
                                                            seconds:2));
                                                  }else{
                                                    Get.rawSnackbar(message: 'Please wait, Quantity will be decreased !',backgroundColor: const Color.fromRGBO(
                                                        86,
                                                        126,
                                                        239,
                                                        10),
                                                        duration:
                                                        Duration(seconds: 2));
                                                  }
                                                  await cartScreenGetxController
                                                      .decreaseProductQuantityGetx(
                                                      cartScreenGetxController
                                                          .cartGetx
                                                          .data![
                                                      index]
                                                          .id);

                                                  await cartScreenGetxController
                                                      .getMyCartGetx();
                                                  await productScreenGetxController
                                                      .getDataGetx();*/
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      radius: 14,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    cartScreenCubit.getMyCart
                                                        .data![index].quantity
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      /* Get.rawSnackbar(message: 'Please wait, Quantity will be increased !',backgroundColor: const Color.fromRGBO(
                                                      86,
                                                      126,
                                                      239,
                                                      10),
                                                      duration:
                                                      Duration(seconds: 2));
                                                  await cartScreenGetxController
                                                      .increaseProductQuantityGetx(
                                                      cartScreenGetxController
                                                          .cartGetx
                                                          .data![
                                                      index]
                                                          .id);
                                                  await cartScreenGetxController
                                                      .getMyCartGetx();
                                                  await productScreenGetxController
                                                      .getDataGetx();*/
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      radius: 14,
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
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
                  ),
                );
              },
              itemCount: cartScreenCubit.getMyCart.data!.length);
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
