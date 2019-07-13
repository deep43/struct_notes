import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:structured_notes/util/Theme.dart';
import 'package:structured_notes/util/WaveAnimationWidget.dart';

import 'Dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: accentColor, fontFamily: "WhitneyLightPro"),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/splash_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(child: WaveAnimationWidget()),
          /*Positioned.fill(
            child: Center(
              child: Text('CIBC \nStructured\nNotes',
                  style: TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold, color: white),
                  textAlign: TextAlign.center),
            ),
          ),*/
        ],
      ),
    );
  }

  void _initTimer() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => DashboardPage()));
    });
  }
}
