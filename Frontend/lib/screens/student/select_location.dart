import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' as gogplace;
import 'package:tutorx/utils/location_services.dart';
import 'package:tutorx/utils/navbar.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tutorx/screens/student/student_findingatutor_loading_screen.dart';

class MapScreen extends StatefulWidget {
  final String user_uid;
  const MapScreen({required this.user_uid}) : super();

  @override
  State<MapScreen> createState() => _MapScreenState(user_uid: user_uid);
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  TextEditingController _searchController = TextEditingController();
  gogplace.DetailsResult? startPosition;
  gogplace.DetailsResult? endPosition;
  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  Marker? _origin;
  Marker? _destination;
  Timer? _debounce;
  LatLng? _markercoord;

  String map_theme = '';
  LatLng? _center; // Make _center nullable
  final String user_uid;
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

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
        // Reset destination
        _destination = null;
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(_markercoord!, 16.0),
        );

        // Reset info
        // _info = null;
      });
    }
    // else {
    //   // Origin is already set
    //   // Set destination
    //   setState(() {
    //     _destination = Marker(
    //       markerId: const MarkerId('destination'),
    //       infoWindow: const InfoWindow(title: 'Destination'),
    //       icon:
    //           BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    //       position: pos,
    //     );
    //   });
    // }
  }

  _MapScreenState({required this.user_uid});
  Map<String, Marker> _markers = {};
  late gogplace.GooglePlace _googlePlace;
  List<gogplace.AutocompletePrediction> predictions = [];

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
    String apiKey = 'AIzaSyBC1gKXR25mpST0waFJM52jHwR4HFIrePs';
    _googlePlace = gogplace.GooglePlace(apiKey);
    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
    DefaultAssetBundle.of(context)
        .load('lib/assets/maptheme.json')
        .then((value) {
      map_theme = utf8.decode(value.buffer.asUint8List());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await _googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: _center == null
          ? const Placeholder()
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
                  markers: {
                    if (_origin != null) _origin!,
                    if (_destination != null) _destination!,
                  },
                  onLongPress: _addMarker,
                ),
                Positioned(
                  top: 150.0,
                  left: 16.0,
                  right: 16.0,
                  child: TextFormField(
                    focusNode: startFocusNode,
                    onChanged: (value) {
                      // print(value);
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(Duration(milliseconds: 1000), () {
                        if (value.isNotEmpty) {
                          autoCompleteSearch(value);
                        } else {}
                      });
                    },
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter location',
                      suffixIcon: InkWell(
                        onTap: () {
                          // print('buttonclicked');
                          LocationService().getPlaceId(_searchController.text);
                          // Handle search icon tap here
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(predictions[index].description.toString()),
                        onTap: () async {
                          var latitude;
                          var longitude;
                          final placeId = predictions[index].placeId!;
                          final details =
                              await _googlePlace.details.get(placeId);
                          if (details != null &&
                              details.result != null &&
                              mounted) {
                            if (startFocusNode.hasFocus) {
                              setState(() {
                                startPosition = details.result;
                                _searchController.text = details.result!.name!;
                                predictions = [];
                                latitude =
                                    details.result!.geometry!.location!.lat;
                                longitude =
                                    details.result!.geometry!.location!.lng;
                                print(latitude);
                                print(longitude);
                                _markercoord = LatLng(latitude, longitude);
                              });
                            }
                          }
                          // print(startPosition);
                          _addMarker(_markercoord!);
                        },
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                Positioned(
                  top: 800,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 52,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        // handle button press here
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentFindingTutorLoadingScreen(),
                               
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(150, 52),
                        primary: const Color(0xFF583BE8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
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
