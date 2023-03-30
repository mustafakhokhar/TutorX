import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tutorx/utils/navbar.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tutorx/widgets/mode_of_teaching_dialog.dart';

class MapScreen extends StatefulWidget {
  final UserCredential userCredential;
  const MapScreen({required this.userCredential}) : super();

  @override
  State<MapScreen> createState() => _MapTempState(userCredential: userCredential);
}

class _MapTempState extends State<MapScreen> {
  late GoogleMapController mapController;

  String map_theme = '';
  LatLng? _center;
  final UserCredential userCredential;
  Location _location = Location();

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
      print(_center);
    });
  }

  void _onMapCreated(GoogleMapController cntlr) {
    mapController = cntlr;
    cntlr.setMapStyle(map_theme);
    _location.onLocationChanged.listen((l) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  _MapTempState({required this.userCredential});
  Map<String, Marker> _markers = {};

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
    DefaultAssetBundle.of(context)
        .load('lib/assets/maptheme.json')
        .then((value) {
      map_theme = utf8.decode(value.buffer.asUint8List());
    });
  }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: NavBar(userCredential: userCredential),
      body: _center == null
          ? Placeholder()
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center!,
                    zoom: 16.0,
                  ),
                  markers: _markers.values.toSet(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 74,
                  child: SizedBox(
                    height: 52,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ModeOfTeachingDialog();
                          },
                        );
                      },
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all<Size>(Size(150, 52)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF583BE8)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Find Tutor',
                        style: TextStyle(
                          fontFamily: 'JakartaSans',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          _scaffoldState.currentState?.openDrawer();
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          Icons.menu,
          size: 32,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: Colors.black,
    );
  }
}
