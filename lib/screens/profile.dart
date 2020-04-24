import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:iftaryangon/screens/home.dart';

class ProfileScreen extends StatefulWidget {
  static String id = "profile_screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    loggedInUser = user;
    return user;
  }

  Widget buildBottomSheet() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.vpn_key),
                border: OutlineInputBorder(),
                hintText: 'Enter your password',
                labelText: 'Password',
              ),
            ),
            TextFormField(),
            TextFormField(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.orangeAccent,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                FutureBuilder(
                  future: getCurrentUser(),
                  builder: (context, user) {
                    if (user.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.data.email,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Pyidaungsu',
                            ),
                          ),
                          RaisedButton(
                            child: Text('Log Out'),
                            color: Colors.orangeAccent,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: () {
                              _auth.signOut().then((value) {
                                Navigator.pop(context, HomeScreen.id);
                              });
                            },
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
            Divider(
              thickness: 1,
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Your Shop'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  color: Colors.orangeAccent,
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        child: Center(
                          child: buildBottomSheet(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Text('Hello'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
