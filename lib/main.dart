import 'package:flutter/material.dart';
import 'package:iftaryangon/screens/home.dart';
import 'package:iftaryangon/screens/profile.dart';
import 'package:iftaryangon/screens/register.dart';
import 'package:iftaryangon/screens/shop_add.dart';
import 'package:iftaryangon/screens/shop_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iftar Yangon',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        ShopDetailScreen.id: (context) => ShopDetailScreen(),
        ShopAddScreen.id: (context) => ShopAddScreen()
      },
    );
  }
}
