// import needed libraries
import 'package:flutter/material.dart';

// wedget class
class InputFormField extends StatelessWidget {
  // attributes
  final String text;
  final String validationText;
  final IconData icon;
  final TextInputType inputType;
  final TextEditingController textController;

  // contsructor
  InputFormField(this.text, this.validationText, this.icon, this.inputType, this.textController);

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
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Icon(
              icon,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          Expanded(
              child: TextFormField(
            keyboardType: inputType,
            controller: textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            validator: (value) {
              if (value.trim().isEmpty) {
                return validationText;
              }
            },
          ))
        ],
      ),
    );
  }
}
