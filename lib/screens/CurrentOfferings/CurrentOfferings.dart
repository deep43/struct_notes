import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:structured_notes/data_providers/DataProvider.dart';
import 'package:structured_notes/data_providers/DataProviderInterface.dart';
import 'package:structured_notes/model/AppliedFilterData.dart';
import 'package:structured_notes/model/CompareNotesData.dart' as prefix0;
import 'package:structured_notes/model/current_item.dart';
import 'package:structured_notes/model/current_offering_data.dart';
import 'package:structured_notes/model/issues_notes_data.dart';
import 'package:structured_notes/model/isuued_note_item.dart';
import 'package:structured_notes/providers/FilterDataProvider.dart';
import 'package:structured_notes/util/SNListWidget.dart';
import 'package:structured_notes/util/Theme.dart';

import '../CompareScreen.dart';
import '../../model/CompareNotesData.dart';
import '../../model/OfferingsData.dart';
import 'package:vibration/vibration.dart';

enum SelectedCategory { MLCIs, PPNs, PARs }

final DataProviderInterface _dataProvider = DataProvider().getDataProvider();

class CurrentOfferings extends StatefulWidget {
  final int selectedCategoryPosition;

  static AppliedFilterData appliedFilterData;

  CurrentOfferings({this.selectedCategoryPosition});

  @override
  _CurrentOfferingsState createState() => _CurrentOfferingsState(
      selectedCategoryPosition: selectedCategoryPosition);
}

