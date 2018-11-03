// import needed libraries
import 'package:flutter/material.dart';

// wedget class
class OutlineBtn extends StatelessWidget {
  // attributes
  final BuildContext context;
  final String buttonText;
  final Function onClick;

  // constructor
  OutlineBtn(this.context, this.buttonText, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.only(left: 20.0),
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: TextStyle(color: Color.fromARGB(255, 59, 61, 68)),
                ),
              ),
              onPressed: () => onClick(context),
            ),
          ),
        ],
      ),
    );
  }
}
