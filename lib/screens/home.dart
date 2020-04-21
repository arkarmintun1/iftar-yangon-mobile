import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iftaryangon/screens/profile.dart';
import 'package:iftaryangon/screens/register.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iftar Yangon'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () async {
              loggedInUser = await _auth.currentUser();
              if (loggedInUser != null) {
                Navigator.pushNamed(context, ProfileScreen.id);
              } else {
                Navigator.pushNamed(context, RegisterScreen.id);
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
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
      ),
    );
  }
}

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
