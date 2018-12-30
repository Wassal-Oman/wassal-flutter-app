// import needed files
import 'dart:async';
import 'package:flutter/material.dart';

// import other dart files
import './image_picker_handler.dart';

// widget class
class ImagePickerDialog extends StatelessWidget {

  // attributes
  ImagePickerHandler listener;
  AnimationController controller;
  BuildContext context;

  // constructor
  ImagePickerDialog(this.listener, this.controller);

  // animation
  Animation<double> drawerContentsOpacity;
  Animation<Offset> drawerDetailsPosition;

  void initState() {
    drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(controller),
      curve: Curves.fastOutSlowIn,
    );
    drawerDetailsPosition = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  // method to get image file
  getImage(BuildContext context) {
    if (controller == null ||
        drawerDetailsPosition == null ||
        drawerContentsOpacity == null) {
      return;
    }
    controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => new SlideTransition(
        position: drawerDetailsPosition,
        child: new FadeTransition(
          opacity: new ReverseAnimation(drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    controller.dispose();
  }

  startTime() async {
    var duration = new Duration(milliseconds: 200);
    return new Timer(duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Material(
      type: MaterialType.transparency,
      child: Opacity(
        opacity: 1.0,
        child: Container(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () => listener.openCamera(),
                child: roundedButton(
                    "Camera",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    Color.fromARGB(255, 190, 24, 34),
                    const Color(0xFFFFFFFF)),
              ),
              GestureDetector(
                onTap: () => listener.openGallery(),
                child: roundedButton(
                    "Gallery",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    Color.fromARGB(255, 190, 24, 34),
                    const Color(0xFFFFFFFF)),
              ),
              const SizedBox(height: 15.0),
              GestureDetector(
                onTap: () => dismissDialog(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                  child: roundedButton(
                      "Cancel",
                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      Color.fromARGB(255, 190, 24, 34),
                      const Color(0xFFFFFFFF)),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget roundedButton(
    String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(const Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }
}