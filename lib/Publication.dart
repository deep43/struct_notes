import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
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
  List<PublicationData> _mPublicationList = getPopulatedStaticData();

  int get count => _mPublicationList.length;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
    // _mPublicationList = getPopulatedStaticData(); // this method will populate publication 's dummy data at run time
  }

  void load() {
    print("load");
    setState(() {
      _mPublicationList.addAll(getPopulatedStaticData());
    });
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    _mPublicationList.clear();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
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
                                  padding: const EdgeInsets.all(7.5),
                                  child: new Card(
                                    color: accentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
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
                                                fontFamily:
                                                    'Whitney-Light-Pro.otf',
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
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          child: LoadMore(
                            isFinish: count >= 60,
                            onLoadMore: _loadMore,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 5, left: 10, right: 10),
                              shrinkWrap: true,
                              itemBuilder: _buildProductItem,
                              // this item builder build layout of each item
                              itemCount: _mPublicationList.length,
                            ),
                            whenEmptyLoad: false,
                            delegate: DefaultLoadMoreDelegate(),
                            textBuilder: DefaultLoadMoreTextBuilder.english,
                          ),
                          onRefresh: _refresh,
                        ),
                      ) // this widget will populate the list of items
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return new Container(
        margin: EdgeInsets.only(bottom: 11.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
            /*boxShadow: [
        */ /*BoxShadow(
          color: Colors.grey.withOpacity(0.07),
          blurRadius: 5.0,
        ),*/ /*
      ]*/

            borderRadius: BorderRadius.circular(8.0)),
        child:
            /*Card(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        //elevation: 0.8,
        child:*/
            Row(
          crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ClipRRect(
                borderRadius: new BorderRadius.only(
                    bottomLeft: Radius.circular(7.0),
                    topLeft: Radius.circular(7.0)),
                child: Image.asset(_mPublicationList[index].imageAsset,
                    width: 120, height: 100, fit: BoxFit.cover)),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.topCenter,
                    child: textWidget(index))),
          ],
        ));
  }

  Widget textWidget(index) => Column(
        textBaseline: TextBaseline.ideographic,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_mPublicationList[index].headline,
              style: TextStyle(
                  fontFamily: 'Whitney-Black-Pro.otf',
                  color: accentTextColor,
                  fontSize: 11.4,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center),
          SizedBox(
            height: 10.0,
          ),
          Text(_mPublicationList[index].title,
              style: TextStyle(
                  fontFamily: 'Whitney-Light-Pro.otf',
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 9.0),
              textAlign: TextAlign.center),
          SizedBox(
            height: 2.0,
          ),
          Text(_mPublicationList[index].description,
              style: TextStyle(
                  fontFamily: 'Whitney-Light-Pro.otf',
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 7.0),
              textAlign: TextAlign.center),
        ],
      );
}

List<PublicationData> getPopulatedStaticData() {
  // List<PublicationData> mData = new List();
  var mData = new List<PublicationData>();
  for (int i = 0; i < 10; i++) {
    mData.add(PublicationData(
        "assets/images/pub_img.png",
        "Where income, Growth and capital\n preservation arer on your items.",
        "CIBC Structured Notes",
        "Customized investment solution tailored to meet\n your unique requirements.\n investment startegy and goals."));
  }

  return mData;
}

class Products extends StatelessWidget {
  final List<PublicationData> myPublicationData;

  Products(this.myPublicationData);

  Widget _buildProductItem(BuildContext context, int index) {
    return new Container(
        margin: EdgeInsets.only(bottom: 11.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
            /*boxShadow: [
        */ /*BoxShadow(
          color: Colors.grey.withOpacity(0.07),
          blurRadius: 5.0,
        ),*/ /*
      ]*/

            borderRadius: BorderRadius.circular(8.0)),
        child:
            /*Card(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        //elevation: 0.8,
        child:*/
            Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ClipRRect(
                borderRadius: new BorderRadius.only(
                    bottomLeft: Radius.circular(7.0),
                    topLeft: Radius.circular(7.0)),
                child: Image.asset(myPublicationData[index].imageAsset,
                    width: 155, height: 125, fit: BoxFit.cover)),
            Column(
              textBaseline: TextBaseline.ideographic,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: textWidget(index), // list text's appear widget
                ),
              ],
            )
          ],
        ));
  }

  Widget textWidget(index) => Column(
        textBaseline: TextBaseline.ideographic,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(myPublicationData[index].headline,
              style: TextStyle(
                  fontFamily: 'Whitney-Black-Pro.otf',
                  color: accentTextColor,
                  fontSize: 11.4,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center),
          SizedBox(
            height: 10.0,
          ),
          Text(myPublicationData[index].title,
              style: TextStyle(
                  fontFamily: 'Whitney-Light-Pro.otf',
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 9.0),
              textAlign: TextAlign.center),
          SizedBox(
            height: 2.0,
          ),
          Text(myPublicationData[index].description,
              style: TextStyle(
                  fontFamily: 'Whitney-Light-Pro.otf',
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 7.0),
              textAlign: TextAlign.center),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      shrinkWrap: true,
      itemBuilder: _buildProductItem,
      // this item builder build layout of each item
      itemCount: myPublicationData.length,
    );
  }
}
