import 'package:flutter/material.dart';

import 'models/MainData.dart';
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final List<dynamic> ProductData = [
    MainData(
      productId: '1001',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 11 pro max',
      shortDescription: 'Deep Purple',
      price: 110000,
    ),
    MainData(
      productId: '1002',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 12 pro max',
      shortDescription: 'Deep Purple',
      price:120000,
    ),
    MainData(
      productId: '1003',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 13 pro max',
      shortDescription: 'Deep Purple',
      price: 130000,
    ),
    MainData(
      productId: '1004',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 14 pro max',
      shortDescription: 'Deep Purple',
      price: 110000,
    ),
    MainData(
      productId: '1005',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 15 pro max',
      shortDescription: 'Deep Purple',
      price: 120000,
    ),
    MainData(
      productId: '1006',
      imgLink: 'assets/ProductImage.jpg',
      productName: 'Iphone 16 pro max',
      shortDescription: 'Deep Purple',
      price: 130000,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Container(

          )
        ],
      ),
      
    );
  }
}
