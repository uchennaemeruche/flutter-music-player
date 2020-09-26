import 'package:flutter/material.dart';
import 'package:flutter_music_player/commons/colors.dart';
import 'package:flutter_music_player/commons/styles.dart';
import 'package:flutter_music_player/models/music_category_model.dart';
import 'package:flutter_music_player/models/music_playlist_model.dart';
import 'package:flutter_music_player/screens/playlist_screen.dart';
import 'package:flutter_music_player/widgets/sidebar.dart';

class HomeScreen extends StatelessWidget {
  final double heightFactor = 0.3;

  Widget _buildCategoryWidget(MusicCategory category, ctx) {
    return GestureDetector(
      onTap: () => Navigator.of(ctx).push(
          MaterialPageRoute(builder: (BuildContext context) => PlayList())),
      child: Container(
        width: 200.0,
        height: category.isLandscape ? 210 : 270,
        margin: EdgeInsets.only(right: 15.0),
        child: Card(
          color: category.categoryColor,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Transform.rotate(
                          angle: 120.0,
                          child: Icon(
                            category.categoryIcon,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          category.categoryName,
                          style: subTitleStyle.copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavouritePlaylist(MusicPlaylist favourite) {
    return ListTile(
      contentPadding:
          EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0, bottom: 2.0),
      title: Text(favourite.musicTitle, style: musicTitleStyle),
      subtitle: Text(
        favourite.artist,
        style: musicSubTitleStyle,
      ),
      leading: CircleAvatar(
        backgroundColor: blueColor,
        radius: 30.0,
        child: Icon(favourite.musicIcon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: heightFactor * screenHeight,
                      width: screenWidth,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 50.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Emeruche",
                                  style: titleNameStyle.copyWith(
                                      letterSpacing: 0.1, fontSize: 30.0),
                                ),
                                Text(
                                  "Good Morning",
                                  style: subTitleStyle.copyWith(fontSize: 16.0),
                                )
                              ],
                            ),
                          ),
//                        Spacer(),
                          Positioned(
                            top: -3,
                            left: 200,
                            right: -60,
                            child: Container(
                              width: 300.0,
                              height: 300.0,
                              padding: EdgeInsets.only(bottom: 50.0),
                              child: Transform.rotate(
                                angle: 119.4,
                                child: Image.asset(
                                  "assets/images/headset5.jpg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xFFfbfbfb),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      height: heightFactor * screenHeight - 15,
                      width: screenWidth,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            for (final category in categories)
                              _buildCategoryWidget(category, context)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Favourite",
                      style: titleNameStyle,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          for (final favourite in playlists
                              .where((item) => item.isFavourite == true))
                            _buildFavouritePlaylist(favourite)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SideBar()
        ],
      ),
    );
  }
}
