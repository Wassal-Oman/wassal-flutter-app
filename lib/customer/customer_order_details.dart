// import needed libraries
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import other dart files
import '../widgets/image_picker_handler.dart';
import '../widgets/round_button.dart';
import '../widgets/input_form_field.dart';
import '../widgets/input_multiple_form_field.dart';
import '../widgets/input_time_form_field.dart';
import './customer_review_order.dart';

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
  String title;
  String description;
  File image;
  AnimationController controller;
  ImagePickerHandler imagePicker;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final timeController = TextEditingController();
  String time;

  // form key
  final formKey = GlobalKey<FormState>();

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
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  userImage(File image) {
    setState(() {
      this.image = image;
    });
  }

    // method to check user input
  void checkValidation(BuildContext context) {
    if (formKey.currentState.validate()) {
      getAllDetails(context);
    }
  }

  // method to select tiem
  void timeChanged(TimeOfDay t) {
    setState(() {
      this.time = t.toString();
    });
  }

  // method to get all details
  void getAllDetails(BuildContext context) {
    // get data from inputs
    this.title = titleController.text.trim();
    this.description = descController.text.trim();
    this.time = timeController.text.trim();
    print(time);

    if(title != '' && description != '' && time != '') {
      if(widget.pickLocation != '' && widget.dropLocation != '' && widget.truckIndex > -1) {
        if(image != null) {
          // go to review location
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CustomerReviewOrder(
              pickupLocation: widget.pickLocation,
              dropLocation: widget.dropLocation,
              truckIndex: widget.truckIndex,
              title: this.title,
              description: this.description,
              image: this.image,
              time: this.time,
            )
          ));
        } else {
          showToastMessage('Please select an image');
        }
      } else {
        // truck details not selected
      }
    } else {
      showToastMessage('Please fill all blanks');
    }
  }

  // method to show a toast message
  void showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Details')),
      body: Form(
        key: formKey,
          child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => imagePicker.showDialog(context),
                child: Center(
                  child: image == null ? 
                    Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width - 100.0,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFF),
                        image: DecorationImage(
                          image: AssetImage("assets/images/photo_camera.png"),
                          fit: BoxFit.scaleDown
                        ),
                        border: Border.all(color: Color.fromARGB(255, 190, 24, 34), width: 2.0),
                      ),
                    ) : 
                    Container(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width - 100.0,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image:  DecorationImage(
                          image:  ExactAssetImage(image.path),
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(color: Color.fromARGB(255, 190, 24, 34), width: 2.0),
                      ),
                    ),
                ),
              ),
              InputFormField('Title', 'Enter Title', Icons.title, TextInputType.text, titleController),
              InputTimeFormField('Time', 'Enter Time', Icons.timer, TextInputType.datetime, timeController),
              InputMultipleFormField('Description', 'Enter Description', Icons.text_fields, TextInputType.text, descController),
              RoundBtn(context, 'NEXT', checkValidation)
            ],
          ),
        ),
      )
    );
  }
}