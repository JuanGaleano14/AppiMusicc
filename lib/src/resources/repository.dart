import 'dart:async';

import 'package:alarmfy/src/models/authorization_model.dart';
import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:alarmfy/src/models/tracks_playlist_model.dart';
import 'package:alarmfy/src/resources/authorizationTokenApiService.dart';
import 'package:alarmfy/src/resources/authorizationApiService.dart';
import 'package:alarmfy/src/resources/playlistListApiService.dart';
import 'package:alarmfy/src/resources/tracks_playlistApiService.dart';

class RepositoryAuthorization {
  final authorizationCodeApiProvider = AuthorizationApiProvider();
  final authorizationTokenApiProvider = AuthorizationTokenApiProvider();
  Future<String> fetchAuthorizationCode() => authorizationCodeApiProvider.fetchCode();
  Future<AuthorizationModel> fetchAuthorizationToken(String code) => authorizationTokenApiProvider.fetchToken(code);
}

class RepositoryPlaylist {
  final playlistsListApiProvider = PlaylistListApiProvider();
  final tracksPlaylistApiProvider = TracksPlaylistApiProvider();
  Future<ListPlaylistModel> fetchPlaylistList() => playlistsListApiProvider.fetchPlaylistList();
  Future<TracksPlaylistModel> fetchTracksList(String url) => tracksPlaylistApiProvider.fetchTracks(url);
}
