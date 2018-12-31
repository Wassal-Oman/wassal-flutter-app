// import needed libraries
import 'package:flutter/material.dart';

// widget class
class CustomerSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerSettingsState();
}

// state widget class
class CustomerSettingsState extends State<CustomerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
    );
  }
}