import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tutorx/widgets/navbar.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tutorx/screens/student/find_tutor_in_person.dart';
import 'package:tutorx/screens/student/student_findingatutor_loading_screen.dart';
import 'package:tutorx/widgets/mode_teaching.dart';


class StudentHompage extends StatefulWidget {
  // const StudentHompage({required this.user_uid}) : super();
  const StudentHompage({super.key});

  @override
  State<StudentHompage> createState() =>
      _StudentHompageState();
}

class _StudentHompageState extends State<StudentHompage> {
  late GoogleMapController mapController;

  String map_theme = '';
  LatLng? _center; // Make _center nullable

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

  _StudentHompageState();
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
      drawer: NavBar(),
      body: _center == null // Check if _center is null
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black,
              ),
            ) // Show a placeholder until _center is updated
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center!, // Use _center with null safety operator
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
                    child: ModeTeaching(),
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
        ), // add the hamburger menu icon here
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: Colors.black,
    );
  }
}
