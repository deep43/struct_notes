import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:structured_notes/data_providers/DataProvider.dart';
import 'package:structured_notes/data_providers/DataProviderInterface.dart';
import 'package:structured_notes/model/snContactUsData.dart';
import 'package:structured_notes/screens/ContactUs/widgets/SNContactList.dart';

final DataProviderInterface _dataProvider = DataProvider().getDataProvider();

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with SingleTickerProviderStateMixin {
  List<Contact> contactList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SNContactList(contacts: contactList,),
          ],
        ),
      ),
    );
  }

  void getContactList() async {
    try {
      await _dataProvider.getContactJson().then(processData);
    } catch (e) {
      print('debuggg111111333333 calling SNCompareItems() - error: ' +
          e.toString());
    }
  }

  Future processData(String value) {

    List<Contact> contacts= contactFromJson(value);

    setState(() {
      contactList.clear();
      contactList=contacts;
    });
  }

  List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

}
