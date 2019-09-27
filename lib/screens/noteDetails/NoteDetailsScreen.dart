import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:structured_notes/util/Theme.dart';
//import 'package:shifting_tabbar/shifting_tabbar.dart';

class NoteDetailsScreen extends StatefulWidget {
  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  TabBar getTabBar() {

    return TabBar(
      labelColor: accentColor,
      unselectedLabelColor:Colors.black87 ,
      isScrollable: true,
      tabs: <Tab>[
        Tab(
          // set icon to the tab
          icon: Icon(Icons.settings_overscan, color: accentColor),
          text: 'Overview',
         // child: Text("Historical Performance", style: TextStyle(color: Colors.black87),),
        ),
        Tab(
          icon: Icon(Icons.history, color: accentColor),
          text: 'Historical Performance',
        ),
        Tab(
          icon: Icon(Icons.flare, color: accentColor),
          text:'Current Performance' ,
        ),
        Tab(
          icon: Icon(Icons.note, color: accentColor,),
          text: 'Note Events',
        ),
        Tab(
          icon: Icon(Icons.dock, color: accentColor),
          text: 'Documents',
        ),
        Tab(
          icon: Icon(Icons.markunread_mailbox, color: accentColor),
          text: 'Disclaimers',
        ),
      ],
      // setup the controller
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      // Add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          // Title
            //title: Text("Using Tabs"),
            // Set the background color of the App Bar
            backgroundColor: Colors.white,
            // Set the bottom property of the Appbar to include a Tab Bar
            bottom: getTabBar()),
        // Set the TabBar view as the body of the Scaffold
        body: getTabBarView(<Widget>[Text("TAB 1",style: TextStyle(fontSize: 20.0, color: Colors.black), textAlign: TextAlign.center,), Text("TAB 2", ), Text("TAB 3"), Text("TAB 4"), Text("TAB 5"), Text("TAB 6")]));
  }
}
