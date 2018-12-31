// import needed libraries
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// import other dart files
import '../widgets/password_form_field.dart';
import '../widgets/round_button.dart';

// import settings file
import '../settings.dart' as settings;

class TruckerChangePassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TruckerChangePasswordState();
}

class TruckerChangePasswordState extends State<TruckerChangePassword> {
  // define attributes
  String oldPassword;
  String newPassword;
  String confirmPassword;

  // text form field controller
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // clean up the controller when the Widget is disposed
    oldPassController.dispose();
    newPassController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  // method to make http request
  Future<http.Response> changePasswordRequest(String oldPassword, String newPassword, String confirmPassword) async {
    return await http.post(settings.Routes.TRUCKER_CHANGE_PASSWORD, body: {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword
    });
  } 

  void changePassword(BuildContext context) {

    // get all input
    this.oldPassword = oldPassController.text.trim();
    this.newPassword = newPassController.text.trim();
    this.confirmPassword = confirmController.text.trim();

    // check if passwords match
    if (newPassword == confirmPassword) {

      // sign up user
      changePasswordRequest(this.oldPassword, this.newPassword, this.confirmPassword).then((response) {
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
                PasswordFormField('enter old password', Icons.lock, TextInputType.text, oldPassController),
                PasswordFormField('enter new password', Icons.lock, TextInputType.text, newPassController),
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
