// import needed libraries
import 'package:flutter/material.dart';

// wedget class
class OutlineBorderedBtn extends StatelessWidget {
  // attributes
  final BuildContext context;
  final String buttonText;
  final Function onClick;

  // constructor
  OutlineBorderedBtn(this.context, this.buttonText, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
