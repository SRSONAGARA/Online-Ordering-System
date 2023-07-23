import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_cubit.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/product_screen_state.dart';

class ProductDetailScreenBloc extends StatefulWidget {
  const ProductDetailScreenBloc({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreenBloc> createState() =>
      _ProductDetailScreenBlocState();
}

class _ProductDetailScreenBlocState extends State<ProductDetailScreenBloc> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(86, 126, 239, 15),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
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
                    '0'
                    /*cartScreenGetxController.cartGetx.data!.length
                        .toString()*/
                    ,
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/cartScreen');
              }),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: /*isLoading
          ? const Center(child: CircularProgressIndicator())
          :*/
          SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: size.height / 2,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        image: NetworkImage(args!['ImageURL']),
                        width: size.width / 2,
                        height: size.height / 2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child:
                            BlocConsumer<ProductListCubit, ProductScreenState>(
                          builder: (context, state) {
                            ProductListCubit productListCubit =
                                BlocProvider.of<ProductListCubit>(context);
                            if (state is WatchListBtnLoadingState) {
                              if (productListCubit
                                  .isLoadingList[args!['Index']]) {
                                return const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Color.fromRGBO(86, 126, 239, 15),
                                  ),
                                );
                              }
                            }
                            return productListCubit.productDataListBloc
                                        .data[args!['Index']].watchListItemId !=
                                    ''
                                ? InkWell(
                                    onTap: () async {
                                      productListCubit
                                          .updateFavButtonState(args['Index']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please wait, Item will remove from WatchList !'),
                                              duration: Duration(seconds: 2)));

                                      await productListCubit
                                          .removeFromWatchListBloc(
                                              wathListItemId: productListCubit
                                                  .productDataListBloc
                                                  .data[args!['Index']]
                                                  .watchListItemId
                                                  .toString());
                                      productListCubit
                                          .updateFavButtonDisableState(
                                              args['Index']);
                                    },
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      productListCubit
                                          .updateFavButtonState(args['Index']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Please wait, Item will be Added to WatchList !'),
                                              duration: Duration(seconds: 2)));

                                      await productListCubit.addToWatchListBloc(
                                          productId: productListCubit
                                              .productDataListBloc
                                              .data[args['Index']]
                                              .id
                                              .toString());
                                      productListCubit
                                          .updateFavButtonDisableState(
                                              args['Index']);
                                    },
                                    child: const Icon(Icons.favorite_outline,
                                        size: 20),
                                  );
                          },
                          listener: (context, state) {},
                        )),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black12,
            ),
            Container(
              height: size.height / 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Flexible(
                        child: Text(
                          args!['Name'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: 0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.blue,
                          size: 5,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Text(
                          args!['ShortDescription'],
                          style: const TextStyle(fontSize: 15),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: /*isLoading
          ? const SizedBox()
          :*/
          SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
                child: Text('\$${args!['Price']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20))),
            Expanded(child: BlocBuilder<ProductListCubit, ProductScreenState>(
              builder: (context, state) {
                ProductListCubit productListCubit =
                    BlocProvider.of<ProductListCubit>(context);
                if (state is CartListBtnLoadingState) {
                  if (productListCubit.isLoadingList1[args['Index']]) {
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(86, 126, 239, 15),
                          ),
                        ),
                      ],
                    );
                  }
                }
                return productListCubit.productDataListBloc.data[args!['Index']]
                            .quantity !=
                        0
                    ? InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red[200],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                              child: Text(
                            "Added in Cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          productListCubit
                              .updateCartButtonState(
                              args['Index']);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please wait, Item will be Added to Cart !'),
                                  duration: Duration(seconds: 2)));
                          await productListCubit.addToCartBloc(
                              productId: productListCubit
                                  .productDataListBloc.data[args['Index']].id
                                  .toString(),
                              index: args['Index']);
                          productListCubit
                              .updateCartButtonDisableState(
                              args['Index']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(86, 126, 239, 15),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                              child: Text(
                            "Add To Cart",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      );
              },
            ))
          ],
        ),
      ),
    );
  }
}
