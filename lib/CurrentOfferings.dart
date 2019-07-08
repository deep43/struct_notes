import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structured_notes/util/Theme.dart';

import 'ComaprePage.dart';
import 'model/OfferingsData.dart';

class CurrentOfferings extends StatefulWidget {
  @override
  _CurrentOfferingsState createState() => _CurrentOfferingsState();
}

class _CurrentOfferingsState extends State<CurrentOfferings>
    with SingleTickerProviderStateMixin {
  List<OfferingsData> _compareItems = new List();

  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

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
          child: FloatingActionButton.extended(
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
              label: Text('Compare')),
        ),
      ),
      body: Stack(
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
                  new CategoryWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  SizedBox(
                    height: 10,
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
    );
    ;
  }

  _onComapareItemsSelected(List<OfferingsData> items) {
    if (items.length > 1) {
      controller.forward();
    } else {
      controller.reverse();
    }

    setState(() {
      this._compareItems = items;
    });
  }
}

enum SelectedCategory { MLCIs, PPNs, PARs }

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    Key key,
  }) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  SelectedCategory _selectedCategory = SelectedCategory.MLCIs;

  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 30, bottom: 10, left: 8, right: 8),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 4,
      children: <Widget>[
        new Card(
          color: _selectedCategory == SelectedCategory.MLCIs
              ? accentColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedCategory = SelectedCategory.MLCIs;
              });
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
                        color: _selectedCategory == SelectedCategory.MLCIs
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
                        color: _selectedCategory == SelectedCategory.MLCIs
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
          color: _selectedCategory == SelectedCategory.PPNs
              ? accentColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedCategory = SelectedCategory.PPNs;
              });
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
                        color: _selectedCategory == SelectedCategory.PPNs
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
                        color: _selectedCategory == SelectedCategory.PPNs
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
          color: _selectedCategory == SelectedCategory.PARs
              ? accentColor
              : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedCategory = SelectedCategory.PARs;
              });
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
                        color: _selectedCategory == SelectedCategory.PARs
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
                        color: _selectedCategory == SelectedCategory.PARs
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
  Function(List<OfferingsData>) onCompareItemsSelected;

  OfferingList({this.onCompareItemsSelected});

  @override
  _OfferingListState createState() => _OfferingListState();
}

class _OfferingListState extends State<OfferingList> {
  List<OfferingsData> _offeringsList = new List();

  List<OfferingsData> _selectedOfferings = new List();

  @override
  void initState() {
    _offeringsList = getDummyOfferingsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExpandablePanel(
                hasIcon: false,
                header: Container(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_offeringsList[index].title),
                          Text(_offeringsList[index].time),
                        ],
                      )),
                      InkWell(
                        onTap: () {
                          if (_selectedOfferings
                              .contains(_offeringsList[index])) {
                            _selectedOfferings.remove(_offeringsList[index]);
                          } else {
                            _selectedOfferings.add(_offeringsList[index]);
                          }
                          widget.onCompareItemsSelected(_selectedOfferings);
                          setState(() {});
                        },
                        child: Container(
                          constraints: BoxConstraints(),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _selectedOfferings
                                      .contains(_offeringsList[index])
                                  ? accentColor
                                  : Colors.transparent,
                              border: Border.all(color: accentColor)),
                          padding: const EdgeInsets.all(6),
                          child:
                              _selectedOfferings.contains(_offeringsList[index])
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
                          _offeringsList[index].offeringItems),
                    ),
                  ),
                )),
            Text(
              "...",
              style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )
          ],
        );
      },
      itemCount: _offeringsList.length,
    );
  }

  List<OfferingsData> getDummyOfferingsData() {
    List<OfferingsData> _offeringsList = new List();
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

    return _offeringsList;
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
