// import needed libraries
import 'package:flutter/material.dart';

// widget class
class CustomerDrawer extends StatelessWidget {

  // attributes
  final String name;
  final String email;
  final Function viewProfile;
  final Function changePassword;
  final Function viewOrders;
  final Function viewSettings;
  final Function logout;
  final BuildContext context;

  // constructor
  CustomerDrawer(this.name, this.email, this.viewProfile, this.changePassword, this.viewOrders, this.viewSettings, this.logout, this.context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.name, style: TextStyle(color: Colors.white),),
                Text(this.email, style: TextStyle(color: Colors.white),),
              ],
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 190, 24, 34),
            ),
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.account_box),
            onTap: () => viewProfile(context),
          ),
          ListTile(
            title: Text('Change Password'),
            leading: Icon(Icons.lock),
            onTap: () => changePassword(context),
          ),
          ListTile(
            title: Text('Orders'),
            leading: Icon(Icons.border_color),
            onTap: () => viewOrders(context),
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () => viewSettings(context),
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }
}