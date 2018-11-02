// import needed libraries
import 'package:flutter/material.dart';

// import other dart files
import '../widgets/input_field.dart';
import '../widgets/password_input_field.dart';
import '../widgets/round_button.dart';
import '../widgets/outline_button.dart';

// wedget class
class CustomerLogin extends StatelessWidget {
  // sign in user through Firebase Authentication
  void signIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/logo.png', scale: 3.0),
            InputField('enter email address', Icons.email, TextInputType.emailAddress),
            PasswordInputField('enter password', Icons.lock, TextInputType.text),
            RoundBtn('SIGN IN', signIn),
            RoundBtn('SIGN UP', () => Navigator.of(context).pushNamed('/customer_register')),
            OutlineBtn('FORGOT PASSWORD?', () => Navigator.of(context).pushNamed('/forget_password'))
          ],
        ),
      ),
    ));
  }
}
