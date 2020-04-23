import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  final String name;
  final String address;
  final String phoneNumber;

  Shop({this.name, this.address, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: <Widget>[
          Text(name),
          Text(address),
          Text(phoneNumber),
        ],
      ),
    );
  }
}
