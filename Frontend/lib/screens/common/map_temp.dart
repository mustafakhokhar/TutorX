import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  String map_theme = '';
  final LatLng _center = const LatLng(31.4707, 74.4098);

  void initState(){
  super.initState();
  DefaultAssetBundle.of(context).load('lib/assets/maptheme.json').then((value) {
    map_theme = utf8.decode(value.buffer.asUint8List());
  });
}

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.setMapStyle(map_theme);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
        ),
      );

  }
}
