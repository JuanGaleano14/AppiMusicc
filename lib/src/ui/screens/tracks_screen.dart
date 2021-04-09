import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class TracksScreen extends StatefulWidget {
  @override
  _TracksScreenState createState() => _TracksScreenState();
}
class _TracksScreenState extends State<TracksScreen> {
  Playlist _playlist;
  AudioPlayer audioPlayer = AudioPlayer();
  bool sound = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playlist = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Text('Canciones'),
      ),
    );
  }
}