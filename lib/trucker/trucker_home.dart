// import needed libraries
// import 'dart:async';
import 'package:flutter/material.dart';

// class widget
class TruckerHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TruckerHomeState();
}

class TruckerHomeState extends State<TruckerHome> {

    // attributes
  String name = 'User Name';
  String email = 'User Email';

  @override
  void initState() {

    // get current user
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Truck Driver Home'),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Text(name, style: TextStyle(color: Colors.white),),
                  Text(email, style: TextStyle(color: Colors.white),),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 190, 24, 34),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome To Home Page'),
      ),
    );
  }
}