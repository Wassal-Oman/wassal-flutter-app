// import needed libraries
import 'package:flutter/material.dart';

// widget class
class DrawerWidget extends StatelessWidget {

  // attributes
  final String name;
  final String email;

  // constructor
  DrawerWidget(this.name, this.email);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(this.name, style: TextStyle(color: Colors.white),),
                  Text(this.email, style: TextStyle(color: Colors.white),),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 190, 24, 34),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Orders'),
              onTap: () {},
            ),
          ],
        ),
      );
  }
}