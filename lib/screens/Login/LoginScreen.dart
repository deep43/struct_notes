import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:structured_notes/screens/Login/Widgets/LoginScreenWidgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends LoginScreenWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: loginScreenAppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.hardLight),

              image: AssetImage(
                "assets/images/pub_img.png",
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset("assets/images/pub_img.png", fit: BoxFit.fitHeight,),
              CardUi(),
            ],
          ),
        ),
      ),
    );
  }
}
