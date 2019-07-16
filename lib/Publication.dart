import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:structured_notes/util/Theme.dart';

class Publication extends StatefulWidget {
  @override
  _PublicationState createState() => _PublicationState();
}

class _PublicationState extends State<Publication>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;
  List<String> _products = [];
  List<String> _details = [];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);

    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");
    _products.add("The WisdomTree Siegel Strategic\n Value Index");

    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
    _details.add(
        "Acces a distinct blend of performing \n equities reguardless of market conditions.");
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


                    Container(
                      //elevation:5,
                      //color: white,
                      margin: EdgeInsets.only( left: 8.0, right: 8.0, bottom: 8.0, ),
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

                      //shadowColor: Colors.black45,
                      child: Container(
                        color: white,
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
                                          ),
                                          textAlign: TextAlign.center,
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
                          ],
                        ),
                      ),
                    ),

                    /*new CategoryWidget(
                      onCategorySelected: _onCategorySelected,
                    ),*/
                    /* Material(
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white,))),
                                    //style: BorderStyle.solid))),
                        child:  CategoryWidget() */

                    Expanded(child: Products(_products, _details))

                    /*Row(
                          children: <Widget>[
                            Expanded(
                                child: Card(
                                  color: accentTextColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5,
                                )),
                          ],
                        ),*/ /*
                      ),
                    ),*/

                    /*Expanded(
                      */ /*child: OfferingList(
                       // onCompareItemsSelected: _onComapareItemsSelected,
                      ),*/ /*
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

class Products extends StatelessWidget {
  final List<String> products;
  final List<String> details;

  Products(this.products, this.details);

  Widget _buildProductItem(BuildContext context, int index) {
    return new Container(margin: EdgeInsets.only(bottom: 7),
        decoration: BoxDecoration( shape: BoxShape.rectangle, boxShadow: [BoxShadow( color: Colors.grey.withOpacity(0.07), blurRadius: 5.0, ),] ),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 0.8,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: Image.asset('assets/images/pub_img.png',
                      width: 160, height: 125, fit: BoxFit.cover)),
              SizedBox(
                width: 20.0,
              ),
              Column(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(products[index],
                        style: TextStyle(
                            color: accentTextColor,
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  Text(details[index],
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 7.0),
                      textAlign: TextAlign.center)
                ],
              ),
            ],
          ),
        ),
        /*onTap: () {}*/
    );

    /*return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0.8,
      child: Row( //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: Image.asset('assets/images/pub_img.png',
                  width: 160, height: 125, fit: BoxFit.cover)),
          SizedBox(
            width: 20.0,
          ),
          Column(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(products[index],
                    style: TextStyle(
                        color: accentTextColor,
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Text(details[index],
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 7.0),
                  textAlign: TextAlign.center)
            ],
          ),
        ],
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
      shrinkWrap: true,
      itemBuilder: _buildProductItem,
      itemCount: 10,
    );
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
    return new GridView.count(
      //physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
      shrinkWrap: true,
      crossAxisCount: 1,
      crossAxisSpacing: 4,
      children: <Widget>[
        new Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
                  new Image(
                    image: AssetImage('assets/images/pub_img.png'),
                    width: 170.0,
                    height: 162.0,
                    fit: BoxFit.fill,
                  ),
                  /*SizedBox(
                    height: 8,
                  )*/
                ],
              ),
            ),
          ),
        ),
        /*new Card(
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
                  new Image(image: AssetImage('assets/images/pub_img.png'),width: 170.0,
                    height: 162.0,
                    fit: BoxFit.fill,),
                  */ /*SizedBox(
                    height: 8,
                  )*/ /*
                ],
              ),
            ),
          ),
        ),*/
        /*new Card(
          */ /*color: currentOfferingsInheritedWidget.selectedCategory ==
              SelectedCategory.PPNs
              ? accentColor
              : Colors.white,*/ /*
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
                        */ /*currentOfferingsInheritedWidget.selectedCategory ==
                            SelectedCategory.PPNs
                            ? white
                            : accentTextColor*/ /*),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  new Text(
                    'Principle Protected Notes',
                    style: new TextStyle(
                       */ /* color:
                        currentOfferingsInheritedWidget.selectedCategory ==
                            SelectedCategory.PPNs
                            ? secondaryWhiteTextColor
                            : secondaryTextColor*/ /*),
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
