// import needed widget
import 'package:flutter/material.dart';

// import other dart files
import 'package:wassal/widgets/select_navigation.dart';

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

  // attributes
  int index = 0;
  String title = 'Select Your Truck';
  List<String> trucks = [
    'Pickup',
    'Medium Truck',
    '3.5 Tons Truck'
  ];

  // method to update selector index
  void updateSelectorIndex(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Truck'),
      ),
      body: Column(
        children: <Widget>[
          SelectNavigation(title: 'Select Your Truck', values: trucks, disabled: false, onChange: updateSelectorIndex)
        ],
      ),
    );
  }
}