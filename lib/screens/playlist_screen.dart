import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_music_player/commons/colors.dart';
import 'package:flutter_music_player/commons/styles.dart';
import 'package:flutter_music_player/models/music_playlist_model.dart';
import 'package:flutter_music_player/screens/music_player.dart';
import 'package:flutter_music_player/widgets/custom_animated_bottom_bar.dart';

class PlayList extends StatefulWidget {
  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList>  with TickerProviderStateMixin{

  AnimationController _animationController;
  AnimationController _controller;
  Animation _slideAnimation;
  Animation<Offset> _fromRightSlideAnimation;
  ScrollController _scrollController;

  MusicPlaylist barItem;
  bool showBottomBar = false;
  bool collapseBottomBar = false;
  int selectedMusic = 10;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    _controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);

    _slideAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));

    _fromRightSlideAnimation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _scrollController = ScrollController();

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Widget _buildAppBarTitle(){
    return Container(
      padding: EdgeInsets.only(left:20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundColor: fadedBlueColor,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 12.0,),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(width: 60.0,),
          Flexible(
            child: Card(
              color: fadedBlueColor,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0))
              ),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.white,),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget widget){
        return Scaffold(
          backgroundColor: blueColor,
          body: Transform(
            transform: Matrix4.translationValues(0.0, _slideAnimation.value * screenWidth, 1.0),
            child: SafeArea(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      floating: true,
                      forceElevated: innerBoxIsScrolled,
                      expandedHeight:  150.0,
                      flexibleSpace: ListView(
                        children: <Widget>[
                          _buildAppBarTitle(),
                        ],

                      ),
//                      bottom: MusicTitle(),
                    )
                  ];
                },
                body:  Column(
                  children: <Widget>[
                    MusicTitle(),
                    Expanded(
                      child: Container(
                      padding: EdgeInsets.only(top: collapseBottomBar ? 0.0 : 30.0),
                        margin: EdgeInsets.only(top: 30.0),
                        decoration: BoxDecoration(
                          color: fadedBlueColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(80.0))
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, left: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(85.0))
                          ),
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification){
                              if(scrollNotification is ScrollUpdateNotification){
                                if(showBottomBar == true && _scrollController.offset >=  80.0 ){
                                 setState(() {
                                   collapseBottomBar = true;
                                 });
                                }else{
                                  setState(() {
                                    collapseBottomBar = false;
                                  });
                                }
                              }
                            },
                            child: ListView.builder(
                              itemCount: playlists.length,
                                itemBuilder: (BuildContext context, int index){
                                MusicPlaylist playlist = playlists[index];
                                return ListTile(
                                  onTap: (){
                                    setState(() {
                                      _controller.forward().then((n){
                                        print("New controller forwarded");
                                      });
                                      showBottomBar = true;
                                      barItem = playlist;
                                      selectedMusic = index;

                                    });
                                  },
                                  onLongPress: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MusicPlayer())),
                                  contentPadding: EdgeInsets.only(left:0.0, right:20.0, top:10.0, bottom: 2.0),
                                  title: Text(playlist.musicTitle, style:musicTitleStyle),
                                  subtitle: Text(playlist.artist, style: musicSubTitleStyle,),
                                  leading: Container(
                                    width: 120.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        selectedMusic == index ? CircleAvatar(
                                          child: Icon(Icons.equalizer, color: Colors.black,),
                                          backgroundColor: Colors.transparent,
                                        ) : Container(),
                                        CircleAvatar(
                                          backgroundColor: blueColor,
                                          radius: 30.0,
                                          child: Icon(playlist.musicIcon),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Text(playlist.duration,style: musicTitleStyle.copyWith(fontSize: 12.0),),
                                );
                                }
                            ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            color: Colors.white,
            child: FractionallySizedBox(
              alignment: Alignment.centerRight,
              widthFactor: collapseBottomBar ? 1.0 : 0.7,
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                color: Colors.white,
                child: showBottomBar ? SlideTransition(
                  position: _fromRightSlideAnimation,
                  child: CustomAnimatedBottomBar(
                      animation: _fromRightSlideAnimation,
                      barItem: barItem,
                      isCollapsed:collapseBottomBar,
                  ),
                ) : SizedBox.shrink(),
              ),
            ),
          )
        );

      },
    );

  }
}

class MusicTitle extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Transform.rotate(
            angle: 120.0,
            child: Icon(
              Icons.flash_on,
              color: Colors.grey[500],
              size: 30,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Ambient", style: titleNameStyle.copyWith(color:Colors.white, fontSize: 30.0),),
              SizedBox(height: 10.0,),
              Text("72 Listener . created by resens", style: subTitleStyle.copyWith(color: Colors.white, fontSize: 16.0),)
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(100.0);
}


