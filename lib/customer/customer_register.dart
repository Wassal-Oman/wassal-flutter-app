// import needed libraries
// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import other dart files
// import './customer_otp_verify.dart';
import '../widgets/input_form_field.dart';
import '../widgets/password_form_field.dart';
import '../widgets/round_button.dart';
import '../widgets/outline_button.dart';

class CustomerRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  // define attributes
  String name;
  String phone;
  String email;
  String password;
  String confirmPassword;

  // text form field controller
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void signUp(BuildContext context) {

    // get all input
    this.name = nameController.text.trim();
    this.email = emailController.text.trim();
    this.phone = phoneController.text.trim();
    this.password = passwordController.text;
    this.confirmPassword = confirmController.text;

    // check if passwords match
    if (password == confirmPassword) {

      // sign up user

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
      signUp(context);
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
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              InputFormField('enter name', 'please enter name', Icons.person,TextInputType.text, nameController),
              InputFormField('enter mobile number', 'please enter a valid phone number', Icons.phone, TextInputType.phone, phoneController),
              InputFormField('enter email address', 'please enter email address', Icons.email, TextInputType.emailAddress, emailController),
              PasswordFormField('enter password', Icons.lock, TextInputType.text, passwordController),
              PasswordFormField('confirm password', Icons.lock, TextInputType.text, confirmController),
              RoundBtn(context, 'SIGN UP', checkValidation),
              OutlineBtn(context, 'ALREADY HAVE AN ACCOUNT?', (context) => Navigator.of(context).pop()),
            ],
          ),
        ),
      ),
    ));
  }
}
