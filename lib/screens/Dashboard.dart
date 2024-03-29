import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structured_notes/providers/FilterDataProvider.dart';
import 'package:structured_notes/screens/EducationCenter.dart';
import 'package:structured_notes/model/AppliedFilterData.dart';
import 'package:structured_notes/screens/Login/LoginScreen.dart';
import 'package:structured_notes/screens/Search/SearchScreen.dart';
import 'package:structured_notes/util/Theme.dart';
import 'ContactUs/ContactUsScreen.dart';
import 'CurrentOfferings/CurrentOfferings.dart';
import 'FilterPage.dart';
import 'HomePage.dart';
import 'package:flutter/services.dart';

import 'PriviouslyIssued.dart';
import 'Publication.dart';
import 'QA/QA.dart';
import 'VIdeoPage.dart';
import '../drawer_scaffold/drawer_scaffold.dart';
import '../drawer_scaffold/menu_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:structured_notes/screens/CurrentOfferings/CurrentOfferings.dart';

import 'noteDetails/NoteDetailsScreen.dart';


bool isNavigationActivated = false;
//bool isSearchComplete=false;
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
      new MenuItem(
        id: '6',
        title: 'Q&A',
      ),

      new MenuItem(
        id: '7',
        title: 'Contact Us',
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
    "Publications",
    "Q&A",
    "Contact Us"
  ];
  var selectedMenuItemId = '1';
  DrawerScaffoldController _controller;
  TextEditingController _searchEditController;
  AppliedFilterData appliedFilterData; //= AppliedFilterData();
  int _appliedFilterCount = 0;
  int _selectedCategoryPosition = 1;
  FocusNode f1 = FocusNode();
  bool _isAutofocusEnabled = false;

  bool get isSearchComplete => null;
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

    //var data = FilterDataProvider.of(context).appliedFilterData;
    return WillPopScope(
      onWillPop: onBackPressed,
      child: new DrawerScaffold(
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
              isNavigationActivated = false;
              _contentView = itemId == "1"
                  ? HomePage(onCategorySelectedFromHomePage: _onCategorySelectedFromHome,)
                  : itemId == "2"
                      ? CurrentOfferings(selectedCategoryPosition: _selectedCategoryPosition)
                      : itemId == "3"
                          ? PriviouslyIssued()
                          : itemId == "4" ? EducationCenter() : itemId == "5" ? Publication() :itemId == "6" ? QA(): ContactUsScreen();
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
                          onPressed: () {
                            setState(() {
                              _isAutofocusEnabled= true;
                            });

                            _controller.menuController.toggle();
                            Timer(Duration(milliseconds: 500), (){
                              FocusScope.of(context).requestFocus(f1);
                              setState(() {
                                _isAutofocusEnabled = false;
                              });

                            });


                          }),
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
      ),
    );
  }

  Widget headerView(BuildContext context) {

    return Container(
      padding:
          const EdgeInsets.only(left: 20, top: 100, right: 160, bottom: 40),
      width: MediaQuery.of(context).size.width * .5,
      child: TextField(
        controller: _searchEditController,
        cursorColor: accentColor,
        autofocus: _isAutofocusEnabled,
        focusNode: f1,
        style: TextStyle(color: Colors.black, fontSize: 20),
        decoration: InputDecoration(
            suffixIcon: Container(margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: accentColor,shape: BoxShape.circle),
              child: InkWell(child: Icon(
                Icons.search,
                color: white,

              ), onTap: (){
                _searchEditController.text.trim().toString().isNotEmpty?
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SearchScreen(searchKeywords: _searchEditController.text.toString(),isSearchComplete: false,),
                        fullscreenDialog: true)): print("No keyword found");

                //if(_searchEditController.text.toString().isEmpty)


              }),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
      padding: const EdgeInsets.only(right: 140, bottom: 170),
      child: Column(children: <Widget>[
          GestureDetector(
          onTap: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen()));
    },
      child: Text(" ",textAlign: TextAlign.end, ), // contact us link
    )


       /* Padding(
          padding: const EdgeInsets.only(right: 150, bottom: 70),
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
        ),*/
      ],),
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
      FilterDataProvider(
        child: CurrentOfferings(),
        appliedFilterData: appliedFilterData,

      );
      CurrentOfferings.appliedFilterData=this.appliedFilterData;

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
    /*CurrentOfferings(appliedFilterData:this.appliedFilterData,);*/
    print('count is $count and $_appliedFilterCount');
    return count;
  }

  void _onCategorySelectedFromHome(int selectedCategory,int selectedPage) {
    if(selectedPage==2){
      _contentView = CurrentOfferings(selectedCategoryPosition: selectedCategory,);
      selectedMenuItemId="2";
    }else if(selectedPage==3){
      _contentView = EducationCenter();
      selectedMenuItemId="4";
    }else if(selectedPage==4){
      _contentView = Publication();
      selectedMenuItemId="5";
    }else if(selectedPage==5){
      _contentView = QA();
      selectedMenuItemId="6";
    }else if(selectedPage==6){
      selectedMenuItemId="7";
    }
    setState(() {
      isNavigationActivated = true;

    });
  }

  Future<bool> onBackPressed() {
    if(isNavigationActivated){
      setState(() {
        isNavigationActivated = false;
        selectedMenuItemId = "1";
        _contentView = HomePage(onCategorySelectedFromHomePage: _onCategorySelectedFromHome,);

      });
      return Future.value(false);
    }
    return Future.value(true);
  }
}
