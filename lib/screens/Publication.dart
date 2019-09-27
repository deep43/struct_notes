import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:structured_notes/data_providers/DataProvider.dart';
import 'package:structured_notes/util/Theme.dart';
import '../data_providers/DataProviderInterface.dart';
import '../model/PublicationData.dart';
import '../model/SNPublicationData.dart';

final DataProviderInterface _dataProvider = DataProvider().getDataProvider();

class Publication extends StatefulWidget {
  @override
  _PublicationState createState() => _PublicationState();
}

class _PublicationState extends State<Publication>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  //List<PublicationData> _mPublicationList = getPopulatedStaticData();
  List<SNPublicationData> _mPublicationList = new List<SNPublicationData>();

  int get count => _mPublicationList.length;

  @override
  void initState() {
    super.initState();
    getPublicationData();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    offset = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
    // _mPublicationList = getPopulatedStaticData(); // this method will populate publication 's dummy data at run time
  }

  void load() {
    print("load");
    /*setState(() {
      _mPublicationList.addAll(getPopulatedStaticData());
    });*/
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
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 5, left: 10, right: 10),
                          shrinkWrap: true,
                          itemBuilder: _buildProductItem,
                          // this item builder build layout of each item
                          itemCount: _mPublicationList.length,
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
                borderRadius: new BorderRadius.all(Radius.circular(7.0)),
                child: Image.asset( 'assets/images/cbimage.jpg',
                    width: 102, height: 103, fit: BoxFit.fill)),
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
          Text("Where income, growth and capital preservation are on your terms ",
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
                  fontSize: 11.0),
              textAlign: TextAlign.center),
          SizedBox(
            height: 2.0,
          ),
          Text(_mPublicationList[index].effectiveDate,
              style: TextStyle(
                  fontFamily: 'Whitney-Light-Pro.otf',
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 9.0),
              textAlign: TextAlign.center),
        ],
      );

  void getPublicationData() async {
    try {

      await _dataProvider.getPublicationJson().then(processComparedata);
    } catch (e) {
      print('debuggg111111333333 calling getPublicationData() - error: ' +
          e.toString());
    }
  }

  Future processComparedata(String value) {

    List<SNPublicationData> _snpublicationdata = new List<SNPublicationData>();

    _snpublicationdata = List<SNPublicationData>.from(
        json.decode(value).map((x) => SNPublicationData.fromJson(x)));
    print("title: " + _snpublicationdata[1].title + "\n");

    setState(() {
      _mPublicationList.clear();
      _mPublicationList = _snpublicationdata;
    });
  }

  /*Uint8List setImageData(index) {
    List<int> imageBytes = File(_mPublicationList[index].thumbnailImg).openRead();
    String imageB64 = base64Encode(imageBytes);
    Uint8List decoded = base64Decode(imageB64);

    Uint8List _base64;
    _base64 = base64Decode(_mPublicationList[index].thumbnailImg.replaceRange(0, 26, ""));

   return decoded;
    //base64Decode(base64Encode(_mPublicationList[index].thumbnailImg.replaceRange(0, 26, "")
  }*/
}

/*List<PublicationData> getPopulatedStaticData() {
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
}*/

/*class Products extends StatelessWidget {
  final List<PublicationData> myPublicationData;

  Products(this.myPublicationData);

  Widget _buildProductItem(BuildContext context, int index) {
    return new Container(
        margin: EdgeInsets.only(bottom: 11.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
            */ /*boxShadow: [
        */ /* */ /*BoxShadow(
          color: Colors.grey.withOpacity(0.07),
          blurRadius: 5.0,
        ),*/ /* */ /*
      ]*/ /*

            borderRadius: BorderRadius.circular(8.0)),
        child:
            */ /*Card(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        //elevation: 0.8,
        child:*/ /*
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
}*/
