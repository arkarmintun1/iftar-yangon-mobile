import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iftaryangon/components/menu.dart';

class Menus extends StatelessWidget {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('menus').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<DocumentSnapshot> menus = snapshot.data.documents;
//        List<Menu> menuList = [];
//        for (var menu in menus) {
//          final menuName = menu.data['name'];
//          final menuPrice = menu.data['price'];
//
//          final menuItem = Menu(
//            name: menuName,
//          );
//          menuList.add(menuItem);
//        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'MENUS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: menus.length,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.9),
                  itemBuilder: (BuildContext context, int index) {
                    return Menu(name: menus[index].data['name']);
                  }),
            ),
          ],
        );
      },
    );
  }
}
