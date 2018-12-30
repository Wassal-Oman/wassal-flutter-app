// import needed libraries
import 'package:flutter/material.dart';

// widget class
class SelectNavigation extends StatefulWidget {

  // attributes
  final List<String> values;
  final bool disabled;
  final ValueChanged<int> onChange;

  // constructor
  SelectNavigation({
    this.values,
    this.disabled = false,
    this.onChange,
  });

  @override
  State<StatefulWidget> createState() => SelectNavigationState();
}

// widget state
class SelectNavigationState extends State<SelectNavigation> {

  // index
  int valueIndex = 0;

  // method to select previous element
  void previous() {
    valueIndex = valueIndex > 0 ? valueIndex - 1 : widget.values.length - 1;
    update();
  }

  // method to select next element
  void next() {
    valueIndex = valueIndex + 1 < widget.values.length ? valueIndex + 1 : 0;
    update();
  }

  // method to update selection
  void update() {
    widget.onChange(valueIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 190, 24, 34),
      child: Column(
        children: <Widget>[
          Divider(color: Colors.black54),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.all(4.0),
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                iconSize: 40.0,
                onPressed: widget.disabled ? null : previous,
              ),
              Text(
                widget.values[valueIndex],
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(4.0),
                icon: Icon(Icons.keyboard_arrow_right),
                color: Colors.white,
                iconSize: 40.0,
                onPressed: widget.disabled ? null : next,
              ),
            ],
          ),
        ]
      ),
    );
  }
}