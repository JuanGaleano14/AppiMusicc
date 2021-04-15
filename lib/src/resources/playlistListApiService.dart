import 'dart:async';
import 'package:alarmfy/src/models/authorization_model.dart';
import 'package:alarmfy/src/models/list_playlist_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PlaylistListApiProvider {
  Client client = Client();
  var urlToPlaylist = 'https://api.spotify.com/v1/me/playlists';

  Future<ListPlaylistModel> fetchPlaylistList() async {
    var prefs = await SharedPreferences.getInstance();
    var access_token = prefs.getString('access_token');
    var token_type = prefs.getString('token_type');

    var AuthorizationWithToken = '$token_type $access_token';

    var response = await client
        .get(urlToPlaylist, headers: {'Authorization': AuthorizationWithToken});

    //SI SE NECESITA NUEVO TOKEN
    if (response.statusCode == 401) {
      var refresh_token = prefs.getString('refresh_token');
      var client_id = '975ea9563fb4472399c103282660fe11';
      var client_secret ='109e3920fa9d4693a7160ed9c546faf0';
      var AuthorizationStr = '$client_id:$client_secret';
      var bytes = utf8.encode(AuthorizationStr);
      var base64Str = base64.encode(bytes);
      var Authorization= 'Basic ' + base64Str;
      var responseNewToken = await client.post('https://accounts.spotify.com/api/token', body: {
        'grant_type': 'refresh_token',
        'refresh_token': refresh_token,
        'redirect_uri': 'alarmfy:/'
      },headers: {'Authorization' : Authorization});

      if (responseNewToken.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        var aM =  AuthorizationModel.fromJson(json.decode(responseNewToken.body));
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', aM.accessToken);
        await prefs.setString('token_type', aM.tokenType);
        await prefs.setBool('logged', true);

        access_token = prefs.getString('access_token');
        token_type = prefs.getString('token_type');
        var AuthorizationWithToken = '$token_type $access_token';
        response = await client
            .get(urlToPlaylist, headers: {'Authorization': AuthorizationWithToken});
        print('Se dio un nuevo token!');
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to request a new token');
      }

    }

    if (response.statusCode == 200) {
      return ListPlaylistModel.fromJson(json.decode(response.body));
    } else {
      print('EstatusCode: ${response.statusCode}');
      print('BODY: ${response.body}');
      throw Exception('Error al obtener la PlayList');
    }
  }
}
