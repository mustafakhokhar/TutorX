import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/screens/common/map_temp.dart';

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
                    child: ModeTeaching(_center),
                  ),
                ),
              ],
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          MapScreen(userCredential: userCredential),
                    ),
                  );
                },
                child: Text("MAPS PAGE")),
            SizedBox(height: 20.0),
            OutlinedButton(
                onPressed: () async {
                  await Authentication.signOut(context: context);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: Text("Sign Out")),
            // child: SignOutButton(),
          ],
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
