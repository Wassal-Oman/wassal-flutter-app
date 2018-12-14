// import needed libraries
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import other dart files
import './widgets/outline_bordered_button.dart';

class SelectLanguage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {

  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineBorderedBtn(context, 'English', (context) => Navigator.of(context).pushNamed('/login')),
            OutlineBorderedBtn(context, 'العربية', (context) => showToastMessage('سيتم اضافة اللغة العربية قريبا'))
          ],
        ),
      )
    );
  }
}
