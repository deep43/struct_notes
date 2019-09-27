import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:structured_notes/data_providers/DataProvider.dart';
import 'package:structured_notes/data_providers/DataProviderInterface.dart';
import 'package:structured_notes/model/SNFilterData.dart';
import 'package:structured_notes/providers/FilterDataProvider.dart';
import 'package:structured_notes/screens/CurrentOfferings/CurrentOfferings.dart';
import 'package:structured_notes/util/Theme.dart';
import 'HomePage.dart';
import '../model/FilterMenuData.dart';
import '../model/AppliedFilterData.dart';

final DataProviderInterface _dataProvider = DataProvider().getDataProvider();

class FilterPage extends StatefulWidget {
  final Function(AppliedFilterData appliedFilterData) onFilterApplied;

  const FilterPage({this.onFilterApplied});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentOfferingAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: filterAccentColor,
        fontFamily: "WhitneyLightPro",
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          iconTheme: IconThemeData(color: accentColor),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                HomePage.appliedFilterData = new AppliedFilterData();
                setState(() {
                  widget.onFilterApplied(new AppliedFilterData());
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'RESET',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  FilterMenu(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      style: TextStyle(fontFamily: 'WhitneyMediumItalic'),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[50])),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[50])),
                          //focusColor: Colors.grey[200],
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                          hintText:
                              'Search by Note Name, FundSERV, CUSIP or ADP',
                          hintStyle:
                              TextStyle(fontFamily: 'WhitneyMediumItalic')),
                    ),
                  ),
                  IssueDateWidget(),
                  MaturityWidget()
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RawMaterialButton(
                fillColor: accentTextColor,
                onPressed: () {
                  widget.onFilterApplied(HomePage.appliedFilterData);
                  /*FilterDataProvider(
                    child: CurrentOfferings(appliedFilterData: HomePage.appliedFilterData,),
                    appliedFilterData: HomePage.appliedFilterData,
                  );*/
                  // widget.onFilterApplied(CurrentOfferings.appliedFilterData);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'DONE',
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getCurrentOfferingAllData() async {
    try {
      await _dataProvider.getAllOffers().then(processData);
    } catch (e) {
      print('debuggg111111333333 calling getAllOffers() - error: ' +
          e.toString());
    }
  }

  Future processData(String value) {
    var snFilterJsonData = json.decode(value);
    SNFilterData snFilterData = SNFilterData.fromJson(snFilterJsonData);
    List<NoteColumn> mNotesColumn = snFilterData.mNotesColumn;
    mNotesColumn[0].fClass = "1";
    print(mNotesColumn);
  }
}

class FilterMenu extends StatefulWidget {
  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  List<FilterMenuData> _menuList = List();

  //List<MenuItem> _selectedMenuItems = List();

  @override
  void initState() {
    _menuList = getDummyMenuList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => ExpansionTile(
        title: Text(
          _menuList[index].menuName,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        children: _getSubMenu(_menuList[index].subMenuItems),
      ),
      itemCount: _menuList.length,
    );
  }

  List<FilterMenuData> getDummyMenuList() {
    List<FilterMenuData> list = new List();
    list.add(
      FilterMenuData(
        'Class',
        List.of([
          MenuItem("1","fClass", "F class"),
          MenuItem("2","fClass", "A class"),
          /*MenuItem(3, 'Class Item3'),
          MenuItem(4, 'Class Item4'),
          MenuItem(5, 'Class Item5'),*/
        ]),
      ),
    );

    list.add(
      FilterMenuData(
        'Currency',
        List.of([
          MenuItem("3","currency", 'CAD'),
          MenuItem("4","currency", 'USD'),
          // MenuItem(8, 'Currency Item3'),
        ]),
      ),
    );

    list.add(
      FilterMenuData(
        'Product Type',
        List.of([
          MenuItem("5",'ProductType', 'MLGIC'),
          MenuItem("6",'ProductType', 'PPN'),
          MenuItem("7",'ProductType', 'PAR'),
          // MenuItem(12, 'Product Type Item4'),
        ]),
      ),
    );

    list.add(
      FilterMenuData(
        'Assets Class',
        List.of([
          MenuItem("8",'AssetsClass', 'Equilt'),
          MenuItem("9",'AssetsClass', 'Commodity'),
          MenuItem("10",'AssetsClass', 'Interest-Rate'),
          MenuItem("11",'AssetsClass', 'Multi-asset'),
          //MenuItem(18, 'Assets Class Item5'),
        ]),
      ),
    );

    list.add(
      FilterMenuData(
        'Geography',
        List.of([
          MenuItem("12",'geography', 'Canada'),
          MenuItem("13",'geography', 'US'),
          MenuItem("14",'geography', 'International'),
          //MenuItem(22, 'Assets Class Item4'),
          // MenuItem(23, 'Assets Class Item5'),
        ]),
      ),
    );

   /* list.add(
      FilterMenuData(
        'Status',
        List.of([
          MenuItem('status', 'Called'),
          MenuItem('status', 'Matured'),
          MenuItem('status', 'Archived'),
          // MenuItem(22, 'Assets Class Item4'),
          // MenuItem(23, 'Assets Class Item5'),
        ]),
      ),
    );*/
    return list;
  }

  List<Widget> _getSubMenu(List<MenuItem> subMenuItems) {
    List<Widget> list = new List();
    bool isContained = false;
    subMenuItems.forEach(
      (submenu) {
        _isValueContained(submenu);
        print(
            'val contained id ${submenu.id} method response ${_isValueContained(submenu)}');
        list.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      submenu.itemTitle,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _isValueContained(submenu),
                    onChanged: (isChecked) {
                      setState(
                        () {
                          _performCheck(submenu);
                          setState(() {});
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    list.add(SizedBox(
      height: 15,
    ));
    return list;
  }

  bool _isValueContained(MenuItem submenu) {
    for (final i in HomePage.appliedFilterData.appliedSubMenu) {
      if (i.id == submenu.id) {
        return true;
      }
    }
    return false;
  }

  bool _performCheck(MenuItem submenu) {
    for (final i in HomePage.appliedFilterData.appliedSubMenu) {
      if (i.id == submenu.id) {
        HomePage.appliedFilterData.appliedSubMenu.remove(i);
        return true;
      }
    }
    HomePage.appliedFilterData.appliedSubMenu.add(submenu);

    if(HomePage.appliedFilterData.subMenu == null){
      HomePage.appliedFilterData.subMenu = new List<MenuItem>();
    }

    MenuItem newItem = HomePage.appliedFilterData.subMenu.firstWhere((item) =>
    item.key == submenu.key,
        orElse: () => null
    );
    if(newItem == null){
      newItem = submenu;
      HomePage.appliedFilterData.subMenu.add(newItem);
    }

    if(newItem.selectedValues == null){
      newItem.selectedValues = new List<String>();
    }
    newItem.selectedValues.add(submenu.itemTitle);

    return false;
  }
}

class IssueDateWidget extends StatefulWidget {
  const IssueDateWidget({
    Key key,
  }) : super(key: key);

  @override
  _IssueDateWidgetState createState() => _IssueDateWidgetState();
}

class _IssueDateWidgetState extends State<IssueDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 30, bottom: 10),
          child: Text(
            'Issue Date',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    getSelectDate(context).then((selectedData) {
                      setState(() {
                        // fromIssueDate = selectedData;
                        HomePage.appliedFilterData.issueDateData.issuedFrom =
                            selectedData;
                      });
                    });
                  },
                  child: TextFormField(
                    enabled: false,
                    style: TextStyle(fontFamily: 'WhitneyMediumItalic'),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        //focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText: HomePage.appliedFilterData.issueDateData
                                .issuedFrom.isEmpty
                            ? "From"
                            : HomePage
                                .appliedFilterData.issueDateData.issuedFrom,
                        hintStyle:
                            TextStyle(fontFamily: 'WhitneyMediumItalic')),
                  ),
                ),
              ),
            ),
            Text(
              '---',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    getSelectDate(context).then((selectedData) {
                      setState(() {
                        HomePage.appliedFilterData.issueDateData.issuedTo =
                            selectedData;
                        //_toIssueDateController.text = selectedData;
                      });
                    });
                  },
                  child: TextFormField(
                    style: TextStyle(fontFamily: 'WhitneyMediumItalic'),
                    enabled: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        //focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText: HomePage.appliedFilterData.issueDateData
                                .issuedTo.isEmpty
                            ? "To"
                            : HomePage.appliedFilterData.issueDateData.issuedTo,
                        hintStyle:
                            TextStyle(fontFamily: 'WhitneyMediumItalic')),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MaturityWidget extends StatefulWidget {
  const MaturityWidget({
    Key key,
  }) : super(key: key);

  @override
  _MaturityWidgetState createState() => _MaturityWidgetState();
}

class _MaturityWidgetState extends State<MaturityWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 30, bottom: 10),
          child: Text(
            'Maturity Date',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    getSelectDate(context).then((selectedData) {
                      setState(() {
                        HomePage.appliedFilterData.maturityDate.maturityFrom =
                            selectedData;
                        // _fromMaturityDateController.text = fromMaturityDate;
                      });
                    });
                  },
                  child: TextFormField(
                    style: TextStyle(fontFamily: 'WhitneyMediumItalic'),
                    enabled: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        //focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText: HomePage.appliedFilterData.maturityDate
                                .maturityFrom.isEmpty
                            ? "From"
                            : HomePage
                                .appliedFilterData.maturityDate.maturityFrom,
                        hintStyle:
                            TextStyle(fontFamily: 'WhitneyMediumItalic')),
                  ),
                ),
              ),
            ),
            Text(
              '---',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    getSelectDate(context).then(
                      (selectedData) {
                        setState(
                          () {
                            HomePage.appliedFilterData.maturityDate.maturityTo =
                                selectedData;
                            //       _toMaturiryDateController.text = toMaturityDate;
                          },
                        );
                      },
                    );
                  },
                  child: TextFormField(
                    style: TextStyle(fontFamily: 'WhitneyMediumItalic'),
                    enabled: false,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[50])),
                        //focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText: HomePage.appliedFilterData.maturityDate
                                .maturityTo.isEmpty
                            ? "To"
                            : HomePage
                                .appliedFilterData.maturityDate.maturityTo,
                        hintStyle:
                            TextStyle(fontFamily: 'WhitneyMediumItalic')),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Future<String> getSelectDate(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  String formattedDate = "";
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000, 1),
    lastDate: DateTime.now(),
  );
  var formatter = new DateFormat('dd MMM yyyy');
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
    formattedDate = formatter.format(selectedDate);
  } else {
    formattedDate = "";
  }

  return formattedDate;
}
