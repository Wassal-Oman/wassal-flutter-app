// import needed libraries
import 'package:flutter/material.dart';

// import other dart files
import './splash.dart';
import './select_language.dart';
import './login.dart';
import './forget_password.dart';

// customer dart files (routes)
import './customer/customer_login.dart';
import './customer/customer_register.dart';
import './customer/customer_otp_verify.dart';
import './customer/customer_home.dart';
import './customer/customer_profile.dart';
import './customer/customer_change_password.dart';
import './customer/customer_view_order.dart';
import './customer/customer_settings.dart';
import './customer/customer_set_location.dart';

// truck driver dart files (routes)
import './trucker/trucker_login.dart';
import './trucker/trucker_register.dart';
import './trucker/trucker_otp_verify.dart';
import './trucker/trucker_home.dart';

// launch the app
void main() => runApp(MyApp());

// app widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wassal',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Color.fromARGB(255, 190, 24, 34),
        accentColor: Color.fromARGB(255, 253, 204, 103),
        brightness: Brightness.light
      ),
      home: new Splash(),
      routes: <String, WidgetBuilder>{
        '/select_lang': (BuildContext context) => SelectLanguage(),
        '/login': (BuildContext context) => Login(),
        '/customer_login': (BuildContext context) => CustomerLogin(),
        '/customer_register': (BuildContext context) => CustomerRegister(),
        '/customer_otp_verify': (BuildContext context) => CustomerOTPVerify(),
        '/customer_home': (BuildContext context) => CustomerHome(),
        '/customer_profile': (BuildContext context) => CustomerProfile(),
        '/customer_change_password': (BuildContext context) => CustomerChangePassword(),
        '/customer_view_orders': (BuildContext context) => CustomerViewOrders(),
        '/customer_settings': (BuildContext context) => CustomerSettings(),
        '/customer_set_location': (BuildContext context) => CustomerSetLocation(),
        '/trucker_login': (BuildContext context) => TruckerLogin(),
        '/trucker_register': (BuildContext context) => TruckerRegister(),
        '/trucker_otp_verify': (BuildContext context) => TruckerOTPVerify(),
        '/trucker_home': (BuildContext context) => TruckerHome(),
        '/forget_password': (BuildContext context) => ForgetPassword(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
