import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iftaryangon/screens/home.dart';

class ProfileScreen extends StatelessWidget {
  static String id = "profile_screen";
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Log Out'),
          onPressed: () async {
            await _auth.signOut();
            Navigator.pop(context, HomeScreen.id);
          },
        ),
      ),
    );
  }
}
