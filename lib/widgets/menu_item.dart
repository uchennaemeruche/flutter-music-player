import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItem({this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.cyan,
            size: 30.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 26.0),
          )
        ],
      ),
    );
  }
}
