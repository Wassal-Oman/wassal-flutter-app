// import needed libraries
import 'dart:io';
import 'package:flutter/material.dart';

// import other dart files
import '../widgets/round_button.dart';

// widget class
class CustomerReviewOrder extends StatefulWidget {

  // attributes
  final String pickupLocation;
  final String dropLocation;
  final int truckIndex;
  final String title;
  final String description;
  final File image;
  final String time;

  // constructor
  CustomerReviewOrder({
    @required this.pickupLocation,
    @required this.dropLocation,
    @required this.truckIndex,
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.time
  });

  @override
  State<StatefulWidget> createState() => CustomerReviewOrderState();
}

// state class
class CustomerReviewOrderState extends State<CustomerReviewOrder> {

  // attributes
  List<String> truckImages = [
    'assets/images/pickup.png',
    'assets/images/medium-truck.png',
    'assets/images/large-truck.png'
  ];

  @override
  void initState() {
    super.initState();
  }

  void send(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Order')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10.0),
              elevation: 2.0,
              child: Center(
                child: Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage(widget.image.path),
                      fit: BoxFit.contain
                    )
                  )
                )
              ),
            ),
            Card(
              elevation: 2.0,
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('From: ${widget.pickupLocation}', style: TextStyle(fontSize: 16.0)),
                  Text(' - ', style: TextStyle(fontSize: 16.0)),
                  Text('To: ${widget.dropLocation}', style: TextStyle(fontSize: 16.0))
                ],
              ),
            ),
            Card(
              elevation: 2.0,
              margin: EdgeInsets.all(10.0),
              child: Container(
                height: 100.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.amberAccent,
                        child: Image.asset(truckImages[widget.truckIndex]),
                      ),
                    ),
                    Container(
                      height: 100.0,
                      width: MediaQuery.of(context).size.width - 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.title, style: TextStyle(color: Color.fromARGB(255, 190, 24, 34))),
                              Text(widget.time, style: TextStyle(color: Color.fromARGB(255, 190, 24, 34))),
                            ],
                          ),
                          Text(widget.description)
                        ],
                      )
                    ),
                  ],
                )
              ),
            ),
            RoundBtn(context, 'CONFIRM', send)
          ],
        ),
      )
    );
  }
}