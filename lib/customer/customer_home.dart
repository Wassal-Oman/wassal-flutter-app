// import needed libraries
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import other dart files
import './customer_drawer.dart';
import './customer_set_location.dart';
import '../widgets/input_form_field.dart';
import '../widgets/round_button.dart';
import './customer_select_truck.dart';

// widget class
class CustomerHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomerHomeState();
}

// class widget
class _CustomerHomeState extends State<CustomerHome> {

  // attributes
  String name;
  String email;
  String pickLocation;
  String dropLocation;

  // text form controllers
  final pickLocationController = TextEditingController();
  final dropLocationController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // get user data
    getUserData().then((data) {
      var json = jsonDecode(data);
      var userData = json['data'];

      // get user name and email
      setState(() {
        this.name = userData['name'];
        this.email = userData['email'];
      });
    }).catchError((err) {
      print('User data cannot be retrieved due to ${err.toString()}');
    });
    super.initState();
  }

  @override
  void dispose() {
    // clean up the controller when the Widget is disposed
    pickLocationController.dispose();
    dropLocationController.dispose();
    super.dispose();
  }

  // method to get user data from local storage
  Future<String> getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('CUSTOMER');
  }

    // method to get user data from local storage
  Future<bool> setUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove('CUSTOMER');
  }

  // method to check user input
  void checkValidation(BuildContext context) {
    if (formKey.currentState.validate()) {
      setLocation(context);
    }
  }

  // method to send location
  void setLocation(BuildContext context) {

    // read inputs
    this.pickLocation = pickLocationController.text.trim();
    this.dropLocation = dropLocationController.text.trim();

    // go to next page with user input data
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CustomerSelectTruck(pickLocation: this.pickLocation, dropLocation: this.dropLocation)
    ));
  }

  // method to view profile
  void viewProfile() {
    showToastMessage('User Profile');
  }

  // method to view orders
  void viewOrders() {
    showToastMessage('User Orders');
  }

  // method to show a toast
  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  // method to sign out user
  void logout(BuildContext context) {
    // remove user data from local storage
    setUserData().then((val) {
      if(val) {
        print('User data has been removed from local storage!');
        // go to login page
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        print('No data to removed from local storage!');
      }
    }).catchError((err) {
      print('Cannot remove user data due to ${err.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Specify Location')),
      drawer: CustomerDrawer(name, email, viewProfile, viewOrders, logout, context),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomerSetLocation(),
              Container(
                padding: EdgeInsets.all(10.0),
                color: Color.fromARGB(255, 190, 24, 34),
                child: Text('Select Your Location', style: TextStyle(color: Colors.white)),
              ),
              InputFormField('From / Pick Location', 'please enter pickup location',Icons.pin_drop, TextInputType.text, pickLocationController),
              InputFormField('To / Drop Location', 'please enter destination',Icons.pin_drop, TextInputType.text, dropLocationController),
              RoundBtn(context, 'NEXT', checkValidation),
            ],
          ),
        ),
      )
    );
  }
}