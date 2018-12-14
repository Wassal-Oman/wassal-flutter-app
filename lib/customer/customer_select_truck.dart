// import needed widget
import 'package:flutter/material.dart';

// widget class
class CustomerSelectTruck extends StatefulWidget {

  // attributes
  final String pickLocation = '';
  final String dropLocation = '';

  // constructor
  CustomerSelectTruck({@required pickLocation, @required dropLocation});

  @override
  State<StatefulWidget> createState() => _CustomerSelectTruckState();
}

class _CustomerSelectTruckState extends State<CustomerSelectTruck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Truck'),
      ),
      body: Center(
        child: Text('Select Truck Page'),
      ),
    );
  }
}