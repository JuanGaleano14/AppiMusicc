import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alarmfy/src/blocs/authorization_bloc.dart';
import 'package:alarmfy/src/models/authorization_model.dart';
import 'package:flutter/material.dart';

class WaitScreen extends StatefulWidget {
  @override
  _WaitScreenState createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  //AsyncSnapshot: Representación inmutable de la interacción más reciente con un cálculo asincrónico
  agregarTokenToPrefs(AsyncSnapshot<AuthorizationModel> snapshot) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', snapshot.data.accessToken);
    await prefs.setString('token_type', snapshot.data.tokenType);
    await prefs.setString('refresh_token', snapshot.data.refreshToken);
    await prefs.setBool('logged', true);
  }

  @override
  Widget build(BuildContext contextBuild) {
    //Consumir Api para autenticación
    authorizationBloc.fetchAuthorizationCode();

    Center _bienvenido() {
      //Se da cierre al stream, para no permitir más escuchas.
      authorizationBloc.disposeToken();

      Timer(
          Duration(microseconds: 0),
          () => Navigator.pushNamedAndRemoveUntil(
              context, '/home', (route) => false));
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: StreamBuilder(
        stream: authorizationBloc.authorizationCode,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'access_denied') {
              Navigator.pop(contextBuild);
            } else {
              authorizationBloc.fetchAuthorizationToken(snapshot.data);
              return StreamBuilder(
                stream: authorizationBloc.authorizationToken,
                builder: (context, AsyncSnapshot<AuthorizationModel> snapshot) {
                  if (snapshot.hasData) {
                    print('FINAL DATA, Petición: fetchAuthorizationToken');
                    print('access_token: ${snapshot.data.accessToken}');
                    print('token_type: ${snapshot.data.tokenType}');
                    print('expires_in: ${snapshot.data.expiresIn}');
                    print('refresh_token: ${snapshot.data.refreshToken}');
                    print('scope: ${snapshot.data.scope}');
                    //Se añade a las preferencias el fetchAuthorizationToken
                    agregarTokenToPrefs(snapshot);
                    return _bienvenido();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
