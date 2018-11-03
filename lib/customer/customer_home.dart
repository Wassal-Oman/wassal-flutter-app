// import needed libraries
import 'package:flutter/material.dart';

// class widget
class CustomerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Ghanim Al-Marzouqi', style: TextStyle(color: Colors.white),),
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
        child: Text('Customer Home Page'),
      ),
    );
  }
}