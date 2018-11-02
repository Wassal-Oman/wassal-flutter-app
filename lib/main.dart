// import needed libraries
import 'package:flutter/material.dart';

// ***** import other dart files *****
import './splash.dart';
import './select_language.dart';
import './login.dart';
import './forget_password.dart';

// customer dart files
import './customer/customer_login.dart';
import './customer/customer_register.dart';
import './customer/customer_otp_verify.dart';

// truck driver dart files
import './trucker/trucker_login.dart';
import './trucker/trucker_register.dart';
import './trucker/trucker_otp_verify.dart';

// launch the app
void main() => runApp(MyApp());

// app widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wassal',
      theme: ThemeData(fontFamily: 'Raleway'),
      home: new Splash(),
      routes: <String, WidgetBuilder>{
        '/select_lang': (BuildContext context) => SelectLanguage(),
        '/login': (BuildContext context) => Login(),
        '/customer_login': (BuildContext context) => CustomerLogin(),
        '/trucker_login': (BuildContext context) => TruckerLogin(),
        '/customer_register': (BuildContext context) => CustomerRegister(),
        '/trucker_register': (BuildContext context) => TruckerRegister(),
        '/customer_otp_verify': (BuildContext context) => CustomerOTPVerify(),
        '/trucker_otp_verify': (BuildContext context) => TruckerOTPVerify(),
        '/forget_password': (BuildContext context) => ForgetPassword(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
