// import needed libraries
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import other dart files
import './widgets/input_form_field.dart';
import './widgets/round_button.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgetPasswordState();
}

class ForgetPasswordState extends State<ForgetPassword> {

  String email;

  // text form field controller
  final emailController = TextEditingController();

   // form key
  final formKey = GlobalKey<FormState>();

  // firebase
  FirebaseAuth auth;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
  }

  // reset user password through Firebase Authentication
  void resetPassword() {

    // get email address
    this.email = emailController.text.trim();

    if(this.email.isNotEmpty) {
      sendResetEmail(this.email).then((val) {
        showDailog(context, 'Sent', 'Password Reset Email has been sent!');
      }).catchError((AuthException e) {
        print(e.message);
      });
    } else {
      print('Email field is empty!');
    }
  }

  @override
  void dispose() {
    // clean up the controller when the Widget is disposed
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendResetEmail(String userEmail) async {
    return await auth.sendPasswordResetEmail(email: userEmail);
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
          InputFormField('enter email address', 'please enter enter email address', Icons.email, TextInputType.emailAddress, emailController),
          RoundBtn(context, 'SEND', resetPassword),
        ],
      ),
    )));
  }
}
