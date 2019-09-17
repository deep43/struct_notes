import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:structured_notes/screens/Dashboard.dart';
import 'package:structured_notes/util/Theme.dart';

import '../LoginScreen.dart';

abstract class LoginScreenWidgets extends State<LoginScreen> {
  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();

  bool _isChecked = true;

  Widget loginScreenAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
    );
  }

  Widget CardUi() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black87.withOpacity(0.7),
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.all(
              Radius.circular(12.0) //                 <--- border radius here
              ),
          color: Colors.white,
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 2.0,
          ),
        ),
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 14, right: 14),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Center(
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'assets/fonts/Whitney-Medium-Pro.ttf'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'assets/fonts/Whitney-Medium-Pro.ttf',
                  fontSize: 20.0,
                ),
                decoration: new InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      fontFamily: 'assets/fonts/Whitney-Medium-Pro.ttf',
                      fontSize: 20.0,
                    )),
                controller: myUsernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(
                  fontFamily: 'assets/fonts/Whitney-Medium-Pro.ttf',
                  fontSize: 20.0,
                ),
                decoration: new InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontFamily: 'assets/fonts/Whitney-Medium-Pro.ttf',
                      fontSize: 20.0,
                    )),
                controller: myPasswordController,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 4.0),
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (bool val) => setState(() => _isChecked = val),
                  ),
                ),
                SizedBox(width: 12.0),
                Text(
                  "Remember me",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
                child: Center(
                  child: Container(
                      color: accentColor,
                      height: 50.0,
                      width: 300.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          " Sign On ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: white,
                              backgroundColor: accentColor),
                        ),
                      )),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx) => DashboardPage()));
                }),

            /*Center(
              child: Container(
                  color: accentColor,
                  height: 50.0,
                  width: 300.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      " Sign On ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: white,
                          backgroundColor: accentColor),
                    ),
                  )),
            ),*/
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                " Did you forget your password? ",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                "Forgot your username? ",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 36,
            ),
            Image.asset(
              'assets/images/ic_launche.png',
              scale: 10.5,
            ),
//SizedBox(width: 300, height: 2.0, child: Colors.black,)
          ],
        ),
      ),
    );
  }

  Widget decoratedInputBox() {}
}
