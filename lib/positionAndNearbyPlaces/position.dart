import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserLocation extends StatefulWidget {

  @override
  State<GetUserLocation> createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {

  final Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _initialPosition = CameraPosition(
      target: LatLng(31.621414629856552, -7.998401648158237), zoom: 14);

  final List<Marker> myMarker = [];
  final List<Marker> markerList = const [
    Marker(
        markerId: MarkerId("First"),
        position: LatLng(31.621414629856552, -7.998401648158237),
        infoWindow: InfoWindow(title: 'My position')),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMarker.addAll(markerList);
    packData();
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace) {
      print("error : $error");
    });

    return Geolocator.getCurrentPosition();
  }

  packData() {
    getUserLocation().then((value) async {
      print("My Location");
      print("${value.latitude} ${value.longitude}");

      myMarker.add(Marker(
          markerId: MarkerId("Second"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(
            title: "My location"
          )
      ));

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(myMarker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.radio_button_off),
      ),
    );
  }
}
