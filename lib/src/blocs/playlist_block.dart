
import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:alarmfy/src/models/tracks_playlist_model.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PlaylistBloc {
  final _repository = RepositoryPlaylist();

  final PublishSubject _playlistListFetcher = PublishSubject<ListPlaylistModel>();
  final PublishSubject _tracksListFetcher = PublishSubject<TracksPlaylistModel>();

  Observable<ListPlaylistModel> get playlistList => _playlistListFetcher.stream;
  Observable<TracksPlaylistModel> get tracksList => _tracksListFetcher.stream;

  // ignore: always_declare_return_types
  fetchPlaylistList() async {
     var code = await _repository.fetchPlaylistList();
    _playlistListFetcher.sink.add(code);
  }
  // ignore: always_declare_return_types
  fetchTracksList(String url) async {
    var tracks = await _repository.fetchTracksList(url);
    _tracksListFetcher.sink.add(tracks);
  }

  // ignore: always_declare_return_types
  disposePlaylist() {
    _playlistListFetcher.close();
  }
  // ignore: always_declare_return_types
  disposeTracks() {
    _tracksListFetcher.close();
  }
}

final PlaylistBloc playlistBloc = PlaylistBloc();