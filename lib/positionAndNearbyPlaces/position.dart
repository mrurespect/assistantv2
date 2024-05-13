import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserLocation extends StatefulWidget {
  @override
  State<GetUserLocation> createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _initialPosition = CameraPosition(
      target: LatLng(31.621414629856552, -7.998401648158237),
      zoom: 14);

  final List<Marker> myMarker = [];

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    packData();
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission().then((value) {
      // Handle permission response if needed
    }).onError((error, stackTrace) {
      print("Error requesting permission: $error");
    });

    return Geolocator.getCurrentPosition();
  }

  Future<void> searchLocation(String address) async {
    try {
      List<Location> location = await locationFromAddress(address);
      final cameraPosition = CameraPosition(
        target: LatLng(location.last.latitude, location.last.longitude),
        zoom: 14, // Adjust zoom level as needed
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      // Add a marker for the searched location
      myMarker.add(Marker(
        markerId: MarkerId("Search"),
        position: LatLng(location.last.latitude, location.last.longitude),
        infoWindow: InfoWindow(title: address),
      ));
      setState(() {});
    } catch (e) {
      print("Error searching location: $e");
      // Handle errors during search (e.g., show a snackbar)
    }
  }

  void packData() async {
    final position = await getUserLocation();

    myMarker.add(Marker(
      markerId: MarkerId("My Location"),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: const InfoWindow(title: "My Location"),
    ));

    final cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14, // Adjust zoom level as needed
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _initialPosition,
                mapType: MapType.normal,
                markers: Set<Marker>.of(myMarker),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 50, // Adjust height as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Enter your search here",
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        controller: _textController,
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        final searchText = _textController.text.trim();
                        if (searchText.isNotEmpty) {
                          searchLocation(searchText);
                        }
                      },
                    ),
                  ],
                ),
              )
            ]
        ),
      ),

    );
  }
}
