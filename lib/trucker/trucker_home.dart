// import needed libraries
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class widget
class TruckerHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TruckerHome();
}

class _TruckerHome extends State<TruckerHome> {

    // attributes
  String name = 'User Name';
  String email = 'User Email';

  // firebase
  FirebaseAuth auth;
  FirebaseUser user;
  Firestore database;

  @override
  void initState() {

    auth = FirebaseAuth.instance;
    database = Firestore.instance;

    // get current user
    getLoggedUser().then((FirebaseUser firebaseUser) {
      if(firebaseUser != null) {
        user = firebaseUser;

        // get user details
        getUserDetails(user.uid).then((DocumentSnapshot snapshot) {
          name = snapshot.data['trucker_name'];
          email = snapshot.data['trucker_email'];
        }).catchError((error) {
          print(error);
        });
      }
    }).catchError((AuthException e) {
      print(e.message);
    });
    super.initState();
  }

  Future<FirebaseUser> getLoggedUser() async {
    return await auth.currentUser();
  }

  Future<DocumentSnapshot> getUserDetails(String id) async {
    return await database.collection('truckers').document(id).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Truck Driver Home'),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Text(name, style: TextStyle(color: Colors.white),),
                  Text(email, style: TextStyle(color: Colors.white),),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 190, 24, 34),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome To Home Page'),
      ),
    );
  }
}