// import needed libraries
import 'package:flutter/material.dart';

// widget class
class CustomerViewOrders extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerViewOrdersState();
}

// state widget class
class CustomerViewOrdersState extends State<CustomerViewOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer Orders')),
    );
  }
}