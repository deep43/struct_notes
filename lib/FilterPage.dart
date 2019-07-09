import 'package:flutter/material.dart';
import 'package:structured_notes/util/Theme.dart';

import 'model/FilterMenuData.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        iconTheme: IconThemeData(color: accentColor),
        actions: <Widget>[
          FlatButton(
              onPressed: () {},
              child: Text(
                'RESET',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          FilterMenu(),
          SizedBox(height: 10,),
          Container(
            constraints: BoxConstraints(minHeight: 50,maxHeight: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                style: TextStyle(fontFamily: 'WhitneyMediumItalic'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],

                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[50])),
                  focusColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[200]),
                  ),
                  hintText: 'Search by Note Name, FundSERV, CUSIP or ADP',
                  hintStyle: TextStyle(fontFamily: 'WhitneyMediumItalic')
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FilterMenu extends StatefulWidget {
  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  List<FilterMenuData> _menuList = List();

  @override
  void initState() {
    _menuList = getDummyMenuList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => ExpansionTile(
          title: Text(
            _menuList[index].menuName,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          children: _getSubMenu(_menuList[index].subMenuItems)),
      itemCount: _menuList.length,
    );
  }

  List<FilterMenuData> getDummyMenuList() {
    List<FilterMenuData> list = new List();
    list.add(
      FilterMenuData(
        'Class',
        List.of([
          MenuItem('Class Item1'),
          MenuItem('Class Item2'),
          MenuItem('Class Item3'),
          MenuItem('Class Item4'),
          MenuItem('Class Item5'),
        ]),
      ),
    );

    list.add(
      FilterMenuData(
        'Currency',
        List.of([
          MenuItem('Currency Item1'),
          MenuItem('Currency Item2'),
          MenuItem('Currency Item3'),
        ]),
      ),
    );

    list.add(
      FilterMenuData(
        'Product Type',
        List.of([
          MenuItem('Product Type Item1'),
          MenuItem('Product Type Item2'),
          MenuItem('Product Type Item3'),
          MenuItem('Product Type Item4'),
        ]),
      ),
    );

    list.add(
      FilterMenuData(
        'Assets Class',
        List.of([
          MenuItem('Assets Class Item1'),
          MenuItem('Assets Class Item2'),
          MenuItem('Assets Class Item3'),
          MenuItem('Assets Class Item4'),
          MenuItem('Assets Class Item5'),
        ]),
      ),
    );
    return list;
  }

  List<Widget> _getSubMenu(List<MenuItem> subMenuItems) {
    List<Widget> list = new List();
    subMenuItems.forEach((submenu) {
      list.add(
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
              child: Text(
                submenu.itemTitle,
                style: TextStyle(color: Colors.black),
              ),
            )),
      );
    });
    list.add(SizedBox(
      height: 15,
    ));
    return list;
  }
}
