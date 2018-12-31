// import needed libraries
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

// widget class
class InputTimeField extends StatelessWidget {

  // attributes
  final String text;
  final IconData icon;
  final TextInputType inputType;
  final Function timeChange;
  final timeFormat = DateFormat("h:mm a");

  // constructor
  InputTimeField(this.text, this.icon, this.inputType, this.timeChange);

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
            child: TimePickerFormField(
              format: timeFormat,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: text,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (t) => timeChange,
            )
          )
        ],
      ),
    );
  }
}