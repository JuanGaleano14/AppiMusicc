import 'dart:async';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' show Client;

class AuthorizationApiProvider {
  Client client = Client();

  static String url = 'https://accounts.spotify.com/authorize';
  static String client_id = '975ea9563fb4472399c103282660fe11';
  static String response_type = 'code';
  static String redirect_uri = 'alarmfy:/';
  static String scope = 'playlist-read-private playlist-read-collaborative';
  static String state = '34fFs29kd09';

  String urlDireccion = '$url'
      '?client_id=$client_id'
      '&response_type=$response_type'
      '&redirect_uri=$redirect_uri'
      '&scope=$scope'
      '&state=$state';

  Future<String> fetchCode() async {
    //Envío del consumo al api con la URL y el esquema esperado
    final ApiResponse = await FlutterWebAuth.authenticate(
        url: urlDireccion, callbackUrlScheme: 'alarmfy');

    final ApiError = Uri.parse(ApiResponse).queryParameters['error'];

    if (ApiError == null) {
      final code = Uri.parse(ApiResponse).queryParameters['code'];
      return code;
    } else {
      print('Error al autenticar');
      return ApiError;
    }
  }
}
