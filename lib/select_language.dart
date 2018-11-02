// import needed libraries
import 'package:flutter/material.dart';

// import other dart files
import './widgets/outline_bordered_button.dart';

class SelectLanguage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineBorderedBtn('English', () => Navigator.of(context).pushNamed('/login')),
            OutlineBorderedBtn('العربية', () => Navigator.of(context).pushNamed('/login'))
          ],
        ),
      )
    );
  }
}
