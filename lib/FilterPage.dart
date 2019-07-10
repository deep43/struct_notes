import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                        focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText: 'Search by Note Name, FundSERV, CUSIP or ADP',
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
              fillColor: accentColor,
              onPressed: () {},
              child: Text(
                'DONE',
                style: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 16),
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

  List<MenuItem> _selectedMenuItems = List();

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
                      value: _selectedMenuItems.contains(submenu),
                      onChanged: (isChecked) {
                        setState(() {
                          _selectedMenuItems.contains(submenu)
                              ? _selectedMenuItems.remove(submenu)
                              : _selectedMenuItems.add(submenu);
                        });
                      })
                ],
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

class IssueDateWidget extends StatefulWidget {
  const IssueDateWidget({
    Key key,
  }) : super(key: key);

  @override
  _IssueDateWidgetState createState() => _IssueDateWidgetState();
}

class _IssueDateWidgetState extends State<IssueDateWidget> {
  String fromIssueDate,toIssueDate;
  TextEditingController _fromIssueDateController,_toIssueDateController;

  @override
  void initState() {
    super.initState();
    _fromIssueDateController = TextEditingController();
    _toIssueDateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _fromIssueDateController.dispose();
    _toIssueDateController.dispose();
  }
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
                  onTap: (){
                    getSelectDate(context).then((selectedData){
                      setState(() {
                        fromIssueDate = selectedData;
                        _fromIssueDateController.text = fromIssueDate;
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
                        focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText:_fromIssueDateController.text.isEmpty?"From":fromIssueDate,
                        hintStyle: TextStyle(fontFamily: 'WhitneyMediumItalic')),
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
                  onTap: (){
                    getSelectDate(context).then((selectedData){
                      setState(() {
                        toIssueDate = selectedData;
                        _toIssueDateController.text = toIssueDate;
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
                        focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText:_toIssueDateController.text.isEmpty?"To":toIssueDate,
                        hintStyle: TextStyle(fontFamily: 'WhitneyMediumItalic')),
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
  String fromMaturityDate,toMaturityDate;
  TextEditingController _fromMaturityDateController,_toMaturiryDateController;

  @override
  void initState() {
    super.initState();
    _fromMaturityDateController = TextEditingController();
    _toMaturiryDateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _fromMaturityDateController.dispose();
    _toMaturiryDateController.dispose();
  }

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
                  onTap: (){
                    getSelectDate(context).then((selectedData){
                      setState(() {
                        fromMaturityDate = selectedData;
                        _fromMaturityDateController.text = fromMaturityDate;
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
                        focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText:_fromMaturityDateController.text.isEmpty?"From":fromMaturityDate,
                        hintStyle: TextStyle(fontFamily: 'WhitneyMediumItalic')),
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
                  onTap: (){
                    getSelectDate(context).then((selectedData){
                      setState(() {
                        toMaturityDate = selectedData;
                        _toMaturiryDateController.text = toMaturityDate;
                      });
                    });
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
                        focusColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[200]),
                        ),
                        hintText:_fromMaturityDateController.text.isEmpty?"To":fromMaturityDate,
                        hintStyle: TextStyle(fontFamily: 'WhitneyMediumItalic')),
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
  }else{
    formattedDate="";
  }



  return formattedDate;
}
