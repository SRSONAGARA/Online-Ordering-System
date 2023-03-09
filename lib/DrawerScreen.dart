import 'dart:js_util';

import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 400,
      // height: 200,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/LoginImage.png'))),
          ),
          Text(
            'Sagar Sonagara',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            'sagar7777926900',
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
