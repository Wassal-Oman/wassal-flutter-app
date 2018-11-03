// import needed libraries
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
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

  // firebase
  FirebaseAuth auth;
  FirebaseUser user;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    auth.setLanguageCode('ar');
    this.phone = widget.phone;
    verifyPhone(this.phone);
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

  Future<void> verifyPhone(String customerPhone) async {
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String id) {
      setState(() {
        this.verificationId = id;
      });
    };

    final PhoneCodeSent smsCodeSent = (String id, [int forceCodeResend]) {
      setState(() {
        this.verificationId = id;
      });
      print('SMS has been sent');
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print('User with ${user.phoneNumber} has been verified');
      showDailog(context, 'Verified', 'User has been verified successfully!');
    };

    final PhoneVerificationFailed verifiedFail = (AuthException e) {
      print('${e.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: customerPhone,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
      codeSent: smsCodeSent,
      timeout: Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFail
    );
  }

  Future<void> sendVerficationCode(BuildContext context) async{
    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String id) {
      setState(() {
        this.verificationId = id;
      });
    };

    final PhoneCodeSent smsCodeSent = (String id, [int forceCodeResend]) {
      setState(() {
        this.verificationId = id;
      });
      print('smsCodeSent: $id');
      print('SMS has been sent');
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print('User with ${user.phoneNumber} has been verified');
      showDailog(context, 'Verified', 'User has been verified successfully!');
    };

    final PhoneVerificationFailed verifiedFail = (AuthException e) {
      print('${e.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phone,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
      codeSent: smsCodeSent,
      timeout: Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFail
    );
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
