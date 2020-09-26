import 'package:flutter/material.dart';
import 'package:flutter_music_player/commons/colors.dart';
import 'package:flutter_music_player/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: HomeScreen(),
    );
  }
}
