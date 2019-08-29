import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structured_notes/model/OfferingsData.dart';
import 'Theme.dart';

List<SNData> mlistData = new List();

class SNListWidget extends StatefulWidget {
  final bool isItemSelectable;
  final Function(List<SNData> _comaringItemList) onItemSelect;
  final List<SNData> listData;

  const SNListWidget(
      {Key key, this.isItemSelectable, this.onItemSelect, this.listData})
      : super(key: key);

  @override
  _SNListWidgetState createState() => _SNListWidgetState();
}

class _SNListWidgetState extends State<SNListWidget>
    with SingleTickerProviderStateMixin {
  //bool isItemSelectable = false;
 // final Function(List<SNData> _comaringItemList) onItemSelect;
  //List<SNData> listData = new List();
  List<SNData> _comaringItemList = new List();
  AnimationController subCategoryItemEntranceAnimationController;
  List<Animation> subCategoryItemAnimations;
  //List<SNData> oldListData = new List();

  //_SNListWidgetState({this.isItemSelectable, this.onItemSelect, this.listData});

  @override
  void initState() {
    subCategoryItemEntranceAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    subCategoryItemEntranceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
        padding: EdgeInsets.only(top: 5.0),
        separatorBuilder: _mSeparatorBuilder,
        itemBuilder: _mItemBuilder,
        itemCount: widget.listData.length);
  }

  Widget _mSeparatorBuilder(context, int) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Divider(
        height: 2.0,
        color: accentColor,
      ),
    );
  }

  Widget _mItemBuilder(BuildContext context, int index) {
    subCategoryItemAnimations = widget.listData.map((subCat) {
      int index = widget.listData.indexOf(subCat);
      double start = index * 0.1;
      double duration = 0.6;
      double end = duration + start >= 1 ? 1.0 : duration + start;
      return new Tween<double>(begin: 400.0, end: 0.0).animate(
          new CurvedAnimation(
              parent: subCategoryItemEntranceAnimationController,
              curve: new Interval(start, end, curve: Curves.decelerate)));
    }).toList();

    /* if (inheritedWidget.offeringDataList != _offeringsItemList) {
      subCategoryItemEntranceAnimationController.reset();
      _offeringsItemList = inheritedWidget.offeringDataList;
      _comaringItemList = inheritedWidget.comapringDataList;

      subCategoryItemEntranceAnimationController.forward();
    }*/

    /*if (oldListData != this.listData) {
      oldListData = this.listData;
      subCategoryItemEntranceAnimationController.reset();
    }*/
   // subCategoryItemEntranceAnimationController.reset();
    subCategoryItemEntranceAnimationController.forward();
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: AnimatedBuilder(
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
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: Text(
                              widget.listData[index].title,
                              style: TextStyle(
                                fontFamily: 'Whitney-Light-Pro.otf',
                                fontSize: 14.0,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(widget.listData[index].time),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
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
                            ),
                          )
                        ],
                      )),
                      InkWell(
                          onTap: () {
                            if (_comaringItemList
                                .contains(widget.listData[index])) {
                              _comaringItemList.remove(widget.listData[index]);
                            } else {
                              _comaringItemList.add(widget.listData[index]);
                            }
                            widget.onItemSelect(_comaringItemList);
                            // widget.onCompareItemsSelected(_comaringItemList);
                            //setState(() {});
                          },
                          child: widget.isItemSelectable
                              ? Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Container(
                                    constraints: BoxConstraints(),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _comaringItemList
                                                .contains(widget.listData[index])
                                            ? accentColor
                                            : Colors.transparent,
                                        border: Border.all(color: accentColor)),
                                    padding: const EdgeInsets.all(6),
                                    child: _comaringItemList
                                            .contains(widget.listData[index])
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
                              : SizedBox(height: 4, width: 4))
                    ],
                  ),
                ),
                expanded: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: _getItemList(widget.listData[index].snItems),
                    ),
                  ),
                )),
            SizedBox(
              height: 2,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _getItemList(List<SNItem> snItems) {
    List<Column> items = new List();
    snItems.forEach((item) {
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

  /*onSnItemSelect(_comaringItemList) {
    if (!isItemSelectable) {
      return;
    }*/

    // 1. populate selected list
    //2. onItemSelect(selectedItemList)
  //}

}
