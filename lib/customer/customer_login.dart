// import needed libraries
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

// import other dart files
import '../widgets/input_form_field.dart';
import '../widgets/password_form_field.dart';
import '../widgets/round_button.dart';
import '../widgets/outline_button.dart';

// import settings file
import '../settings.dart' as settings;

// wedget class
class CustomerLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerLoginState();
}

class CustomerLoginState extends State<CustomerLogin> {

  // local variables
  String phone;
  String password;

  // text form controllers
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // clean up the controller when the Widget is disposed
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // method to check internet connectivity
  Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi);
  }

  // method to make http request
  Future<http.Response> loginRequest(String phone, String password) async {
    return await http.post(settings.Routes.CUSTOMER_LOGIN, body: {
      'phone': phone,
      'password': password
    });
  } 

  // method to store user data
  Future<void> storeLoginData(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('CUSTOMER', data);
  }

  // sign in user through Firebase Authentication
  void signIn(BuildContext context) {

    // get all input
    this.phone = phoneController.text.trim();
    this.password = passwordController.text.trim();

    // check internet connectivity
    isOnline().then((val) {
      if(val) {
        // send login request
        loginRequest(this.phone, this.password).then((response) {
          // check for reponse code
          if(response.statusCode != 200) {
            var json = jsonDecode(response.body);
            showToastMessage(json['message']);
          } else {
            // convert response string into json
            var json = jsonDecode(response.body);
            storeLoginData(response.body).then((val) {
              print(response.body);
              print('User data has been stored into local storage');
              // go to home page
              Navigator.of(context).pushReplacementNamed('/customer_home');
            }).catchError((err) {
              print('User data cannot be stored due to ${err.toString()}');
            });
            showToastMessage(json['message']);
          }
        }).catchError((err) {
          showToastMessage('Cannot connect to server!');
        });
      } else {
        showToastMessage('No Internet Connectivity');
      }
    }).catchError((err) {
      // error in connectivity plugin
      print(err);
    });
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void checkValidation(BuildContext context) {
    if (formKey.currentState.validate()) {
      signIn(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/logo.png', scale: 3.0),
                InputFormField('enter phone number', 'please enter phone number', Icons.phone, TextInputType.phone, phoneController),
                PasswordFormField('enter password', Icons.lock, TextInputType.text, passwordController),
                RoundBtn(context, 'SIGN IN', checkValidation),
                RoundBtn(context, 'SIGN UP', (context) => Navigator.of(context).pushNamed('/customer_register')),
                OutlineBtn(context, 'FORGOT PASSWORD?', (context) => Navigator.of(context).pushNamed('/forget_password'))
              ],
            ),
          ),
        )
      )
    );
  }
}
