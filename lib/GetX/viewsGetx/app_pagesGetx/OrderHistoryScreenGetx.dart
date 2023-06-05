import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ControllersGetx/ApiConnection_Getx/CartScreenGetxController.dart';
import '../../ControllersGetx/ApiConnection_Getx/OrderScreenGetxController.dart';
import '../../ControllersGetx/SearchGetxController.dart';

class OrderHistoryScreenGetx extends StatefulWidget {
  const OrderHistoryScreenGetx({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreenGetx> createState() => _OrderHistoryScreenGetxState();
}

class _OrderHistoryScreenGetxState extends State<OrderHistoryScreenGetx> {
  var orderScreenGetxController = Get.put(OrderScreenGetxController());
  var cartScreenGetxController = Get.put(CartScreenGetxController());
  var searchGetxController = Get.put(SearchGetxController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var orderScreenGetxController = Get.put(OrderScreenGetxController());
    orderScreenGetxController.getOrderHistoryGetx();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderScreenGetxController>(
        builder: (orderScreenGetxController) {
      return WillPopScope(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
              title: Text('Orders'.tr),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                    onTap: () {
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
                badgeContent: Text(cartScreenGetxController.cartGetx.data!.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
            onTap: () {
              Get.toNamed('/cartScreenGetx');
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],*/
            ),
            body: SingleChildScrollView(child: AllProduct()),
          ),
          onWillPop: () async {
            if (searchGetxController.SearchButton == true) {
              searchGetxController.searchButtonUnPress();
              Get.offNamedUntil('/homeScreenGetx', (route) => false);
              orderScreenGetxController.getOrderHistoryGetx();
              return true;
            } else {
              Get.offNamedUntil('/homeScreenGetx', (route) => false);
              orderScreenGetxController.getOrderHistoryGetx();
              return false;
            }
          });
    });
  }

  Widget AllProduct() {
    // final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return orderScreenGetxController.confirmOrderListGetx.data!.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/OrderEmptyImage.png'),
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
              Text(
                "You didn't place any Order till now !".tr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ))
        : Obx(() => orderScreenGetxController.isLoading.value
            ? Container(
                height: Get.height / 1.3,
                child: Center(
                    child:AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: const Color.fromRGBO(86, 126, 239, 15),), SizedBox(width: 20,),Text('Loading...'.tr)],),),
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
                                      image: NetworkImage(
                                          orderScreenGetxController
                                              .confirmOrderListGetx
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
                                              'Order Place Date:-'.tr +
                                                  ' ${orderScreenGetxController.confirmOrderListGetx.data![index].updatedAt}',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                              maxLines: 1,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      /*'title'*/
                                      orderScreenGetxController
                                          .confirmOrderListGetx
                                          .data![index]
                                          .title,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      orderScreenGetxController
                                          .confirmOrderListGetx
                                          .data![index]
                                          .description,
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
                                            '\$${orderScreenGetxController.confirmOrderListGetx.data![index].productTotalAmount}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Total quantity:'.tr +
                                                ' ${orderScreenGetxController.confirmOrderListGetx.data![index].quantity}',
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
                itemCount: orderScreenGetxController
                    .confirmOrderListGetx.data.length));
  }
}
