import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:structured_notes/model/snContactUsData.dart';
import 'package:structured_notes/util/Theme.dart';

class SNContactList extends StatelessWidget {
  List<Contact> contacts;

  SNContactList({this.contacts});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: contactLIst(contacts));
  }
}

Widget contactLIst(List<Contact> contacts) => ListView.builder(
    padding: const EdgeInsets.only(top: 10, bottom: 5, left: 40, right: 40),
    shrinkWrap: true,
    itemCount: contacts.length,
    itemBuilder: (BuildContext context, int index) {
      return new GestureDetector(
        child: contactCard(contacts, index),
        onTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            child: new CupertinoAlertDialog(
              title: new Column(
                children: <Widget>[
                  new Text("Contact Person"),
                  new Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ],
              ),
              content: new Text("Selected Item $index"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("OK"))
              ],
            ),
          );
        },
      );
    });

Widget contactCard(List<Contact> contacts, int index) {
  return Card(
      child: Column(
    children: <Widget>[Container(child: person_details(contacts, index))],
  ));
}

Widget person_details(List<Contact> contacts, int index) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
          child: Text(
            contacts[index].firstName + " " + contacts[index].lastName,
            style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'assets/fonts/Whitney-Medium-Pro.ttf'),
          ),
        ),
        Text(
          contacts[index].role,
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'assets/fonts/Whitney-Light-Pro.otf',
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Phone: " + contacts[index].phoneNumber,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontFamily: 'assets/fonts/Whitney-Light-Pro.otf'),
        ),
        RichText(
          text: new TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: new TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontFamily: 'assets/fonts/Whitney-Light-Pro.otf'),
            children: <TextSpan>[
              new TextSpan(
                text: 'email: ',
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'assets/fonts/Whitney-Light-Pro.otf'),
              ),
              new TextSpan(
                  text: contacts[index].email,
                  style: new TextStyle(
                      color: accentColor,
                      fontFamily: 'assets/fonts/Whitney-Light-Pro.otf')),

            ],
          ),
        ),
        new SizedBox(height: 5.0,),

      ]);
}
