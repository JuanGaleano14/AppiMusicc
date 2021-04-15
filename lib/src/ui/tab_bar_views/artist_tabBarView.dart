import 'package:flutter/material.dart';

class ArtistTabBar extends StatefulWidget {
  @override
  ArtistTabBarState createState() => ArtistTabBarState();
}

class ArtistTabBarState extends State<ArtistTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Text('Artists'),
      ),
    );
  }
}