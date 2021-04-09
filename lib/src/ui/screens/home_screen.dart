import 'package:alarmfy/src/ui/pages/my_library_page.dart';
import 'package:alarmfy/src/ui/pages/search_page.dart';
import 'package:alarmfy/src/ui/pages/start_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      title: Text(
        "AppiMusic",
        style: TextStyle(fontSize: 20),
      ),
      backgroundColor: Colors.black54,
      centerTitle: true,
      elevation: 0.0,
    );

    BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      selectedItemColor: Colors.white,
      //unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              Icons.home,
            )),
        BottomNavigationBarItem(
            label: "Buscar",
            icon: Icon(
              Icons.search,
            )),
        BottomNavigationBarItem(
            label: "Biblioteca",
            icon: Icon(
              Icons.library_music,
            )),
      ],
      //Por defecto se muestra el home, index = 0
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );

    List<Widget> listPages = [
      new StartPage(),
      new SearchPage(),
      new MyLibraryPage(),
    ];

    Scaffold scaffold = new Scaffold(
      appBar: appBar,
      body: listPages.elementAt(selectedIndex),
      bottomNavigationBar: bottomNavigationBar,
    );

    return scaffold;
  }
}
