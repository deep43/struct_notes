import 'package:flutter/material.dart';
import 'package:structured_notes/util/Theme.dart';
import 'model/PublicationData.dart';

class Publication extends StatefulWidget {
  @override
  _PublicationState createState() => _PublicationState();
}

class _PublicationState extends State<Publication>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;
  List<PublicationData> _mPublicationList = new List();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
    _mPublicationList = getPopulatedStaticData(); // this method will populate publication 's dummy data at run time
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
                              padding: const EdgeInsets.all(8.0),
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
                                        top: 45,
                                        bottom: 65,
                                        left: 24,
                                        right: 24),
                                    child: new Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text(
                                          'A wealth of information at your fingertips',
                                          style: new TextStyle(
                                            fontFamily: 'Whitney-Light-Pro.otf',
                                            fontSize: 24.0,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w300,
                                            color: white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
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
                    Expanded(child: Products(_mPublicationList)) // this widget will populate the list of items
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

  List<PublicationData> getPopulatedStaticData() {
    List<PublicationData> mData = new List();
    for (int i = 0; i < 15; i++) {
      mData.add(PublicationData(
          "assets/images/pub_img.png",
          "Where income, Growth and capital\n preservation arer on your items.",
          "CIBC Structured Notes",
          "Customized investment solution tailored to meet\n your unique requirements.\n investment startegy and goals."));
    }

    return mData;
  }

}

class Products extends StatelessWidget {
  final List<PublicationData> myPublicationData;

  Products(this.myPublicationData);

  Widget _buildProductItem(BuildContext context, int index) {
    return new Container(
      margin: EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.07),
          blurRadius: 5.0,
        ),
      ]),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0.8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: Image.asset(myPublicationData[index].imageAsset,
                    width: 150, height: 125, fit: BoxFit.cover)),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, top: 15, right: 15.0),
                  child: Text(myPublicationData[index].headline,
                      style: TextStyle(
                          fontFamily: 'Whitney-Black-Pro.otf',
                          color: accentTextColor,
                          fontSize: 10.4,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center),
                ),
                Text(myPublicationData[index].title,
                    style: TextStyle(
                        fontFamily: 'Whitney-Light-Pro.otf',
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 9.0),
                    textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 8.0, bottom: 8),
                  child: Text(myPublicationData[index].description,
                      style: TextStyle(
                          fontFamily: 'Whitney-Light-Pro.otf',
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 7.0),
                      textAlign: TextAlign.center),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
      shrinkWrap: true,
      itemBuilder: _buildProductItem, // this item builder build layout of each item
      itemCount: myPublicationData.length,
    );
  }
}