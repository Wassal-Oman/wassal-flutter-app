// import needed libraries
import 'package:flutter/material.dart';

// class widget
class CustomerSetLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomerSetLocationState();

}

class _CustomerSetLocationState extends State<CustomerSetLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Location'),),
      body: Center(
        child: Text('Set Location Page'),
      ),
    );
  }
}