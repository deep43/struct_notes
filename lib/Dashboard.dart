import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structured_notes/EducationCenter.dart';
import 'package:structured_notes/model/AppliedFilterData.dart';
import 'package:structured_notes/util/Theme.dart';
import 'CurrentOfferings.dart';
import 'FilterPage.dart';
import 'HomePage.dart';
import 'package:flutter/services.dart';

import 'PriviouslyIssued.dart';
import 'Publication.dart';
import 'drawer_scaffold/drawer_scaffold.dart';
import 'drawer_scaffold/menu_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:structured_notes/CurrentOfferings.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final menu = new Menu(
    items: [
      new MenuItem(
        id: '1',
        title: 'Home',
      ),
      new MenuItem(
        id: '2',
        title: 'Current Offerings',
      ),
      new MenuItem(
        id: '3',
        title: 'Previously Issued',
      ),
      new MenuItem(
        id: '4',
        title: 'Education Center',
      ),
      new MenuItem(
        id: '5',
        title: 'Publications',
      ),
    ],
  );

  // final _contentViews = [HomePage(), CurrentOfferings(),PriviouslyIssued(),  EducationCenter(), Publication() ];



  var _contentView;
  final _contentNames = [
    "CIBC Structured Notes",
    "Current Offerings",
    "Previously Issued",
    "Education Center",
    "Publications"
  ];
  var selectedMenuItemId = '1';
  DrawerScaffoldController _controller;
  TextEditingController _searchEditController;
  AppliedFilterData appliedFilterData; //= AppliedFilterData();
  int _appliedFilterCount = 0;
  int _selectedCategoryPosition = 1;
  @override
  void initState() {
    super.initState();
    _controller = DrawerScaffoldController();
    _searchEditController = TextEditingController();
    _initController();
  }

  @override
  void dispose() {
    _controller.menuController.dispose();
    _searchEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('applied count in build $_appliedFilterCount');
    return new DrawerScaffold(
      cornerRadius: 0,
      showAppBar: false,
      appBar: AppBarProps(
        elevation: 0,
        title: Container(
          child: Row(
            children: <Widget>[
              IconButton(
                padding: const EdgeInsets.only(bottom: 4, right: 8, top: 4),
                icon: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset('assets/images/side_menu.svg')),
                onPressed: () {
                  _controller.menuController.toggle();
                },
              ),
              Expanded(child: Text('CIBC Structured Notes'))
            ],
          ),
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(Icons.search),
              onPressed: () {}),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      controller: _controller,
      menuView: new MenuView(
        alignment: Alignment.topCenter,
        menu: menu,
        headerView: headerView(context),
        animation: false,
        color: Colors.white,
        selectedItemId: selectedMenuItemId,
        textStyle: TextStyle(
          fontSize: 20,
        ),
        selectorColor: accentTextColor,
        onMenuItemSelected: (String itemId) {
          setState(() {
            _contentView = itemId == "1"
                ? HomePage(onCategorySelectedFromHomePage: _onCategorySelectedFromHome,)
                : itemId == "2"
                    ? CurrentOfferings(selectedCategoryPosition: _selectedCategoryPosition)
                    : itemId == "3"
                        ? PriviouslyIssued()
                        : itemId == "4" ? EducationCenter() : Publication();
            selectedMenuItemId = itemId;
          });
        },
        footerView: footerView(),
      ),
      contentView: Screen(
        contentBuilder: (context) => Stack(
          children: <Widget>[
            _contentView==null?HomePage(onCategorySelectedFromHomePage: _onCategorySelectedFromHome,):_contentView,
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RawMaterialButton(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                          backgroundColor: selectedMenuItemId == "1"
                              ? Colors.white
                              : accentColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/images/side_menu.svg',
                              color: selectedMenuItemId == "1"
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),),
                      onPressed: () {
                        _controller.menuController.toggle();
                      },
                      shape: new CircleBorder(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        selectedMenuItemId == "1"
                            ? _contentNames[0]
                            : _contentNames[int.parse(selectedMenuItemId) - 1],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                            color: selectedMenuItemId == "1"
                                ? Colors.white
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      child: selectedMenuItemId == "1"
                          ? SizedBox(
                              width: 0,
                              height: 0,
                            )
                          : Stack(
                              children: <Widget>[
                                RawMaterialButton(
                                  constraints: BoxConstraints(),
                                  padding: const EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    'assets/images/filter.svg',
                                    color: accentColor,
                                    width: 26,
                                    height: 26,
                                  ),
                                  shape: new CircleBorder(),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                FilterPage(
                                                  onFilterApplied:
                                                      _onFilterApplied,
                                                ),
                                            fullscreenDialog: true));
                                  },
                                ),
                                FutureBuilder(
                                  builder: (BuildContext context, snapshot) {
                                    if (_appliedFilterCount <= 0) {
                                      return Container();
                                    } else {
                                      return Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          height: 22,
                                          width: 22,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: accentColor,
                                              shape: BoxShape.circle),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                _appliedFilterCount.toString(),
                                                style: TextStyle(
                                                    color: white, fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  initialData: 0,
                                  future: _getAppliedFilter(),
                                )
                              ],
                            ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    RawMaterialButton(
                        constraints: BoxConstraints(),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.search,
                          color: selectedMenuItemId == "1"
                              ? Colors.white
                              : Colors.black,
                          size: 26,
                        ),
                        shape: new CircleBorder(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {}),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerView(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 20, top: 100, right: 160, bottom: 40),
      width: MediaQuery.of(context).size.width * .5,
      child: TextFormField(
        controller: _searchEditController,
        cursorColor: accentColor,
        style: TextStyle(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: accentColor,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: accentColor, width: 1),
              gapPadding: 0,
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: accentColor, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
            hintText: 'Search',
            hintStyle:
                TextStyle(fontSize: 20, fontFamily: 'WhitneyMediumItalic')),
      ),
    );
  }

  Widget footerView() {
    return Padding(
      padding: const EdgeInsets.only(right: 150, bottom: 100),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: accentColor,
            onPressed: () {},
            child: Text(
              'Log In',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _initController() async {
    Timer(Duration(milliseconds: 500), () {
      _controller.menuController.addListener(() {
        print('menu toggled');
        FocusScope.of(context).requestFocus(new FocusNode());
      });
    });
  }

  _onFilterApplied(AppliedFilterData appliedFilterData) {
    this.appliedFilterData = appliedFilterData;
    int count = 0;
    if (appliedFilterData == null) {
      return 0;
    }
    if (appliedFilterData.appliedSubMenu != null) {
      count += appliedFilterData.appliedSubMenu.length;
    }
    if (appliedFilterData.maturityDate.maturityFrom.isNotEmpty &&
        appliedFilterData.maturityDate.maturityTo.isNotEmpty) {
      count += 1;
    }
    if (appliedFilterData.issueDateData.issuedFrom.isNotEmpty &&
        appliedFilterData.issueDateData.issuedTo.isNotEmpty) {
      count += 1;
    }

    print('count is $count and $_appliedFilterCount');

    setState(() {
      _appliedFilterCount = count;
    });

    print(
        'applied filter ${appliedFilterData.appliedSubMenu.length} and ${this.appliedFilterData.appliedSubMenu.length}');
  }

  Future<int> _getAppliedFilter() async {
    this.appliedFilterData = appliedFilterData;
    int count = 0;
    if (appliedFilterData == null) {
      return 0;
    }
    if (appliedFilterData.appliedSubMenu != null) {
      count += appliedFilterData.appliedSubMenu.length;
    }
    if (appliedFilterData.maturityDate.maturityFrom.isNotEmpty &&
        appliedFilterData.maturityDate.maturityTo.isNotEmpty) {
      count += 1;
    }
    if (appliedFilterData.issueDateData.issuedFrom.isNotEmpty &&
        appliedFilterData.issueDateData.issuedTo.isNotEmpty) {
      count += 1;
    }

    print('count is $count and $_appliedFilterCount');
    return count;
  }

  void _onCategorySelectedFromHome(int selectedCategory) {
    setState(() {
      selectedMenuItemId="2";
      _selectedCategoryPosition = selectedCategory;
      _contentView = CurrentOfferings(selectedCategoryPosition: selectedCategory,);
    });
  }
}
