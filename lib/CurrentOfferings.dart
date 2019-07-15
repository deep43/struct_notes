import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structured_notes/util/Theme.dart';

import 'ComaprePage.dart';
import 'model/OfferingsData.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration.dart';

enum SelectedCategory { MLCIs, PPNs, PARs }

class CurrentOfferings extends StatefulWidget {
  final int selectedCategoryPosition;

  CurrentOfferings({this.selectedCategoryPosition});

  @override
  _CurrentOfferingsState createState() => _CurrentOfferingsState(
      selectedCategoryPosition: selectedCategoryPosition);
}

class _CurrentOfferingsState extends State<CurrentOfferings>
    with SingleTickerProviderStateMixin {
  final int selectedCategoryPosition;

  _CurrentOfferingsState({this.selectedCategoryPosition});

  List<OfferingsData> _compareItems = new List();
  List<OfferingsData> offeringItems = new List();
  SelectedCategory _selectedCategory;
  AnimationController controller;
  Animation<Offset> offset;

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
    offeringItems = getDummyOfferingsData();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
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
        offeringDataList: offeringItems,
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
                    AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    new CategoryWidget(
                      onCategorySelected: _onCategorySelected,
                    ),
                    Material(
                      color: white,
                      elevation: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black12,
                                    style: BorderStyle.solid))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20,vertical: 10 ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Product Name',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                'Compare',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: OfferingList(
                        onCompareItemsSelected: _onComapareItemsSelected,
                      ),
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

  _onComapareItemsSelected(List<OfferingsData> items) {
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
      offeringItems = getDummyOfferingsData();
    });
  }

  List<OfferingsData> getDummyOfferingsData() {
    List<OfferingsData> _offeringsList = new List();

    for (int i = 0; i < 3; i++) {
      _offeringsList.add(
        OfferingsData(
          "CIBC Floating Market Rate GICs (3 years) (USD)",
          "Due January 11, 2011",
          new List.of(
            [
              OfferingItem("FundSERV", "CBL2039"),
              OfferingItem("Avail Until", "Mar 3, 2019"),
              OfferingItem("Term", "3"),
              OfferingItem("Issue Date", "Apr 7, 2019"),
              OfferingItem("Maturity Date", "Mar 7, 2019"),
              OfferingItem("Min Investment", "\$5000 USD"),
              OfferingItem("How to Buy", "FundSERV CBL2039"),
            ],
          ),
        ),
      );
      _offeringsList.add(
        OfferingsData(
          "CIBC Floating Market Rate GICs (2 years) (USD)",
          "Due January 11, 2011",
          new List.of(
            [
              OfferingItem("FundSERV", "CBL2039"),
              OfferingItem("Avail Until", "Mar 3, 2019"),
              OfferingItem("Term", "3"),
              OfferingItem("Issue Date", "Apr 7, 2019"),
              OfferingItem("Maturity Date", "Mar 7, 2019"),
              OfferingItem("Min Investment", "\$5000 USD"),
              OfferingItem("How to Buy", "FundSERV CBL2039"),
            ],
          ),
        ),
      );
      _offeringsList.add(
        OfferingsData(
          "CIBC Floating Market Rate GICs (3 years) (USD)",
          "Due January 11, 2011",
          new List.of(
            [
              OfferingItem("FundSERV", "CBL2039"),
              OfferingItem("Avail Until", "Mar 3, 2019"),
              OfferingItem("Term", "3"),
              OfferingItem("Issue Date", "Apr 7, 2019"),
              OfferingItem("Maturity Date", "Mar 7, 2019"),
              OfferingItem("Min Investment", "\$5000 USD"),
              OfferingItem("How to Buy", "FundSERV CBL2039"),
            ],
          ),
        ),
      );
    }

    _offeringsList.shuffle();
    return _offeringsList;
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
                Vibration.vibrate(duration: 30);
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
                Vibration.vibrate(duration: 30);
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
                Vibration.vibrate(duration: 30);
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

class OfferingList extends StatefulWidget {
  final Function(List<OfferingsData>) onCompareItemsSelected;

  // final List<OfferingsData> offeringsList;

  OfferingList({this.onCompareItemsSelected});

  @override
  _OfferingListState createState() => _OfferingListState();
}

class _OfferingListState extends State<OfferingList>
    with SingleTickerProviderStateMixin {
  List<OfferingsData> _offeringsItemList = new List();
  List<OfferingsData> _comaringItemList = new List();
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
                            SizedBox(height: 15,),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 5,
                                  width: 5,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                           accentColor,

                                      border: Border.all(
                                          color: accentColor,),),
                                ),
                                SizedBox(width: 3,),
                                Container(
                                  height: 5,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                    accentColor,

                                    border: Border.all(
                                      color: accentColor,),),
                                ),
                                SizedBox(width: 3,),
                                Container(
                                  height: 5,
                                  width: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                    accentColor,

                                    border: Border.all(
                                      color: accentColor,),),
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
                            .offeringDataList[index].offeringItems),
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

  void _buildAnimationList(List<OfferingsData> offeringDataList) {
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

  List<Widget> _getOfferingItemList(List<OfferingItem> offeringItems) {
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
}

class CurrentOfferingsInheritedWidget extends InheritedWidget {
  final SelectedCategory selectedCategory;
  final List<OfferingsData> offeringDataList;
  final List<OfferingsData> comapringDataList;

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
