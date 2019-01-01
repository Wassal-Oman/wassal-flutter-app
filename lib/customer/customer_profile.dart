// import needed libraries
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// import other dart files
import '../widgets/input_form_field.dart';
import '../widgets/round_button.dart';

// import settings file
import '../settings.dart' as settings;

class CustomerProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerProfileState();
}

class CustomerProfileState extends State<CustomerProfile> {
  // define attributes
  static int id;
  static String name;
  static String phone;
  static String email;
  static String token;

  // text form field controller
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController;

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // get user data
    getUserData().then((data) {
      var json = jsonDecode(data);
      var userData = json['data'];
      String tokenData = json['token'];

      // get user name and email
      setState(() {
        id = userData['id'];
        name = userData['name'];
        email = userData['email'];
        phone = userData['phone'];
        token = tokenData;
      });

      // show retrieved data
      nameController = TextEditingController(text: name);
      phoneController = TextEditingController(text: phone);
      emailController = TextEditingController(text: email);

    }).catchError((err) {
      print('User data cannot be retrieved due to ${err.toString()}');
    });
    super.initState();
  }

  @override
  void dispose() {
    // clean up the controller when the Widget is disposed
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // method to get user data from local storage
  Future<String> getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('CUSTOMER');
  }

  // method to store user data
  Future<void> setUserData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('CUSTOMER', data);
  }

  // method to make http request
  Future<http.Response> updateRequest(String name, String email, String phone) async {

    // header
    Map<String, String> header = {
      'Authorization': 'Bearer $token'
    };

    return await http.post(settings.Routes.CUSTOMER_UPDATE_PROFILE, 
      body: {
        'id': id.toString(),
        'name': name,
        'email': email,
        'phone': phone
      },
      headers: header
    );
  }

  void updateProfile(BuildContext context) {

    // get all input
    name = nameController.text.trim();
    email = emailController.text.trim();
    phone = phoneController.text.trim();

    // check if passwords match
    updateRequest(name, email, phone).then((response) {
      if(response.statusCode != 200) {
        var json = jsonDecode(response.body);
        showToastMessage(json['message']);
      } else {
        var json = jsonDecode(response.body);
        showDailog(context, json['status'], json['message']);
      }
    }).catchError((err) {
      print(err);
      showToastMessage('Server Error');
    });
  }

  void showDailog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void checkValidation(BuildContext context) {
    if (formKey.currentState.validate()) {
      updateProfile(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                InputFormField('enter name', 'please enter name', Icons.person,TextInputType.text, nameController),
                InputFormField('enter mobile number', 'please enter a valid phone number', Icons.phone, TextInputType.phone, phoneController),
                InputFormField('enter email address', 'please enter email address', Icons.email, TextInputType.emailAddress, emailController),
                RoundBtn(context, 'UPDATE PROFILE', checkValidation),
              ],
            ),
          ),
        ),
      )
    );
  }
}