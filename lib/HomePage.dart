import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structured_notes/util/Theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:structured_notes/util/WaveAnimationWidget.dart';

import 'VIdeoPage.dart';
import 'model/AppliedFilterData.dart';
import 'model/ImageSliderData.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  static AppliedFilterData appliedFilterData = AppliedFilterData();

  Function(int selectedCategory,int selectedPage)onCategorySelectedFromHomePage;
  HomePage({this.onCategorySelectedFromHomePage});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/back.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(child: Container(child: WaveAnimationWidget(isHightWave: false,))),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(
                    child: new ListView(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      children: <Widget>[
                        Theme.of(context).platform == TargetPlatform.android
                            ? SizedBox(
                                height: 20,
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/images/lace.svg',
                                color: Colors.white,
                                width: 15,
                                height: 15,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              new Text(
                                'Register Today',
                                style: new TextStyle(
                                    fontSize: 14.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ),

                        new Padding(padding: EdgeInsets.only(top: 8.0)),

                        new Text(
                          "Increase your return\n potential. Not your risk.",
                          style: new TextStyle(
                              height: 1.2, fontSize: 23.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),

                        new GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 30,left: 8, right: 8,bottom: 10),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          children: <Widget>[
                            new Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              elevation: 6,
                              child: InkWell(
                                onTap: () async {
                                  Vibration.hasVibrator().then((hasVibrator) {
                                    Vibration.vibrate(duration: 30);
                                  });

                                  widget.onCategorySelectedFromHomePage(1,2);

//                                  await Navigator.of(context).push(
//                                      MaterialPageRoute(
//                                          builder: (ctx) => VideoPage()));
//                                  SystemChrome.setPreferredOrientations([
//                                    DeviceOrientation.portraitUp,
//                                    DeviceOrientation.portraitDown,
//                                  ]);
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
                                            color: accentTextColor),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      new Text(
                                        'Market Linked GICs',
                                        style: new TextStyle(
                                            color: secondaryTextColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            new Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              elevation: 6,
                              child: InkWell(
                                onTap: () {
                                  Vibration.hasVibrator().then((hasVibrator) {
                                    Vibration.vibrate(duration: 30);
                                  });
                                  widget.onCategorySelectedFromHomePage(2,2);
                                },
                                child: new Container(
                                  padding: const EdgeInsets.all(6),
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        'PPNs',
                                        style: new TextStyle(
                                            fontSize: 22.0,
                                            letterSpacing: 1.6,
                                            fontWeight: FontWeight.w700,
                                            color: accentTextColor),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      new Text(
                                        'Principle Protected Notes',
                                        style: new TextStyle(
                                            color: secondaryTextColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            new Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              elevation: 6,
                              child: InkWell(
                                onTap: () {
                                  Vibration.hasVibrator().then((hasVibrator) {
                                    Vibration.vibrate(duration: 30);
                                  });
                                  widget.onCategorySelectedFromHomePage(3,2);
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
                                            color: accentTextColor),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      new Text(
                                        'Principle At Risk Notes',
                                        style: new TextStyle(
                                            color: secondaryTextColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(padding:const EdgeInsets.symmetric(horizontal: 30),
                        child: Text('Find out more about how you can increase your return potential',textAlign: TextAlign.center,),),

                        SizedBox(height: 20,),
                        new ImageSliderWidget(onCategorySelectedFromHomePage:widget.onCategorySelectedFromHomePage),
                        // below headng
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageSliderWidget extends StatefulWidget {
  final Function(int selectedCategory,int selectedPage) onCategorySelectedFromHomePage;
  const ImageSliderWidget( {
    this.onCategorySelectedFromHomePage,
    Key key,
  }) : super(key: key);

  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int _current = 0;

  List<ImageSliderData> sliderList = [
    ImageSliderData(
        imageUrl: 'https://notes.cibc.com/assets/images/noteworthy.jpg',
        title: 'choosing product',
        content: 'Let\'s find a product that\'s right for you.'),
    ImageSliderData(
        imageUrl: 'https://notes.cibc.com/assets/images/second.jpg',
        title: 'choosing product Second',
        content: 'Let\'s find a product that\'s right for you.'),
    ImageSliderData(
        imageUrl: 'https://notes.cibc.com/assets/images/find.jpg',
        title: 'choosing product third',
        content: 'Let\'s find a product that\'s right for you.'),
    ImageSliderData(
        imageUrl: 'https://notes.cibc.com/assets/images/nutshell2.jpg',
        title: 'choosing product forth',
        content: 'Let\'s find a product that\'s right for you.'),
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  CarouselSlider carouselSlider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            new Container(
              child: carouselSlider = CarouselSlider(
                initialPage: 0,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
                reverse: false,

                // enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                pauseAutoPlayOnTouch: Duration(seconds: 4),

                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
                items: sliderList.map((data) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 0),
                    child: Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: <Widget>[
                            Card(
                              margin: const EdgeInsets.all(0),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: data.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: InkWell(
                                onTap: (){
                                  if(_current!=3){
                                    widget.onCategorySelectedFromHomePage(1,3);
                                  }else{
                                    widget.onCategorySelectedFromHomePage(1,4);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(color: white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(90),
                                        offset: const Offset(0, 2.5),
                                        blurRadius: 4.0,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Colors.black12, Colors.black26]),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height: 22,
                                                width: 22,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.amberAccent,
                                                    shape: BoxShape.circle),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    (_current + 1).toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              sliderList[_current].title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: white,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          sliderList[_current].content,
                                          style: TextStyle(
                                              fontSize: 28,
                                              color: white,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(sliderList, (index, url) {
            return Container(
              width: 7.0,
              height: 7.0,
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.black : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
