import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:oline_ordering_system/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import '../provider/ApiConnection/ApiConnection_Provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var size, height, width;
  Widget CustomText = Text("My Cart");
  bool ListEmptyBool = false;

  int watchListItemCount = 0;
  List<dynamic> cartData = [];
  void accessApi(BuildContext context) async {
    final apiConnectionProvider =
        Provider.of<ApiConnectionProvider>(context, listen: false);
    apiConnectionProvider.showItemBool = false;
    await apiConnectionProvider.getMyCart(context);

    cartData = apiConnectionProvider.productDataList.map((e) => e).toList();

    apiConnectionProvider.showItem();
    watchListItemCount = await apiConnectionProvider.watchList[0].data.length;
  }

  @override
  void initState() {
    super.initState();
    accessApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return Scaffold(
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
                  badgeContent: Text(
                    watchListItemCount.toString(),
                    // favoriteProvider.FavItems.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.favorite_outline),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/wishlist-screen');
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(child: AllProduct()),
        bottomNavigationBar: Consumer<ApiConnectionProvider>(
          builder: (context, getMyCartProvider, child) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Total Items: ${getMyCartProvider.cart.isEmpty ? 0 : getMyCartProvider.cart[0].data!.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Expanded(
                      child: Text(
                    'Total Price: \$${getMyCartProvider.cart.isEmpty ? 0 : getMyCartProvider.cart[0].cartTotal}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return getMyCartProvider.cart.isNotEmpty
                                  ? AlertDialog(
                                      title: const Text("Confirm to Place Order"),
                                      content: Text(
                                          "You added ${getMyCartProvider.cart.isEmpty ? 0 : getMyCartProvider.cart[0].data!.length} Product and Total Price \$${getMyCartProvider.cart.isEmpty ? 0 : getMyCartProvider.cart[0].cartTotal}"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Not Now'),
                                        ),
                                        TextButton(
                                            onPressed: () async {
                                              String cartId = getMyCartProvider
                                                  .cart[0].data![0].cartId
                                                  .toString();
                                              String cartTotal = getMyCartProvider
                                                  .cart[0].cartTotal
                                                  .toString();
                                              print('cartId= $cartId');
                                              print('cartTotal= $cartTotal');
                                              apiConnectionProvider.placeOrder(
                                                  cartId, cartTotal);
                                              Navigator.pop(context);
                                              await getMyCartProvider
                                                  .getMyCart(context);
                                              // });
                                            },
                                            child: const Text('Place Order'))
                                      ],
                                    )
                                  : AlertDialog(
                                      title: const Text("No Items Added in Cart"),
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
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                          "Place Order ",
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
        )
        // body: AllProduct(),
        );
  }

  Widget AllProduct() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    final cartProvider = Provider.of<CartProvider>(context);
    final favoriteProvider = Provider.of<FavouriteProvider>(context);
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return !apiConnectionProvider.showItemBool
        ? SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: const Center(child: CircularProgressIndicator()))
        : apiConnectionProvider.cart[0].data.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height / 7,
                  ),
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
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
                  bool isFavourite = favoriteProvider.FavItems.any((element) =>
                      element.productName
                          .contains(cartProvider.CartItems[index].productName));

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
                                          .cart[0]
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
                                        Consumer<FavouriteProvider>(
                                            builder: (context, value, child) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                        Icons.favorite_outline,
                                                        size: 20),
                                              ),
                                            ],
                                          );
                                        }),
                                      ],
                                    ),
                                    Text(
                                      apiConnectionProvider.cart[0].data![index]
                                          .productDetails.title,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      apiConnectionProvider.cart[0].data![index]
                                          .productDetails.description,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                    Text(
                                      '\$${apiConnectionProvider.cart[0].data![index].productDetails.price}',
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
                                            Consumer<ApiConnectionProvider>(
                                                builder: (context,
                                                    removeProductFromCartProvider,
                                                    child) {
                                              return InkWell(
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(3)),
                                                    color: Colors.grey,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 10.0),
                                                  child: Row(
                                                    children: const [
                                                      Icon(
                                                          Icons.delete_forever),
                                                      Text('Remove')
                                                    ],
                                                  ),
                                                ),
                                                onTap: () async {
                                                  if (cartData
                                                          ?.where(
                                                              (e) => e != null)
                                                          ?.toList()
                                                          ?.isEmpty ??
                                                      true) {
                                                    print(
                                                        'Your cart is empty!');
                                                  } else {
                                                    String cartItemId =
                                                        removeProductFromCartProvider
                                                            .cart[0]
                                                            .data![index]
                                                            .id;
                                                    await removeProductFromCartProvider
                                                        .removeProductFromCart(
                                                            cartItemId);
                                                  }
                                                  removeProductFromCartProvider
                                                      .getMyCart(context);
                                                },
                                              );
                                            }),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0, right: 20.0),
                                                child: Consumer<
                                                        ApiConnectionProvider>(
                                                    builder: (context,
                                                        quantityProvider,
                                                        child) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          await quantityProvider
                                                              .decreaseProductQuantity(
                                                                  quantityProvider
                                                                      .cart[0]
                                                                      .data![
                                                                          index]
                                                                      .id);

                                                          quantityProvider
                                                              .getMyCart(
                                                                  context);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey[200],
                                                          radius: 14,
                                                          child: const Center(
                                                            child: Icon(
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
                                                        quantityProvider
                                                            .cart[0]
                                                            .data![index]
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
                                                        onTap: () async {
                                                          await quantityProvider
                                                              .increaseProductQuantity(
                                                                  quantityProvider
                                                                      .cart[0]
                                                                      .data![
                                                                          index]
                                                                      .id);

                                                          quantityProvider
                                                              .getMyCart(
                                                                  context);
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey[200],
                                                          radius: 14,
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }))
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
                itemCount: apiConnectionProvider.cart[0].data?.length);
  }
}
