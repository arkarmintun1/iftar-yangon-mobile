import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iftaryangon/models/shop_model.dart';

class ShopAddScreen extends StatelessWidget {
  static String id = 'shop_add_screen';

  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _shopNameTextFieldController = TextEditingController();
  final _shopLocationTextFieldController = TextEditingController();
  final _shopPhoneTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Shop'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'New Shop',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _shopNameTextFieldController,
                validator: (value) {
                  return value.isEmpty ? 'Please enter shop name' : null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.local_pizza),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your shop name',
                  labelText: 'Shop Name',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _shopLocationTextFieldController,
                validator: (value) {
                  return value.isEmpty ? 'Please enter shop location' : null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your location',
                  labelText: 'Shop Location',
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: _shopPhoneTextFieldController,
                validator: (value) {
                  return value.isEmpty ? 'Please enter phone number' : null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  hintText: 'Enter your phone number',
                  labelText: 'Shop Phone Number',
                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.white,
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    FirebaseUser _user = await _auth.currentUser();
                    final data = ShopModel(
                      name: _shopNameTextFieldController.text,
                      address: _shopLocationTextFieldController.text,
                      phoneNumber: _shopPhoneTextFieldController.text,
                      userId: _user.uid,
                    );
                    _firestore.collection('shops').add(data.toMap());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
