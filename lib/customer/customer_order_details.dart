// import needed libraries
import 'dart:io';
import 'package:flutter/material.dart';

// import other dart files
import '../widgets/image_picker_handler.dart';

// widget class
class CustomerOrderDetails extends StatefulWidget {

  // attributes
  final String pickLocation;
  final String dropLocation;
  final int truckIndex;

  // constructor
  CustomerOrderDetails({@required this.pickLocation, @required this.dropLocation, @required this.truckIndex});

  @override
  State<StatefulWidget> createState() => CustomerOrderDetailsState();
}

// state class
class CustomerOrderDetailsState extends State<CustomerOrderDetails> with TickerProviderStateMixin, ImagePickerListener {

  // attributes
  String title = '';
  String description = '';
  File image;
  AnimationController controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ImagePickerHandler(this, controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  userImage(File image) {
    setState(() {
      this.image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: Center(
          child: image == null ? 
            Stack(
              children: <Widget>[
                Center(
                  child: CircleAvatar(radius: 80.0,
                    backgroundColor: const Color(0xFF778899),
                  ),
                ),
                Center(
                  child: Image.asset("assets/images/photo_camera.png"),
                ),
              ],
            ) : 
            Container(
              height: 160.0,
              width: 160.0,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image:  DecorationImage(
                  image:  ExactAssetImage(image.path),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.red, width: 5.0),
                borderRadius: BorderRadius.all(const Radius.circular(80.0)),
              ),
            ),
        ),
      ),
    );
  }
}