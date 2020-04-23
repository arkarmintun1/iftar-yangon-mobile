import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iftaryangon/components/shop.dart';

class Shops extends StatelessWidget {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('shops').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final shops = snapshot.data.documents;
        List<Shop> shopList = [];
        for (var shop in shops) {
          final shopName = shop.data['name'];
          final shopAddress = shop.data['address'];
          final shopPhoneNumber = shop.data['phone_number'];

          final shopItem = Shop(
            name: shopName,
            address: shopAddress,
            phoneNumber: shopPhoneNumber,
          );
          shopList.add(shopItem);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'SHOPS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: shopList,
              ),
            ),
          ],
        );
      },
    );
  }
}
