import 'package:flutter/material.dart';
import 'package:flutter_music_player/commons/colors.dart';
import 'package:flutter_music_player/commons/custom_painter.dart';

class MusicProgress extends StatefulWidget {
  final double durationPlayed = 0.7;
  @override
  _MusicProgressState createState() => _MusicProgressState();
}

class _MusicProgressState extends State<MusicProgress> with TickerProviderStateMixin{

  AnimationController _animationController;
  AnimationController _rotationAnimationController;
  Animation<double> _progressAnimation;
  final Duration fadeDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);
  double progressInDegrees = 0.0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: fillDuration);

    _rotationAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 15))..repeat();


    _progressAnimation = Tween(begin: 0.0, end: 80.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.decelerate))
      ..addListener((){
        setState(() {
          progressInDegrees = widget.durationPlayed * _progressAnimation.value;
        });
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomMusicProgressPainter(progressInDegrees),
      child: Container(
        height: 300.0,
        width: 300.0,
        padding: EdgeInsets.symmetric(vertical: 35.0),
        child: AnimatedOpacity(
            opacity: progressInDegrees > 20 ? 1.0 : 0.0,
            duration: fadeDuration,
          child: RotationTransition(
            alignment: Alignment.center,
            turns: _rotationAnimationController,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.0,
              child: Image.asset("assets/images/headset_2.jpg", fit: BoxFit.cover, width: 200, height: 200,),
            ),
          ),
        ),
      ),
    );
  }
}
