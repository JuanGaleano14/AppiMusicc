import 'package:alarmfy/src/ui/tab_bar_views/playlist_tabBarView.dart';
import 'package:flutter/material.dart';

class MyLibraryPage extends StatefulWidget {
  @override
  MyLibraryPageState createState() => MyLibraryPageState();
}

class MyLibraryPageState extends State<MyLibraryPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, initialIndex: 0, length: 3)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabBar = Container(
      decoration: BoxDecoration(color: Colors.black54,),
      child: TabBar(
        controller: tabController,
        tabs: [
           Tab(
            text: 'Playlists',
          )
        ],
      ),
    );

    var tabBarView = Container(
      height: 80.0,
      child: TabBarView(
        controller: tabController,
        children: <Widget>[
           PlaylistTabBar()
        ],
      ),
    );

    return Column(
      children: <Widget>[
        tabBar,
        Expanded(
          child: Container(
            decoration:  BoxDecoration(color: Colors.black54,),
            child: tabBarView,
          ),
        )
      ],
    );
  }
}
