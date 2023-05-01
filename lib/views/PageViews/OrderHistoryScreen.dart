import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:oline_ordering_system/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import '../../provider/ApiConnection/ApiConnection_Provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  var size, height, width;
  Widget CustomText = Text("My Orders");

  int cartItemCount = 0;
  List<dynamic> confirmOrderListData = [];
  void accessApi(BuildContext context) async {
    final apiConnectionProvider =
        Provider.of<ApiConnectionProvider>(context, listen: false);
    apiConnectionProvider.showItemBool = false;
    await apiConnectionProvider.getOrderHistory(context);

    confirmOrderListData =
        apiConnectionProvider.productDataList.map((e) => e).toList();

    apiConnectionProvider.showItem();
    cartItemCount = await apiConnectionProvider.cart[0].data!.length;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accessApi(context);
  }

  Widget AllProduct() {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return !apiConnectionProvider.showItemBool
        ? SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(child: CircularProgressIndicator()))
        : apiConnectionProvider.confirmOrderList[0].data.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height / 5,
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/OrderEmptyImage.png'),
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
                  const Text(
                    "You didn't place any Order till now !",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ))
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
/*              bool itemAddedToCart = cartProvider.CartItems.any((element) =>
                  element.productName.contains(
                      placeOrderProvider.PlaceOrderItmes[index].productName));*/
                  // bool itemAddedToCart = confirmOrderList[0].data![index].quantity != 0;
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
                                          .confirmOrderList[0]
                                          .data![index]
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: AutoSizeText(
                                              'Order Place Date:- ${apiConnectionProvider.confirmOrderList[0].data![index].updatedAt}',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                              maxLines: 1,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      apiConnectionProvider.confirmOrderList[0]
                                          .data![index].title,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      apiConnectionProvider.confirmOrderList[0]
                                          .data![index].description,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${apiConnectionProvider.confirmOrderList[0].data![index].productTotalAmount}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Total quantity: ${apiConnectionProvider.confirmOrderList[0].data![index].quantity}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    /* Consumer<CartProvider>(
                                        builder: (context, value, child) {
                                      return ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    '/home-screen');
                                            */ /*if (itemAddedToCart == true) {
                                          // value.removeItem(value.CartItems[index]);
                                        } else {
                                          value.addItem(MainData(
                                            productId:
                                            ProductData[index].productId,
                                            productName:
                                            ProductData[index].productName,
                                            shortDescription: ProductData[index]
                                                .shortDescription,
                                            price: ProductData[index].price,
                                            imgLink: ProductData[index].imgLink,
                                          quantity: 1
                                          ));
                                        }*/ /*
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: */ /*itemAddedToCart ? Colors.red[200]:*/ /*
                                                  Colors.blue),
                                          child: */ /*itemAddedToCart? Text('Item is already Added')
                                          :*/ /*
                                              const Text('Re Order'));
                                    })*/
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
                    apiConnectionProvider.confirmOrderList[0].data!.length);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home-screen', (route) => false);
        return false;
      },
      child: Scaffold(
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
                    cartItemCount.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/cart-screen');
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: SingleChildScrollView(child: AllProduct()),
      ),
    );
  }
}