class _CurrentOfferingsState extends State<CurrentOfferings>
    with SingleTickerProviderStateMixin {
  final int selectedCategoryPosition;

  _CurrentOfferingsState({this.selectedCategoryPosition});

  // static AppliedFilterData mAppliedFilterData = new AppliedFilterData();
  List<SNData> _compareItems = new List();
  List<SNData> compareItems = new List();
  List<SNData> currentOfferingList = new List();
  List<dynamic> currentOfferingListAsMap = new List<dynamic>();
  CuttentOfferingItemData notesData;
  List<OfferingData> currentOfferingDataList;
  SelectedCategory _selectedCategory;
  AnimationController controller;
  Animation<Offset> offset;
  int noOfItems = 0;

  @override
  void initState() {
    super.initState();
    if (selectedCategoryPosition == 1) {
      _selectedCategory = SelectedCategory.MLCIs;
    } else if (selectedCategoryPosition == 2) {
      _selectedCategory = SelectedCategory.PPNs;
    } else if (selectedCategoryPosition == 3) {
      _selectedCategory = SelectedCategory.PARs;
    }
    //currentOfferingList = getDummyOfferingsData();

    //mAppliedFilterData=widget.getFilteredData();
    getData(_selectedCategory);

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    /*if (FilterDataProvider.of(context) != null) {
      var data = FilterDataProvider.of(context);
      print(data);
    }*/
    if (CurrentOfferings.appliedFilterData != null) {
      print(CurrentOfferings.appliedFilterData.appliedSubMenu.length);
      setState(() {
        currentOfferingList = populateListData(currentOfferingDataList);
      });
      //print(currentOfferingDataList.length);
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideTransition(
        position: offset,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: _compareItems.length > 0
              ? FloatingActionButton.extended(
                  backgroundColor: accentColor,
                  onPressed: () {
                    if (_compareItems.length > 1) {
                      noOfItems = _compareItems.length;
                      SNCompareItems();
                      /*Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              ComparePage(compareItems: _compareItems),
                          fullscreenDialog: true));*/
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: Text('Compare'))
              : Container(),
        ),
      ),
      body: CurrentOfferingsInheritedWidget(
        selectedCategory: _selectedCategory,
        offeringDataList: currentOfferingList,
        comapringDataList: _compareItems,
        child: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      //elevation:5,
                      //color: white,
                      //margin: EdgeInsets.only( left: 0.0, right: 0.0 ),
                      decoration: new BoxDecoration(
                        //border: new Border.all(width: 1.0, color: Colors.grey.withOpacity(0.7)),
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: Offset(1.0, 3.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),

                      //shadowColor: Colors.black45,
                      child: Container(
                        color: white,
                        child: Column(
                          children: <Widget>[
                            AppBar(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                            ),
                            new CategoryWidget(
                              onCategorySelected: _onCategorySelected,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Product Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    'Compare',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: SNListWidget(
                          isItemSelectable: true,
                          onItemSelect: _onComapareItemsSelected,
                          listData: currentOfferingList),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }

  /*_getList(List<SNData> _comaringItemList)  {
    setState(() {


    });
  }*/

  _onComapareItemsSelected(List<SNData> items) {
    if (items.length > 1) {
      controller.forward();
    } else if (items.length != 0) {
      controller.reverse();
    }
    setState(() {
      this._compareItems = items;
    });
  }

  _onCategorySelected(SelectedCategory selectedCategory) {
    setState(() {
      _compareItems.clear();
      compareItems.clear();
      _selectedCategory = selectedCategory;
      // currentOfferingList = getDummyOfferingsData();
      getData(_selectedCategory);
    });
  }

  Future<bool> getData(SelectedCategory selectedCategory) async {
    try {
      switch (_selectedCategory) {
        case SelectedCategory.MLCIs:
          await _dataProvider.getMLGICOffers().then(processData);
          break;
        case SelectedCategory.PPNs:
          await _dataProvider.getPPNOffers().then(processData);
          break;
        case SelectedCategory.PARs:
          await _dataProvider.getPAROffers().then(processData);
          break;
      }
    } catch (e) {
      print('debuggg111111333333 calling getData() - error: ' + e.toString());
    }
    return true;
  }

  Future processData(data) async {
    var jsonNotesData = json.decode(data.toString());

    notesData = new CuttentOfferingItemData.fromJson(jsonNotesData);
    currentOfferingDataList = notesData.noteColumns;
    currentOfferingListAsMap = jsonNotesData['noteColumns'];

    // issuedNoteList = issuedNotesData.noteColumns;
    /*for (var i = 0; i < currentOfferingDataList.length; i++) {
      OfferingData note = currentOfferingDataList[i];
    }*/
    setState(() {
      currentOfferingList = populateListData(currentOfferingDataList);
    });
  }

  List<OfferingData> filterListData(List<dynamic> currentofferingList) {
    var filteredList = new List<OfferingData>();
    if (CurrentOfferings.appliedFilterData == null) {
      for (var i = 0; i < currentofferingList.length; i++) {
        filteredList.add(OfferingData.fromJson(currentofferingList[i]));
      }

      return filteredList;
    }

    var subMenuList = CurrentOfferings.appliedFilterData.subMenu;
    for (var j = 0; j < currentofferingList.length; j++) {
      var flag = true;
      for (var i = 0; i < subMenuList.length; i++) {
        var mapItem = currentofferingList[j] as Map;
        if (!subMenuList[i].selectedValues.contains(mapItem[subMenuList[i].key])) {
          flag = false;
          break;
        }
      }

      if (flag == true) filteredList.add(OfferingData.fromJson(currentofferingList[j]));
    }

    return filteredList;
  }

  List<SNData> populateListData(List<OfferingData> currentofferingList) {
    currentofferingList = filterListData(currentOfferingListAsMap);

    List<SNData> _snDataList = new List();
    List<SNData> _snDataFilteredList = new List();
    for (var i = 0; i < currentofferingList.length; i++) {
      OfferingData note = currentofferingList[i];
//      print("getIssuedNotes Item debug: " + i.toString() + note.noteName.toString());

      _snDataList.add(
        SNData(
          note.noteName,
          note.issueDate,
          new List.of(
            [
              SNItem("FundSERV", note.fundServ),
              SNItem("Avail Until", note.availableUntil),
              SNItem("Term", note.term),
              SNItem("Issue Date", note.issueDate),
              SNItem("Maturity Date", note.maturityDate),
              SNItem("Min Investment", note.minInvest),
              SNItem("How to Buy", note.howToBuy),
            ],
          ),
        ),
      );
    }

    return _snDataList;
  }

  Future<bool> SNCompareItems() async {
    try {
//      await _dataProvider.compareNotes(noteId1, noteId2, noteId3).then(onValue);
      await _dataProvider.compareNotes(10, 10, 20).then(processComparedata);
    } catch (e) {
      print('debuggg111111333333 calling SNCompareItems() - error: ' +
          e.toString());
    }
  }

  Future processComparedata(value) {
    var jsonNotesData = json.decode(value.toString());

    CompareNotesData compareNotesData =
        CompareNotesData.fromJson(jsonNotesData);
    Header header = compareNotesData.results.header;

    List<String> headings = header.heading;

    List<CompareRow> row = compareNotesData.results.row;
    // CompareRow compareRow = row[3];
    //compareItems = new List();
    compareItems.clear();
    compareItems = getSncomareHeader(headings, row);
    if (noOfItems == 2) {
      compareItems.removeLast();
    }

    setState(() {
      //_compareItems.clear();

      _compareItems = compareItems;

      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ComparePage(compareItems: _compareItems),
          fullscreenDialog: true));
    });
  }

  List<SNData> getSncomareHeader(List<String> headings, List<CompareRow> row) {
    List<SNData> _compareItems = new List();
    SNItem snItem;
    List<SNItem> snList;
    SNData snData;
    var count = 0;
    for (int i = 0; i < headings.length; i++) {
      if (headings[i].isEmpty) {
        count = 0;
        continue;
      }
      snList = List<SNItem>();
      for (int j = 0; j < row.length; j++) {
        List<String> col = row[j].col;
        for (int k = 0; k < col.length; k++) {
          if (col[k].toString().isEmpty) {
            break;
          } else {
            snItem = new SNItem(col[k], col[k + 2 + count]);
            snList.add(snItem);
            break;
            //_compareItems.add(new SNData(headings[], time, SNItem("FundSERV", note.fundServ),))
          }
        }
      }
      snData = new SNData(headings[i], "time", snList);
      _compareItems.add(snData);
      count++;
    }

    return _compareItems;
  }
}

class CategoryWidget extends StatefulWidget {
  final Function onCategorySelected;

  const CategoryWidget({Key key, this.onCategorySelected}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    CurrentOfferingsInheritedWidget currentOfferingsInheritedWidget =
        CurrentOfferingsInheritedWidget.of(context);

    return new GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 30, bottom: 10, left: 8, right: 8),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 4,
      children: <Widget>[
        new Card(
          color: currentOfferingsInheritedWidget.selectedCategory ==
                  SelectedCategory.MLCIs
              ? accentColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 6,
          child: InkWell(
            onTap: () async {
              Vibration.hasVibrator().then((hasVibrator) {
                Vibration.vibrate(duration: 70);
              });
              widget.onCategorySelected(SelectedCategory.MLCIs);
            },
            child: new Container(
              padding: const EdgeInsets.all(6),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'MLCICs',
                    style: new TextStyle(
                        fontSize: 22.0,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w700,
                        color:
                            currentOfferingsInheritedWidget.selectedCategory ==
                                    SelectedCategory.MLCIs
                                ? white
                                : accentTextColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    'Market Linked GICs',
                    style: new TextStyle(
                        color:
                            currentOfferingsInheritedWidget.selectedCategory ==
                                    SelectedCategory.MLCIs
                                ? secondaryWhiteTextColor
                                : secondaryTextColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        new Card(
          color: currentOfferingsInheritedWidget.selectedCategory ==
                  SelectedCategory.PPNs
              ? accentColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 6,
          child: InkWell(
            onTap: () {
              Vibration.hasVibrator().then((hasVibrator) {
                Vibration.vibrate(duration: 70);
              });
              widget.onCategorySelected(SelectedCategory.PPNs);
            },
            child: new Container(
              padding: const EdgeInsets.all(6),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'PPNs',
                    style: new TextStyle(
                        fontSize: 22.0,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w700,
                        color:
                            currentOfferingsInheritedWidget.selectedCategory ==
                                    SelectedCategory.PPNs
                                ? white
                                : accentTextColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    'Principle Protected Notes',
                    style: new TextStyle(
                        color:
                            currentOfferingsInheritedWidget.selectedCategory ==
                                    SelectedCategory.PPNs
                                ? secondaryWhiteTextColor
                                : secondaryTextColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        new Card(
          color: currentOfferingsInheritedWidget.selectedCategory ==
                  SelectedCategory.PARs
              ? accentColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 6,
          child: InkWell(
            onTap: () {
              Vibration.hasVibrator().then((hasVibrator) {
                Vibration.vibrate(duration: 70);
              });
              widget.onCategorySelected(SelectedCategory.PARs);
            },
            child: new Container(
              padding: const EdgeInsets.all(6),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'PARs',
                    style: new TextStyle(
                        letterSpacing: 1.6,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color:
                            currentOfferingsInheritedWidget.selectedCategory ==
                                    SelectedCategory.PARs
                                ? white
                                : accentTextColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    'Principle At Risk Notes',
                    style: new TextStyle(
                        color:
                            currentOfferingsInheritedWidget.selectedCategory ==
                                    SelectedCategory.PARs
                                ? secondaryWhiteTextColor
                                : secondaryTextColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*class OfferingList extends StatefulWidget {
  final Function(List<SNData>) onCompareItemsSelected;

  // final List<OfferingsData> offeringsList;

  OfferingList({this.onCompareItemsSelected});

  @override
  _OfferingListState createState() => _OfferingListState();
}

class _OfferingListState extends State<OfferingList>
    with SingleTickerProviderStateMixin {
  List<SNData> _offeringsItemList = new List();
  List<SNData> _comaringItemList = new List();
  AnimationController subCategoryItemEntranceAnimationController;
  List<Animation> subCategoryItemAnimations;

  @override
  void initState() {
    subCategoryItemEntranceAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    subCategoryItemEntranceAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CurrentOfferingsInheritedWidget inheritedWidget =
        CurrentOfferingsInheritedWidget.of(context);
    _buildAnimationList(inheritedWidget.offeringDataList);
    if (inheritedWidget.offeringDataList != _offeringsItemList) {
      subCategoryItemEntranceAnimationController.reset();
      _offeringsItemList = inheritedWidget.offeringDataList;
      _comaringItemList = inheritedWidget.comapringDataList;

      subCategoryItemEntranceAnimationController.forward();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shrinkWrap: true,
      separatorBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            height: 2,
            color: accentColor,
          ),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        print('refresed');
        return AnimatedBuilder(
          animation: subCategoryItemEntranceAnimationController,
          builder: (context, child) => new Transform.translate(
            offset: Offset(
              subCategoryItemAnimations[index].value,
              0.0,
            ),
            child: child,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              ExpandablePanel(
                  hasIcon: false,
                  iconPlacement: ExpandablePanelIconPlacement.left,
                  tapHeaderToExpand: true,
                  header: Container(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(inheritedWidget.offeringDataList[index].title),
                            Text(inheritedWidget.offeringDataList[index].time),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 5,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: accentColor,
                                    border: Border.all(
                                      color: accentColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  height: 5,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: accentColor,
                                    border: Border.all(
                                      color: accentColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  height: 5,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: accentColor,
                                    border: Border.all(
                                      color: accentColor,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                        InkWell(
                          onTap: () {
                            if (_comaringItemList
                                .contains(_offeringsItemList[index])) {
                              _comaringItemList
                                  .remove(_offeringsItemList[index]);
                            } else {
                              _comaringItemList.add(_offeringsItemList[index]);
                            }
                            widget.onCompareItemsSelected(_comaringItemList);
                            // setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              constraints: BoxConstraints(),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _comaringItemList.contains(
                                          inheritedWidget
                                              .offeringDataList[index])
                                      ? accentColor
                                      : Colors.transparent,
                                  border: Border.all(color: accentColor)),
                              padding: const EdgeInsets.all(6),
                              child: _comaringItemList.contains(
                                      inheritedWidget.offeringDataList[index])
                                  ? SvgPicture.asset(
                                      'assets/images/tick.svg',
                                      color: white,
                                      width: 16,
                                      height: 16,
                                    )
                                  : SizedBox(
                                      width: 16,
                                      height: 16,
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  expanded: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 10,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: _getOfferingItemList(
                            inheritedWidget.offeringDataList[index].snItems),
                      ),
                    ),
                  )),
              SizedBox(
                height: 5,
              )
            ],
          ),
        );
      },
      itemCount: inheritedWidget.offeringDataList.length,
    );
  }

  void _buildAnimationList(List<SNData> offeringDataList) {
    subCategoryItemAnimations = offeringDataList.map((subCat) {
      int index = offeringDataList.indexOf(subCat);
      double start = index * 0.1;
      double duration = 0.6;
      double end = duration + start >= 1 ? 1.0 : duration + start;
      return new Tween<double>(begin: 400.0, end: 0.0).animate(
          new CurvedAnimation(
              parent: subCategoryItemEntranceAnimationController,
              curve: new Interval(start, end, curve: Curves.decelerate)));
    }).toList();
  }

  List<Widget> _getOfferingItemList(List<SNItem> offeringItems) {
    List<Column> items = new List();
    offeringItems.forEach((item) {
      items.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Text(item.value)
        ],
      ));
    });
    return items;
  }
}*/

class CurrentOfferingsInheritedWidget extends InheritedWidget {
  final SelectedCategory selectedCategory;
  final List<SNData> offeringDataList;
  final List<SNData> comapringDataList;

  const CurrentOfferingsInheritedWidget(
      {Key key,
      @required this.selectedCategory,
      @required this.offeringDataList,
      @required this.comapringDataList,
      @required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(CurrentOfferingsInheritedWidget oldWidget) {
    return oldWidget.selectedCategory != selectedCategory;
  }

  static CurrentOfferingsInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CurrentOfferingsInheritedWidget)
        as CurrentOfferingsInheritedWidget;
  }
}
