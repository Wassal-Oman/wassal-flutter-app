// import needed libraries
import 'package:flutter/material.dart';

// import other dart files
import './widgets/round_button.dart';

class Login extends StatelessWidget {
  // attributes
  final Color primaryColor;
  final Color backgroundColor;
  final AssetImage backgroundImage;

  // constructor
  Login({Key key, this.primaryColor, this.backgroundColor, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Image.asset('assets/images/logo.png', scale: 3.0,),
            ),
            RoundBtn(context, 'CUSTOMER', (context) => Navigator.of(context).pushNamed('/customer_login')),
            RoundBtn(context, 'TRUCK DRIVER', (context) => Navigator.of(context).pushNamed('/trucker_login'))
          ],
        ),
      )
    );
  }
}
