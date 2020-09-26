import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/commons/colors.dart';
import 'package:flutter_music_player/commons/custom_painter.dart';
import 'package:flutter_music_player/widgets/menu_item.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> _isSidebarOpenedStreamController;
  Stream<bool> _isSidebarOpenedStream;
  StreamSink<bool> _isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: _animationDuration, vsync: this);
    _isSidebarOpenedStreamController = PublishSubject<bool>();
    _isSidebarOpenedStream = _isSidebarOpenedStreamController.stream;
    _isSidebarOpenedSink = _isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _isSidebarOpenedStreamController.close();
    _isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    AnimationStatus animationStatus = _animationController.status;
    bool isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      _isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      _isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder(
      initialData: false,
      stream: _isSidebarOpenedStream,
      builder: (BuildContext context, AsyncSnapshot isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0.0,
          bottom: 0.0,
          left: isSideBarOpenedAsync.data ? 0 : 0 - screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  color: blueColor,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60.0,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(bottom: 0.0),
                        title: Text(
                          "Uchenna ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "uchennaemeruche@gmail.com",
                          style: TextStyle(color: cyanColor, fontSize: 20.0),
                        ),
                        leading: CircleAvatar(
                          radius: 40.0,
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Divider(
                        height: 64.0,
                        color: Colors.white.withOpacity(0.3),
                        thickness: 0.5,
                        indent: 32,
                        endIndent: 32.0,
                      ),
                      MenuItem(
                        icon: Icons.headset,
                        title: "Listen Now",
                      ),
                      MenuItem(
                        icon: Icons.history,
                        title: "Recents",
                      ),
                      MenuItem(
                        icon: Icons.library_music,
                        title: "Music Library",
                      ),
                      Divider(
                        height: 64.0,
                        color: Colors.white.withOpacity(0.3),
                        thickness: 0.5,
                        indent: 32,
                        endIndent: 32.0,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: "Settings",
                      ),
                      MenuItem(
                        icon: Icons.help,
                        title: "Help and Feedback",
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, -0.9),
                child: GestureDetector(
                  onTap: () => onIconPressed(),
                  child: ClipPath(
                    clipper: CustomCurvedMenuClipper(),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 35.0,
                      height: 90.0,
                      color: Color(0xFF262AAA),
                      child: AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          color: cyanColor,
                          size: 25.0,
                          progress: _animationController.view),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
