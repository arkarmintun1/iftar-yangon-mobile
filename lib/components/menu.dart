import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final String name;
  final String image;
  final bool available;

  Menu({this.name, this.image, this.available});

  Future<Widget> _getImage(BuildContext context, String imagePath) async {
    Image image;
    String downloadUrl =
        await FirebaseStorage.instance.ref().child(imagePath).getDownloadURL();
    image = available
        ? Image.network(downloadUrl,
            width: double.infinity, height: double.infinity, fit: BoxFit.cover)
        : Image.network(downloadUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            color: Colors.grey,
            colorBlendMode: BlendMode.color);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FutureBuilder(
                  future: _getImage(context, image),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done)
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: snapshot.data,
                      );
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Text(
                      '၁၅၀၀ ကျပ်',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      color: Colors.orangeAccent,
                      onPressed: !available ? null : () {},
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'Pyidaungsu',
                    ),
                  ),
                ),
                SizedBox(width: 1),
                CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: IconButton(
                    icon: Icon(Icons.shopping_basket),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
