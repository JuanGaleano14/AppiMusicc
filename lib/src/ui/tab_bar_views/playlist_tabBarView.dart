import 'package:alarmfy/src/blocs/playlist_block.dart';
import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:flutter/material.dart';


class PlaylistTabBar extends StatefulWidget {
  @override
  PlaylistTabBarState createState() => PlaylistTabBarState();
}

class PlaylistTabBarState extends State<PlaylistTabBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistBloc.fetchPlaylistList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: playlistBloc.playlistList,
      builder: (context, AsyncSnapshot<ListPlaylistModel> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.total,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(snapshot
                    .data.items[index].images.isNotEmpty
                    ? snapshot.data.items[index].images[0].url
                    : 'assets/tempScreen/noImagePlaylist.png'),
                title: Text('${snapshot.data.items[index].name}'),
                subtitle: Text('de ${snapshot.data.items[index].owner.id}'),
                onTap: () {
                  Navigator.pushNamed(context, '/tracks',
                      arguments: <String, Playlist>{
                        'playlist': snapshot.data.items[index],
                      });
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
