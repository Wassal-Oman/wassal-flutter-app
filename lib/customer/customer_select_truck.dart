// import needed widget
import 'package:flutter/material.dart';

// import other dart files
import './customer_order_details.dart';
import '../widgets/select_navigation.dart';
import '../widgets/round_button.dart';

// widget class
class CustomerSelectTruck extends StatefulWidget {

  // attributes
  final String pickLocation;
  final String dropLocation;

  // constructor
  CustomerSelectTruck({@required this.pickLocation, @required this.dropLocation});

  @override
  State<StatefulWidget> createState() => CustomerSelectTruckState();
}

class CustomerSelectTruckState extends State<CustomerSelectTruck> {

  // attributes
  int index = 0;
  List<String> trucks = ['Pickup', 'Medium Truck', '3.5 Tons'];
  List<String> truckImages = [
    'assets/images/pickup.png',
    'assets/images/medium-truck.png',
    'assets/images/large-truck.png'
  ];

  @override
  void initState() {
    super.initState();
  }

  // method to update selector index
  void updateSelection(int i) {
    setState(() {
      index = i;
    });
  }

  // method to register user selection
  void goToDetailsPage(BuildContext context) {

    // check if all required data are available
    if(widget.pickLocation != '' && widget.dropLocation != '' && index > -1) {
      // go to next page with user input data
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => CustomerOrderDetails(pickLocation: widget.pickLocation, dropLocation: widget.dropLocation, truckIndex: index)
      ));
    } else {
      // show an alert message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Truck'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SelectNavigation(values: trucks, onChange: updateSelection),
            Center(
              child: Card(
                margin: EdgeInsets.all(10.0),
                elevation: 2.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 300.0,
                      child: Image.asset(truckImages[index]),
                    )
                  ],
                ),
              ),
            ),
            RoundBtn(context, 'NEXT', goToDetailsPage)
          ],
        ),
      )
    );
  }
}