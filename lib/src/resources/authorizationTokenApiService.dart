import 'dart:async';
import 'package:alarmfy/src/models/authorization_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class AuthorizationTokenApiProvider {
  Client client = Client();
  static String client_id = '975ea9563fb4472399c103282660fe11';
  static String client_secret ='109e3920fa9d4693a7160ed9c546faf0';

  static String AuthorizationStr = '$client_id:$client_secret';
  static var bytes = utf8.encode(AuthorizationStr);
  static var base64Str = base64.encode(bytes);

  String Authorization= 'Basic ' + base64Str;

  var urlToToken = 'https://accounts.spotify.com/api/token';

  Future<AuthorizationModel> fetchToken(String code) async {
    var response = await client.post(urlToToken, body: {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': 'alarmfy:/'
    },headers: {'Authorization' : Authorization});

    if (response.statusCode == 200) {
      return AuthorizationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}