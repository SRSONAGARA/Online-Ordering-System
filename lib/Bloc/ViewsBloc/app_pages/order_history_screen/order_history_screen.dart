import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/order_history_screen/order_history_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/order_history_screen/order_history_screen_state.dart';

class OrderHistoryScreenBloc extends StatefulWidget {
  const OrderHistoryScreenBloc({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreenBloc> createState() => _OrderHistoryScreenBlocState();
}

class _OrderHistoryScreenBlocState extends State<OrderHistoryScreenBloc> {
  OrderHistoryScreenCubit? orderHistoryScreenCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderHistoryData();
  }

  orderHistoryData() async {
    BlocProvider.of<OrderHistoryScreenCubit>(context).getOrderHistoryBloc();
    orderHistoryScreenCubit = OrderHistoryScreenCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
        title: const Text('Orders'),
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
    );
  }

  Widget AllProduct() {
    // final apiConnectionProvider = Provider.of<ApiConnectionProvider>(context);

    return /*orderScreenGetxController.confirmOrderListGetx.data!.isEmpty
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
            const Text(
              'Oops...!',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const Text(
              "You didn't place any Order till now !",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ))
        : Obx(() => orderScreenGetxController.isLoading.value
        ? Container(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Center(
          child:AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: const Color.fromRGBO(86, 126, 239, 15),), SizedBox(width: 20,),Text('Loading...'.tr)],),),
        ))
        : */
      BlocConsumer<OrderHistoryScreenCubit, OrderScreenState>(builder: (context, state) {
        OrderHistoryScreenCubit orderHistoryScreenCubit = BlocProvider.of<OrderHistoryScreenCubit>(context);
        if(state is OrderScreenLoadingState){
          return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child:AlertDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Color.fromRGBO(86, 126, 239, 15),), SizedBox(width: 20,),Text('Loading...')],),),
              ));
        }
        if(state is OrderScreenSuccessState){
          return ListView.builder(
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
                                        orderHistoryScreenCubit.getOrderHistory
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
                                            'Order Place Date:-' +
                                                ' ${orderHistoryScreenCubit.getOrderHistory.data![index].updatedAt}',
                                            style:
                                            const TextStyle(fontSize: 10),
                                            maxLines: 1,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    orderHistoryScreenCubit.getOrderHistory
                                        .data![index]
                                        .title,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    orderHistoryScreenCubit.getOrderHistory
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
                                          '\$${orderHistoryScreenCubit.getOrderHistory.data![index].productTotalAmount}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Total quantity:' +
                                              ' ${orderHistoryScreenCubit.getOrderHistory.data![index].quantity}',
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
              itemCount: orderHistoryScreenCubit.getOrderHistory.data.length);
        }
        return SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
              child:AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,content: Row(mainAxisAlignment: MainAxisAlignment.center, children: [CircularProgressIndicator(color: Color.fromRGBO(86, 126, 239, 15),), SizedBox(width: 20,),Text('Loading...')],),),
            ));
      }, listener: (context, state) {

      },);
  }
}
