import 'package:flutter/material.dart';
import 'package:iftaryangon/screens/shop_detail.dart';

class Shop extends StatelessWidget {
  final String name;
  final String address;
  final String phoneNumber;

  Shop({this.name, this.address, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Pyidaungsu',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      address,
                      style: TextStyle(
                        fontFamily: 'Pyidaungsu',
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
              VerticalDivider(
                width: 16,
                color: Colors.black54,
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.pushNamed(context, ShopDetailScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
