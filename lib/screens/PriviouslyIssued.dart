import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structured_notes/model/OfferingsData.dart';
import 'package:structured_notes/util/SNListWidget.dart';
import '../model/OfferingsData.dart';
import 'package:structured_notes/util/Theme.dart';
import 'CompareScreen.dart';
import '../data_providers/DataProvider.dart';
import '../data_providers/DataProviderInterface.dart';
import '../model/issues_notes_data.dart';
import '../model/isuued_note_item.dart';

final DataProviderInterface _dataProvider = DataProvider().getDataProvider();

class PriviouslyIssued extends StatefulWidget {
  @override
  _PriviouslyIssuedState createState() => _PriviouslyIssuedState();
}

class _PriviouslyIssuedState extends State<PriviouslyIssued>
    with SingleTickerProviderStateMixin {
  List<SNData> _compareItems = new List();
  List<SNData> previouslyIssuedList = new List();
  List<SNData> offeringItemsII = new List();
  NotesData notesData;
  List<IssuedNote> issuedNoteList;
  SelectedCategory _selectedCategory;
  AnimationController controller;
  Animation<Offset> offset;


  @override
  void initState() {
    super.initState();
    var status = getData();
   // offeringItems = populateListData(issuedNoteList);
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          ComparePage(compareItems: _compareItems),
                      fullscreenDialog: true));
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
        offeringDataList: previouslyIssuedList,
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

                      decoration: new BoxDecoration(
                        //border: new Border.all(width: 1.0, color: Colors.grey.withOpacity(0.7)),
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            offset: Offset(1.0, 3.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),

                      child: Container(
                        color: white,
                        child: Column(
                          children: <Widget>[
                            AppBar(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
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
                        child: MediaQuery.removePadding(removeTop: true,context: context, child: SNListWidget(
                            isItemSelectable: true,
                            onItemSelect: _onComapareItemsSelected,
                            listData: previouslyIssuedList),)
                    ),
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
      _selectedCategory = selectedCategory;
      previouslyIssuedList = populateListData(issuedNoteList);
    });
  }

  Future<bool> getData() async {
    try{
      await _dataProvider.getIssuedNotes().then((data)  async{
        var jsonNotesData = json.decode(data.toString());

        notesData = new NotesData.fromJson(jsonNotesData);
        var issuedNotesData = notesData.data;
        issuedNoteList = issuedNotesData.noteColumns;
        for(var i = 0; i < issuedNoteList.length; i++){
          IssuedNote note = issuedNoteList[i];
        }
        setState(() {
          previouslyIssuedList = populateListData(issuedNoteList);
        });
      });
    }
    catch(e) {
      print('debuggg111111333333 calling getData() - error: ' + e.toString());
    }
    return true;
  }
  List<SNData> populateListData(List<IssuedNote> issuedNoteList) {
    List<SNData> _snDataList = new List();
    for(var i = 0; i < issuedNoteList.length; i++){
      IssuedNote note = issuedNoteList[i];
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
    
    
    /*for (int i = 0; i < 3; i++) {
      _snDataList.add(
        SNData(
          "CIBC Floating Market Rate GICs (3 years) (USD)",
          "Due January 11, 2011",
          new List.of(
            [
              SNItem("FundSERV", "CBL2039"),
              SNItem("Avail Until", "Mar 3, 2019"),
              SNItem("Term", "3"),
              SNItem("Issue Date", "Apr 7, 2019"),
              SNItem("Maturity Date", "Mar 7, 2019"),
              SNItem("Min Investment", "\$5000 USD"),
              SNItem("How to Buy", "FundSERV CBL2039"),
            ],
          ),
        ),
      );
      _snDataList.add(
        SNData(
          "CIBC Floating Market Rate GICs (2 years) (USD)",
          "Due January 11, 2011",
          new List.of(
            [
              SNItem("FundSERV", "CBL2039"),
              SNItem("Avail Until", "Mar 3, 2019"),
              SNItem("Term", "3"),
              SNItem("Issue Date", "Apr 7, 2019"),
              SNItem("Maturity Date", "Mar 7, 2019"),
              SNItem("Min Investment", "\$5000 USD"),
              SNItem("How to Buy", "FundSERV CBL2039"),
            ],
          ),
        ),
      );
      _snDataList.add(
        SNData(
          "CIBC Floating Market Rate GICs (3 years) (USD)",
          "Due January 11, 2011",
          new List.of(
            [
              SNItem("FundSERV", "CBL2039"),
              SNItem("Avail Until", "Mar 3, 2019"),
              SNItem("Term", "3"),
              SNItem("Issue Date", "Apr 7, 2019"),
              SNItem("Maturity Date", "Mar 7, 2019"),
              SNItem("Min Investment", "\$5000 USD"),
              SNItem("How to Buy", "FundSERV CBL2039"),
            ],
          ),
        ),
      );
    }*/
    //_snDataList.shuffle();

    return _snDataList;
  }
}

enum SelectedCategory { MLCIs, PPNs, PARs }

/*class OfferingList extends StatefulWidget {
  final Function(List<SNData>) onCompareItemsSelected;

  // final List<SNData> offeringsList;

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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            padding: const EdgeInsets.all(8.0),
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
                        children: _getOfferingItemList(inheritedWidget
                            .offeringDataList[index].SNItem),
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

  List<Widget> _getOfferingItemList(List<SNData> offeringItems) {
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