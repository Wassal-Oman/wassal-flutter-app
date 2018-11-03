// import needed libraries
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import other dart files
import './customer_otp_verify.dart';
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

  // firebase
  FirebaseAuth auth;
  Firestore database;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    database = Firestore.instance;
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
      signingUp().then((FirebaseUser user) {

        if(user != null) {

          // send a comfirmation email
          user.sendEmailVerification().then((val) {
            print('verifivation email has been sent');
            showToastMessage('verifivation email has been sent');
          }).catchError((AuthException e) {
            print(e.message);
            showToastMessage('Cannot send verification mail!');
          });

          // add user to database
          addUserToDatabase(user.uid, user.email, this.name, this.phone).then((val) {

            // first sign user out
            auth.signOut();

            // go to phone verification page
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return CustomerOTPVerify(phone: '+968' + this.phone);
            }));

          }).catchError((err) {
            print(err);
            showToastMessage('Cannot register user');
          });
        }
      }).catchError((AuthException e) {
        print(e.message);
        showToastMessage('Sign Up Error');
      });
    } else {
      print('Passwords do not match!');
      showToastMessage('Passwords do not match!');
    }

  }

  // handle creating user in Firebase Authentication System
  Future<FirebaseUser> signingUp() async {
    return await auth.createUserWithEmailAndPassword(email: this.email, password: this.password);
  }

  Future<void> addUserToDatabase(String id, String email, String name, String phone) async {
    return await database.collection('customers').document(id).setData({
      'customer_id': id,
      'customer_email': email,
      'customer_name': name,
      'customer_phone': '+968' + phone
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
