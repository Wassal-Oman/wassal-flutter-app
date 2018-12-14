// import needed libraries
// import 'dart:async';
import 'package:flutter/material.dart';

// import other dart files
import '../widgets/input_form_field.dart';
import '../widgets/round_button.dart';

class CustomerOTPVerify extends StatefulWidget {
  final String phone;

  // contructor
  CustomerOTPVerify({this.phone});

  @override
  State<StatefulWidget> createState() => _CustomerOTPVerifyState();
}

class _CustomerOTPVerifyState extends State<CustomerOTPVerify> {
  // attributes
  String phone;
  String smsCode;
  String verificationId;

  @override
  void initState() {
    super.initState();
  }

  // text form field controller
  final phoneController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // clean up the controller when the Widget is disposed
    phoneController.dispose();
    super.dispose();
  }

  // method to send verification code
  void sendVerficationCode() {

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
                Navigator.of(context).popAndPushNamed('/customer_login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Form(
      key: this.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InputFormField('enter verification code', 'please enter verification code', Icons.phone, TextInputType.phone, phoneController),
          RoundBtn(context, 'VERIFY', sendVerficationCode),
        ],
      ),
    )));
  }
}
