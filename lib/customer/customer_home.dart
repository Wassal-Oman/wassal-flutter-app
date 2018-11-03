// import needed libraries
import 'package:flutter/material.dart';

// class widget
class CustomerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text('Customer Home Page'),
      ),
    );
  }
}