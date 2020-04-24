import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iftaryangon/screens/profile.dart';

class RegisterScreen extends StatelessWidget {
  static String id = 'register_screen';

  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  void registerWithGmailPassword(BuildContext context) async {
    print(
        '${_emailTextFieldController.text} ${_passwordTextFieldController.text}');
    try {
      final firebaseUser = await _auth.createUserWithEmailAndPassword(
        email: _emailTextFieldController.text,
        password: _passwordTextFieldController.text,
      );
      Navigator.popAndPushNamed(context, ProfileScreen.id);
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Error occurred! Please try again."),
      ));
      print(e);
    }
  }

  void loginWithGmailPassword(BuildContext context) async {
    print(
        '${_emailTextFieldController.text} ${_passwordTextFieldController.text}');
    try {
      final firebaseUser = await _auth.signInWithEmailAndPassword(
        email: _emailTextFieldController.text,
        password: _passwordTextFieldController.text,
      );
      Navigator.popAndPushNamed(context, ProfileScreen.id);
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Error occurred! Please try again."),
      ));
      print(e);
    }
  }

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
      _scaffoldKey.currentState.showSnackBar(SnackBar(
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
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Login has been cancelled. Please try again."),
            ));
            break;
          }
        case FacebookLoginStatus.error:
          {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Error occurred! Please try again."),
            ));
            break;
          }
      }
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Error occurred! Please try again."),
      ));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              Flexible(
                child: Image.asset(
                  'images/applogo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailTextFieldController,
                      validator: (value) {
                        return value.isEmpty ? 'Please enter email' : null;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        hoverColor: Colors.orangeAccent,
                        hintText: 'Enter your email',
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordTextFieldController,
                      obscureText: true,
                      validator: (value) {
                        return value.isEmpty ? 'Please enter password' : null;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(Icons.vpn_key),
                        border: OutlineInputBorder(),
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.orangeAccent,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              registerWithGmailPassword(context);
                            }
                          },
                        ),
                        RaisedButton(
                          color: Colors.orangeAccent,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              loginWithGmailPassword(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
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
              SizedBox(height: 5),
              RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
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
