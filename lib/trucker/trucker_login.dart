// import needed libraries
// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import other dart libraries
import '../widgets/input_form_field.dart';
import '../widgets/password_form_field.dart';
import '../widgets/round_button.dart';
import '../widgets/outline_button.dart';

// wedget class
class TruckerLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TruckerLoginState();
}

class TruckerLoginState extends State<TruckerLogin> {

  // local variables
  String phone;
  String password;

  // text form controllers
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

   @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // clean up the controller when the Widget is disposed
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // sign in user through Firebase Authentication
  void signIn(BuildContext context) {

    // get all input
    this.phone = phoneController.text.trim();
    this.password = passwordController.text.trim();
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
                RoundBtn(context, 'SIGN UP', (context) => Navigator.of(context).pushNamed('/trucker_register')),
                OutlineBtn(context, 'FORGOT PASSWORD?', (context) => Navigator.of(context).pushNamed('/forget_password'))
              ],
            ),
          ),
        )
      )
    );
  }
}
