import 'package:flutter/material.dart';
import 'package:flutter_music_player/commons/colors.dart';
import 'package:flutter_music_player/commons/styles.dart';
import 'package:flutter_music_player/widgets/music_progress.dart';

class MusicPlayer extends StatefulWidget {

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _slideAnimation;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _slideAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    _animationController.forward();
  }


  final List<BottomNavigationBarItem> barItems = [
    BottomNavigationBarItem(
    icon: Icon(Icons.turned_in),
    title: Text("")
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.shuffle),
    title: Text("")
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.repeat),
    title: Text("")
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.playlist_add),
    title: Text("")
    ),

  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Scaffold(
          backgroundColor: darkColor,
          body: Transform(
            transform: Matrix4.translationValues(
                0.0, _slideAnimation.value * screenWidth, 1.0),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: fadedDarkColor,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 12.0,
                            ),
                            color: Colors.white,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        SizedBox(
                          width: 120.0,
                        ),
                        Text(
                          "Ambient",
                          style: musicTitleStyle.copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: screenWidth,
                      padding: EdgeInsets.symmetric(vertical: 60.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          MusicProgress(),
                          SizedBox(
                            height: 40.0,
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Months",
                                  style: musicTitleStyle,
                                ),
                                Text("Calvin Harris"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70.0,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(

                                  icon: Icon(
                                    Icons.fast_rewind,
                                    color: Colors.black,
                                    size: 35.0,
                                  ),
                                  iconSize: 40.0,
                                  padding: EdgeInsets.all(20.0),
                                  onPressed: () {},
                                ),
                               CircleAvatar(
                                    backgroundColor: blueColor,
                                    radius: 30.0,
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),

                                IconButton(
                                  icon: Icon(
                                    Icons.fast_forward,
                                    color: Colors.black,
                                    size: 35.0,
                                  ),
                                  padding: EdgeInsets.all(20.0),
                                  iconSize: 40.0,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedTab,
            onTap: (index){
              setState(() {
                _selectedTab = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: barItems
          ),
        );
      },
    );
  }
}
