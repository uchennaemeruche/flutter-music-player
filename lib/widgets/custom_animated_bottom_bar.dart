import 'package:flutter/material.dart';
import 'package:flutter_music_player/commons/colors.dart';
import 'package:flutter_music_player/commons/styles.dart';
import 'package:flutter_music_player/models/music_playlist_model.dart';

class CustomAnimatedBottomBar extends StatefulWidget {
  final MusicPlaylist barItem;
  final bool isCollapsed;
  Animation animation;

  CustomAnimatedBottomBar({this.barItem, this.isCollapsed, this.animation});

  @override
  _CustomAnimatedBottomBarState createState() =>
      _CustomAnimatedBottomBarState();
}

class _CustomAnimatedBottomBarState extends State<CustomAnimatedBottomBar> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SlideTransition(
      position: widget.animation,
      child: Container(
          height: 90.0,
          padding: EdgeInsets.only(left: 30.0, bottom: 20.0, top: 20.0),
          decoration: BoxDecoration(
              color: darkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60.0),
                  bottomRight: Radius.circular(30.0))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                child: Icon(
                  widget.barItem.musicIcon,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 100.0,
                      child: Text(
                    widget.barItem.musicTitle,
                    overflow: TextOverflow.ellipsis,
                    style: musicTitleStyle.copyWith(color: Colors.white),
                  ),),
                  SizedBox(
                    width: 100.0,
                    child: Text(
                      widget.barItem.artist,
                      overflow: TextOverflow.ellipsis,
                      style: musicSubTitleStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 30.0,
              ),
              widget.isCollapsed
                  ? RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: widget.barItem.duration,
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                            text: "  03:13",
                            style: TextStyle(color: Colors.grey, fontSize: 13.0))
                      ]),
                    )
                  : SizedBox.shrink(),
//          Text("${widget.barItem.duration} 03:13", style: TextStyle(color: Colors.grey),),
              SizedBox(
                width: 20.0,
              ),
              Container(
                width: 40,
                height: 40.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2.0, color: Colors.grey[900])),
                child: Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
