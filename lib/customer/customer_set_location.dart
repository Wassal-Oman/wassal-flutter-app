// import needed libraries
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

// class widget
class CustomerSetLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomerSetLocationState();
}

class _CustomerSetLocationState extends State<CustomerSetLocation> {

  // attributes
  bool mapLoaded = false;
  Position currentLocation;

  // google maps controller
  GoogleMapController mapController;

  @override
  void initState() {
    Geolocator().getCurrentPosition().then((location) {
      setState(() {
        currentLocation = location;
        mapLoaded = true;
      });
    }).catchError((err) {
      print('Cannot set current location due to ${err.toString()}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      child: mapLoaded ? GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
            mapController.addMarker(
              MarkerOptions(
                draggable: false,
                position: LatLng(this.currentLocation.latitude, this.currentLocation.longitude),
                infoWindowText: InfoWindowText('My Location', '')
              )
            );
          });
        },
        options: GoogleMapOptions(
          compassEnabled: true,
          cameraPosition: CameraPosition(
            target: LatLng(this.currentLocation.latitude, this.currentLocation.longitude),
            zoom: 15.0
          )
        ),
      ) : Center(
        child: Text('Please wait for map to load...', style: TextStyle(color: Colors.black, fontSize: 18.0))
      ),
    );
  }
}