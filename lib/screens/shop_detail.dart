import 'package:flutter/material.dart';

class ShopDetailScreen extends StatelessWidget {
  static String id = 'shop_detail_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Detail'),
      ),
      body: Center(
        child: Text('Shop Detail'),
      ),
    );
  }
}
