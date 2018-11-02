// import needed libraries
import 'package:flutter/material.dart';

// import other dart libraries
import '../widgets/input_field.dart';
import '../widgets/password_input_field.dart';
import '../widgets/round_button.dart';
import '../widgets/outline_button.dart';

// wedget class
class TruckerLogin extends StatelessWidget {
  // sign in user through Firebase Authentication
  void signIn() {}

  // go to forget password
  void goToForgetPasswordPage(BuildContext context) {
    Navigator.pushNamed(context, '/forget_password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 250.0,
              width: 250.0,
              child: Image.asset('assets/images/logo.png', scale: 3.0,),
            ),
            InputField('enter email address', Icons.email, TextInputType.emailAddress),
            PasswordInputField('enter password', Icons.lock, TextInputType.text),
            RoundBtn('SIGN IN', signIn),
            OutlineBtn('FORGOT PASSWORD?', () => Navigator.of(context).pushNamed('/forget_password')),
          ],
        ),
      ),
    );
  }
}
