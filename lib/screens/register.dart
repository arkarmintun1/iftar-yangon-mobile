import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iftaryangon/screens/profile.dart';

class RegisterScreen extends StatelessWidget {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  static String id = 'register_screen';

  void loginWithGoogle(BuildContext context) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final firebaseUser = await _auth.signInWithCredential(credential);
      Navigator.popAndPushNamed(context, ProfileScreen.id);
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Error occurred! Please try again."),
      ));
      print(e);
    }
  }

  void loginWithFacebook(BuildContext context) async {
    try {
      final FacebookLoginResult result = await FacebookLogin().logIn(['email']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          {
            final accessToken = result.accessToken;
            final credential = FacebookAuthProvider.getCredential(
                accessToken: accessToken.token);
            final firebaseUser = await _auth.signInWithCredential(credential);
            Navigator.popAndPushNamed(context, ProfileScreen.id);
            break;
          }
        case FacebookLoginStatus.cancelledByUser:
          {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Login has been cancelled. Please try again."),
            ));
            break;
          }
        case FacebookLoginStatus.error:
          {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Error occurred! Please try again."),
            ));
            break;
          }
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Error occurred! Please try again."),
      ));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'images/applogo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 50),
              RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(20),
                child: Text(
                  'Login with Google',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  loginWithGoogle(context);
                },
              ),
              SizedBox(height: 15),
              RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(20),
                child: Text(
                  'Login with Facebook',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  loginWithFacebook(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
