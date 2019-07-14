import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:structured_notes/util/Theme.dart';

class Publication extends StatefulWidget {
  @override
  _PublicationState createState() => _PublicationState();
}

class _PublicationState extends State<Publication> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Card(
                        color: accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        elevation: 6,
                        child: InkWell(
                          onTap: () {
                            //widget.onCategorySelected(SelectedCategory.MLCIs);
                          },
                          child: new Container(
                            padding: const EdgeInsets.only(
                                top: 45, bottom: 65, left: 30, right: 30),
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Text(
                                  'A wealth of information at your fingertips',
                                  style: new TextStyle(
                                    fontSize: 24.0,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w700,
                                    color: white,
                                  ), textAlign: TextAlign.center,
                                ),
                                /* SizedBox(
                                  height: 5,
                                ),
                                new Text(
                                  'Market Linked GICs',
                                  style: new TextStyle(
                                      color: currentOfferingsInheritedWidget
                                                  .selectedCategory ==
                                              SelectedCategory.MLCIs
                                          ? secondaryWhiteTextColor
                                          : secondaryTextColor),
                                  textAlign: TextAlign.center,
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*new CategoryWidget(
                      onCategorySelected: _onCategorySelected,
                    ),*/
                    Material(
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white,))),
                                    //style: BorderStyle.solid))),
                        child:  CategoryWidget() /*Row(
                          children: <Widget>[
                            Expanded(
                                child: Card(
                                  color: accentTextColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5,
                                )),
                          ],
                        ),*/
                      ),
                    ),
                    /*Expanded(
                      *//*child: OfferingList(
                       // onCompareItemsSelected: _onComapareItemsSelected,
                      ),*//*
                    ),*/
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

/* _onComapareItemsSelected(List<OfferingsData> items) {
    if (items.length > 1) {
      controller.forward();
    } else if (items.length != 0) {
      controller.reverse();
    }
    setState(() {
      this._compareItems = items;
    });
  }
*/

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

    return new GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 4,
      children: <Widget>[
        new Card(
          //shape:
          //RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 3,
          child: InkWell(
            onTap: () {
              //widget.onCategorySelected(SelectedCategory.MLCIs);
            },
            child: new Container(
              //padding: const EdgeInsets.all(0),
              child: new Column(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image(image: AssetImage('assets/images/pub_img.png')),
                  /*SizedBox(
                    height: 8,
                  )*/
                ],
              ),
            ),
          ),
        ),
        new Card(
          //shape:
          //RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 3,
          child: InkWell(
            onTap: () {
              //widget.onCategorySelected(SelectedCategory.MLCIs);
            },
            child: new Container(
              //padding: const EdgeInsets.all(0),
              child: new Column(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image(image: AssetImage('assets/images/pub_img.png')),
                  /*SizedBox(
                    height: 8,
                  )*/
                ],
              ),
            ),
          ),
        ),
        /*new Card(
          *//*color: currentOfferingsInheritedWidget.selectedCategory ==
              SelectedCategory.PPNs
              ? accentColor
              : Colors.white,*//*
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 6,
          child: InkWell(
            onTap: () {
             // widget.onCategorySelected(SelectedCategory.PPNs);
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
                        //color:
                        *//*currentOfferingsInheritedWidget.selectedCategory ==
                            SelectedCategory.PPNs
                            ? white
                            : accentTextColor*//*),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    'Principle Protected Notes',
                    style: new TextStyle(
                       *//* color:
                        currentOfferingsInheritedWidget.selectedCategory ==
                            SelectedCategory.PPNs
                            ? secondaryWhiteTextColor
                            : secondaryTextColor*//*),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),*/
      ],
    );
  }
}


