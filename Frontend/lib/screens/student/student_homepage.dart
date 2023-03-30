import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tutorx/utils/navbar.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class StudentHompage extends StatefulWidget {
  final UserCredential userCredential;
  const StudentHompage({required this.userCredential}) : super();

  @override
  State<StudentHompage> createState() =>
      _StudentHompageState(userCredential: userCredential);
}

class _StudentHompageState extends State<StudentHompage> {
  late GoogleMapController mapController;

  String map_theme = '';
  LatLng? _center; // Make _center nullable
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

  _StudentHompageState({required this.userCredential});
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
      body: _center == null // Check if _center is null
          ? Placeholder() // Show a placeholder until _center is updated
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
                    child: ElevatedButton(
                      onPressed: () {
                        // handle button press here
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 10, 10, 10),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Mode of Teaching',
                                    style: TextStyle(
                                      fontFamily: 'JakartaSans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  SizedBox(
                                    height: 52,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        fixedSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(246, 59)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFFF2FF53)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Online',
                                        style: TextStyle(
                                          fontFamily: 'JakartaSans',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(255, 0, 0, 0)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    height: 52,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        fixedSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(246, 59)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFFF2FF53)),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'In-Person',
                                        style: TextStyle(
                                          fontFamily: 'JakartaSans',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(255, 0, 0, 0)

                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all<Size>(Size(247, 52)),
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
        ), // add the hamburger menu icon here
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: Colors.black,
    );
  }
}
