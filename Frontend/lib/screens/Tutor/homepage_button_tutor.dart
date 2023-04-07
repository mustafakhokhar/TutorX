import 'package:flutter/material.dart';
import 'dart:math' show pi;

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: PlayButton(
              // pauseIcon: Icon(Icons.pause, color: Colors.black, size: 90),
              pauseIcon: Text(
                'Finding\nTuition',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'JakartaSans',
                    fontWeight: FontWeight.w800,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
              // playIcon: Icon(Icons.play_arrow, color: Colors.black, size: 90),
              playIcon: Text(
                'Find\nTuition',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'JakartaSans',
                    fontWeight: FontWeight.w800,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                print('Finding Tutor');
              },
            ),
          ),
        ),
      ),
    );
  }
}

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
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(color: Color(0xffa5b300), scale: _scale, rotation: _rotation),
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
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff1a1a1a),
              border: Border.all(
                color: Color(0xFFF2FF53),
                width: 4.0,
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