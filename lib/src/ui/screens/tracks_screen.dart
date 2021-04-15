import 'package:alarmfy/src/blocs/playlist_block.dart';
import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:alarmfy/src/models/tracks_playlist_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';
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

  play(String url) async {
    var result = await audioPlayer.play(url);
    if (result == 1) {
      sound = true;
    }
  }

  // ignore: always_declare_return_types
  _launchURL(urlParameter) async {
    var url = urlParameter.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo ir a $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      _playlist = arguments['playlist'] as Playlist;
      playlistBloc.fetchTracksList(_playlist.tracks.href.toString());
    }

    var sliverAppBar = SliverAppBar(
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: true,
        title: Text('${_playlist.name}'),
        background: Stack(
          alignment: Alignment.center,
          //fit: StackFit.expand, // Para expandir la imagen por
          children: [
            Image.network(
              "${_playlist.images.isNotEmpty
                  ? _playlist.images[0].url
                  : "https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png"}",
              height: 180,
              //fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.5),
                  end: Alignment(0.0, 0.0),
                  colors: <Color>[
                    Color(0x60000000),
                    Color(0x00000000),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    SliverList _sliverList(AsyncSnapshot<TracksPlaylistModel> snapshot) {
      var sliverList = SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Open Spotify',
                  color: Colors.black45,
                  icon: Icons.play_circle_outline,
                  onTap: () => _launchURL(
                      snapshot.data.items[index].track.externalUrls.spotify),
                ),
              ],
              child: Container(
                //color: Theme.of(context).primaryColor,
                color: Colors.black54,
                child: ListTile(
                  leading: Image.network(snapshot
                      .data.items[index].track.album.images.isNotEmpty
                      ? snapshot.data.items[index].track.album.images[0].url
                      : 'https://cdn.pixabay.com/photo/2012/04/23/15/46/question-38629_960_720.png'),
                  title: Text('${snapshot.data.items[index].track.name}'),
                  subtitle: Text(
                      '${snapshot.data.items[index].track.artists[0].name}'),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert), onPressed: () {  },
                  ),
                  onTap: () {
                    play(snapshot.data.items[index].track.previewUrl);
                  },
                ),
              ),
            );
          },
          childCount: snapshot.data.total,
        ),
      );
      return sliverList;
    }

    Scaffold _scaffold(AsyncSnapshot<TracksPlaylistModel> snapshot) {
      var scaffold = Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[sliverAppBar, _sliverList(snapshot)],
        ),
      );
      return scaffold;
    }

    return StreamBuilder(
      stream: playlistBloc.tracksList,
      builder: (context, AsyncSnapshot<TracksPlaylistModel> snapshot) {
        if (snapshot.hasData) {
          return _scaffold(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}