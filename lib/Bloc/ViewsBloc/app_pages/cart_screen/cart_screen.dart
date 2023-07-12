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
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/homeScreen', (route) => false);
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
        bottomNavigationBar: BlocConsumer<CartScreenCubit, CartScreenState>(
          builder: (context, state) {
            CartScreenCubit cartScreenCubit =
                BlocProvider.of<CartScreenCubit>(context);
            if (state is CartScreenLoadingState) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                color: const Color.fromRGBO(86, 126, 239, 205),
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
                                        title: const Text(
                                            "Confirm to Place Order"),
                                        content: Text(
                                            "You added ${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.data!.length} Product and Total Price \$${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.cartTotal}"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Not Now'),
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
                                                    String cartId =
                                                        cartScreenCubit
                                                            .getMyCart
                                                            .data![0]
                                                            .cartId
                                                            .toString();
                                                    String cartTotal =
                                                        cartScreenCubit
                                                            .getMyCart.cartTotal
                                                            .toString();
                                                    Navigator.of(context).pop();
                                                    await cartScreenCubit
                                                        .placeOrderBloc(
                                                            cartId, cartTotal);
                                                    cartScreenCubit
                                                        .sendPushNotification(
                                                            'Online Ordering System',
                                                            'Your order has been placed !');
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
                                        title: const Text(
                                            "No Items Added in Cart"),
                                        content: const Text(
                                            "Please add item in cart"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Not Now'),
                                          ),
                                          TextButton(
                                              child: const Text('Okay'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      );
                              });
                        },
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: Colors.red[400]),
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
              color: const Color.fromRGBO(86, 126, 239, 205),
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
                                      title:
                                          const Text("Confirm to Place Order"),
                                      content: Text(
                                          "You added ${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.data!.length} Product and Total Price \$${cartScreenCubit.getMyCart.data!.isEmpty ? 0 : cartScreenCubit.getMyCart.cartTotal}"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Not Now'),
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
                                                  String cartId =
                                                      cartScreenCubit.getMyCart
                                                          .data![0].cartId
                                                          .toString();
                                                  String cartTotal =
                                                      cartScreenCubit
                                                          .getMyCart.cartTotal
                                                          .toString();
                                                  Navigator.of(context).pop();
                                                  await cartScreenCubit
                                                      .placeOrderBloc(
                                                          cartId, cartTotal);
                                                  cartScreenCubit.sendPushNotification(
                                                      'Online Ordering System',
                                                      'Your order has been placed !');
                                                },
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
                                      title:
                                          const Text("No Items Added in Cart"),
                                      content:
                                          const Text("Please add item in cart"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Not Now'),
                                        ),
                                        TextButton(
                                            child: const Text('Okay'),
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
                            color: Colors.red[400]),
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
    return BlocConsumer<CartScreenCubit, CartScreenState>(
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
        if (state is CartEmptyState) {
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/homeScreen', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(86, 126, 239, 15),
                  ),
                  child: const Text('Find items to save')),
            ],
          ));
        }
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
                                  image: NetworkImage(cartScreenCubit.getMyCart
                                      .data![index].productDetails.imageUrl),
                                  height: 120,
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
                                BlocBuilder<CartScreenCubit, CartScreenState>(
                                  builder: (context, state) {
                                    if (state
                                        is CartBtnInCartScreenLoadingState) {
                                      if (cartScreenCubit
                                          .isLoadingCartList[index]) {
                                        return const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Color.fromRGBO(
                                                    86, 126, 239, 15),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(3)),
                                                  color: Colors.grey,
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 10.0),
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.delete_forever),
                                                    Text('Remove')
                                                  ],
                                                ),
                                              ),
                                              onTap: () async {
                                                if (cartScreenCubit
                                                    .getMyCart.data!.isEmpty) {
                                                  print('your cart is empty');
                                                } else {
                                                  cartScreenCubit
                                                      .updateCartButtonState(
                                                          index);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Please wait, Item will remove from Cart !'),
                                                          duration: Duration(
                                                              seconds: 2)));
                                                  await cartScreenCubit
                                                      .removeProductFromCartBloc(
                                                          cartItemId:
                                                              cartScreenCubit
                                                                  .getMyCart
                                                                  .data![index]
                                                                  .id
                                                                  .toString());
                                                  cartScreenCubit
                                                      .updateCartButtonDisableState(
                                                          index);
                                                  if (cartScreenCubit.getMyCart
                                                      .data!.isEmpty) {
                                                    await cartScreenCubit
                                                        .getMyCartBloc();
                                                  }
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    cartScreenCubit
                                                        .updateCartButtonState(
                                                            index);
                                                    if (cartScreenCubit
                                                            .getMyCart
                                                            .data![index]
                                                            .quantity ==
                                                        1) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(const SnackBar(
                                                              content: Text(
                                                                  'Please wait, Item will remove from Cart !'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2)));
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(const SnackBar(
                                                              content: Text(
                                                                  'Please wait, Quantity will be decreased !'),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          2)));
                                                    }

                                                    await cartScreenCubit
                                                        .decreaseProductQuantityBloc(
                                                            cartItemId:
                                                                cartScreenCubit
                                                                    .getMyCart
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                    cartScreenCubit
                                                        .updateCartButtonDisableState(
                                                            index);

                                                    if (cartScreenCubit
                                                        .getMyCart
                                                        .data!
                                                        .isEmpty) {
                                                      await cartScreenCubit
                                                          .getMyCartBloc();
                                                    }
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
                                                    cartScreenCubit
                                                        .updateCartButtonState(
                                                            index);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            content: Text(
                                                                'Please wait, Quantity will be increased !'),
                                                            duration: Duration(
                                                                seconds: 2)));
                                                    await cartScreenCubit
                                                        .increaseProductQuantityBloc(
                                                            cartItemId:
                                                                cartScreenCubit
                                                                    .getMyCart
                                                                    .data![
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                    cartScreenCubit
                                                        .updateCartButtonDisableState(
                                                            index);
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
                ),
              );
            },
            itemCount: cartScreenCubit.getMyCart.data!.length);
      },
      listener: (context, state) {
        if (state is CartScreenErrorState) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/loginScreen', (route) => false);
        }
      },
    );
  }
}
