import 'package:alarmfy/src/ui/screens/home_screen.dart';
import 'package:alarmfy/src/ui/screens/login_screen.dart';
import 'package:alarmfy/src/ui/screens/temp_screen.dart';
import 'package:alarmfy/src/ui/screens/tracks_screen.dart';
import 'package:alarmfy/src/ui/screens/wait_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppiMusic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColorDark: Colors.black,
        accentColor: Colors.green,
      ),
      home: TempScreen(),
      //Definición de nombre de las rutas a utilizar
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginScreen(),
        '/home': (BuildContext context) => HomeScreen(),
        '/temp': (BuildContext context) => TempScreen(),
        '/tracks': (BuildContext context) => TracksScreen(),
        '/wait': (BuildContext context) => WaitScreen(),
      },
    );
  }
}