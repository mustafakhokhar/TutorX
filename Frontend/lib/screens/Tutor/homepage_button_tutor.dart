import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:tutorx/screens/Tutor/offers_screen.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/widgets/inperson_mode.dart';
import 'dart:math' show pi;

import '../../models/active_tutors_model.dart';
import '../../models/user_model.dart';
import '../../utils/base_client.dart';
import '../../utils/shared_preferences_utils.dart';

var lat;
var lon;

class Button extends StatefulWidget {
  final teaching_mode;
  const Button({required this.teaching_mode});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isPlaying = false;
  LatLng? _center;
  // Current Tutor Location
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _center = LatLng(position.latitude, position.longitude);
      lat = _center?.latitude;
      lon = _center?.longitude;
      // print(_center);
    });
  }

  void _showOverlay(BuildContext context) {
    print("2: $teaching_mode");
    showDialog(
      context: context,
      builder: (_) => OffersScreen(
        teaching_mode: teaching_mode,
        tutor_lat: lat,
        tutor_lon: lon,
      ), //AlertDialog(
      //   title: Text('Overlayed Page'),
      //   content: Text('This is an overlayed page.'),
      //   actions: [
      //     ElevatedButton(
      //       onPressed: () {
      //         // Navigator.of(context).pop();
      //         setState(() {

      // isPlaying = false;
      // });
      //       },
      //       child: Text('Close'),
      //     ),
      //   ],
      // ),
    );
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: screenSize.width * 0.4,
            width: screenSize.width * 0.4,
            child: PlayButton(
              pauseIcon: Text(
                'Finding\nTuition',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JakartaSans',
                  fontWeight: FontWeight.w800,
                  fontSize: screenSize.width * 0.06,
                ),
                textAlign: TextAlign.center,
              ),
              playIcon: Text(
                'Find\nTuition',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'JakartaSans',
                  fontWeight: FontWeight.w800,
                  fontSize: screenSize.width * 0.06,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () async {
                if (isPlaying) {
                  print('Finding Tutor paused');
                  String uid = await SharedPreferencesUtils.getUID();
                  var user = ActiveTutors(
                      uid: uid,
                      longitude: _center!.longitude,
                      latitude: _center!.latitude);
                  var response = await BaseClient()
                      .delete("/activeTutors/${user.uid}")
                      .catchError((err) {
                    print(err);
                  });
                } else {
                  _showOverlay(context);
                  print('Finding Tutor');
                  if (teaching_mode == 0) {
                    print('It is in inperson_mode');
                  } else if (teaching_mode == 1) {
                    print('It is in Online mode');
                  }
                  String uid = await SharedPreferencesUtils.getUID();
                  print(uid);
                  print(_center);
                  var user = ActiveTutors(
                      uid: uid,
                      longitude: _center!.longitude,
                      latitude: _center!.latitude);
                  var response = await BaseClient()
                      .post("/activeTutors", user)
                      .catchError((err) {});
                }
                isPlaying = !isPlaying;
              },
            ),
          ),
        ),
      ),
    );
  }

}

// class Button extends StatelessWidget {
//   bool isPlaying = false;

//   Button(LatLng? center);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: SizedBox(
//               height: 150,
//               width: 150,
//               child: PlayButton(
//                 pauseIcon: Text(
//                   'Finding\nTuition',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'JakartaSans',
//                     fontWeight: FontWeight.w800,
//                     fontSize: 25,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 playIcon: Text(
//                   'Find\nTuition',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'JakartaSans',
//                     fontWeight: FontWeight.w800,
//                     fontSize: 25,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 onPressed: () async {
//                   if (isPlaying) {
//                     print('Finding Tutor paused');
//                   } else {
//                     print('Finding Tutor');
//                     String uid = await SharedPreferencesUtils.getUID();
//                     print(uid);
//                   }
//                   isPlaying = !isPlaying;
//                 },
//               )),
//         ),
//       ),
//     );
//   }
// }

class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final playIcon;
  final pauseIcon;
  final VoidCallback onPressed;

  PlayButton({
    required this.onPressed,
    this.initialIsPlaying = false,
    this.playIcon = const Text('Find Tuition'),
    this.pauseIcon = const Text('Finding Tuition'),
  }) : assert(onPressed != null);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  late bool isPlaying;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));

    super.initState();
  }

  void _onToggle() {
    setState(() => isPlaying = !isPlaying);

    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }

    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        icon: isPlaying ? widget.pauseIcon : widget.playIcon,
        onPressed: _onToggle,
      ),
    );
  }

@override
Widget build(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;
  final double minWidth = screenSize.width * 0.4;
  final double minHeight = screenSize.height * 0.4;
  final double borderWidth = screenSize.width * 0.01;
  final double iconSize = screenSize.width * 0.6;

  return ConstrainedBox(
    constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
    child: Stack(
      alignment: Alignment.center,
      children: [
        if (_showWaves) ...[
          Blob(
              color: Color(0xffa5b300),
              scale: _scale,
              rotation: _rotation),
          Blob(
              color: Color(0xffeeff1a),
              scale: _scale,
              rotation: _rotation * 2 - 30),
          Blob(
              color: Color(0xfff2ff4d),
              scale: _scale,
              rotation: _rotation * 3 - 45),
        ],
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff1a1a1a),
            border: Border.all(
              color: Color(0xFFF2FF53),
              width: borderWidth,
            ),
          ),
          child: AnimatedSwitcher(
            child: _buildIcon(isPlaying),
            duration: _kToggleDuration,
          ),
        )
      ],
    ),
  );
}


  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}
