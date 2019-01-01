// import needed libraries
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import other dart files
import '../widgets/password_form_field.dart';
import '../widgets/round_button.dart';

// import settings file
import '../settings.dart' as settings;

class CustomerChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerChangePasswordState();
}

class CustomerChangePasswordState extends State<CustomerChangePassword> {
  // define attributes
  String password;
  String confirmPassword;
  String token;
  int id;

  // text form field controller
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // get user data
    getUserData().then((data) {
      var json = jsonDecode(data);
      var userData = json['data'];
      String tokenData = json['token'];

      // get access token
      setState(() {
        id = userData['id'];
        token = tokenData;
      });

    }).catchError((err) {
      print('User data cannot be retrieved due to ${err.toString()}');
    });
    super.initState();
  }

  @override
  void dispose() {
    // clean up the controller when the Widget is disposed
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  // method to get user data from local storage
  Future<String> getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('CUSTOMER');
  }

  // method to make http request
  Future<http.Response> changePasswordRequest(int id, String password, String confirmPassword) async {
    // header
    Map<String, String> header = {
      'Authorization': 'Bearer $token'
    };

    return await http.post(settings.Routes.CUSTOMER_CHANGE_PASSWORD, 
      body: {
        'id': id.toString(),
        'password': password,
        'confirmPassword': confirmPassword
      },
      headers: header
    );
  } 

  void changePassword(BuildContext context) {

    // get all input
    this.password = passwordController.text.trim();
    this.confirmPassword = confirmController.text.trim();

    // check if passwords match
    if (password == confirmPassword) {

      // sign up user
      changePasswordRequest(this.id, this.password, this.confirmPassword).then((response) {
        if(response.statusCode != 200) {
          var json = jsonDecode(response.body);
          showToastMessage(json['message']);
        } else {
          var json = jsonDecode(response.body);
          showDailog(context, json['status'], json['message']);
        }
      }).catchError((err) {
        showToastMessage('Cannot connect to server!');
      });

    } else {
      print('Passwords do not match!');
      showToastMessage('Passwords do not match!');
    }
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
      changePassword(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                PasswordFormField('enter new password', Icons.lock, TextInputType.text, passwordController),
                PasswordFormField('confirm new password', Icons.lock, TextInputType.text, confirmController),
                RoundBtn(context, 'CHANGE PASSWORD', checkValidation)
              ],
            ),
          ),
        ),
      )
    );
  }
}
