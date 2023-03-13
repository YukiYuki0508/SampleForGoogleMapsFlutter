import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  CameraPosition _initialCameraPosition({LatLng? cameraPosition}) {
    if (cameraPosition != null) {
      return CameraPosition(
        target: cameraPosition,
      );
    } else {
      return const CameraPosition(
        target: LatLng(35.6809591, 139.7673068),
      );
      ;
    }
  }

  void _onCameraMove(CameraPosition position) {
    print("==onCameraMove:${position.target}");
  }

  void _updateCameraPosition() {
    mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        _initialCameraPosition(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            onCameraMove: (position) {
              _onCameraMove(position);
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Positioned(
            right: 13.0,
            bottom: 161.0,
            width: 60.0,
            height: 60.0,
            child: ElevatedButton(
              onPressed: () {
                _updateCameraPosition();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white,
              ),
              child: Icon(
                Icons.near_me_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
