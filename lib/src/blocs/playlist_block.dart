
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

  fetchPlaylistList() async {
     ListPlaylistModel code = await _repository.fetchPlaylistList();
    _playlistListFetcher.sink.add(code);
  }
  fetchTracksList(String url) async {
    TracksPlaylistModel tracks = await _repository.fetchTracksList(url);
    _tracksListFetcher.sink.add(tracks);
  }

  disposePlaylist() {
    _playlistListFetcher.close();
  }
  disposeTracks() {
    _tracksListFetcher.close();
  }
}

final PlaylistBloc playlistBloc = PlaylistBloc();