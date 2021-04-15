import 'package:flutter/material.dart';

class AlbumTabBar extends StatefulWidget {
  @override
  AlbumTabBarState createState() => AlbumTabBarState();
}

class AlbumTabBarState extends State<AlbumTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Text('Albums'),
      ),
    );
  }
}