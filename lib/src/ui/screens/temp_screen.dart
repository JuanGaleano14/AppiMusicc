import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempScreen extends StatefulWidget {
  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preferenciasCompartidas();
  }

  //Validar el estado de la sesión
  void preferenciasCompartidas() async {
    //SharedPreferences proporciona un almacenamiento persistente para datos simples.
    var prefs = await SharedPreferences.getInstance();
    var logged = prefs.getBool('logged');

    //Si el usuario se encuentra logueado
    if (logged == true) {
      Timer(Duration(seconds: 7),
          () => Navigator.pushReplacementNamed(context, '/home'));
    } else {
      Timer(Duration(seconds: 5),
          () => Navigator.pushReplacementNamed(context, '/login'));
    }
  }

  //Diseño de vista temp
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/tempScreen/fondoapp.jpg'),
                fit: BoxFit
                    .fitHeight, //Se ajusta la imagen al alto del contenedor
              ),
            ),
            child: BackdropFilter(
              //Se añade una capa de difuminación sobre la imagen
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'AppiMusic',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Divider(
                      color: Colors.black,
                      indent: 40,
                      endIndent: 40,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/tempScreen/iconmusic.png'),
                    backgroundColor: Colors.transparent,
                    maxRadius: 90,
                    minRadius: 80,
                  ),
                  Text(
                    'Una aplicación que te permite consultar tus Playlist y reproducir canciones',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
