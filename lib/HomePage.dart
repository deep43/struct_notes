import 'package:flutter/material.dart';
import 'package:structured_notes/util/Theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              image: new DecorationImage(
                image: new AssetImage("assets/images/back.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
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
                      Align(
                        alignment: Alignment.topCenter,
                        child: new Text(
                          'Register Today',
                          style: new TextStyle(
                              fontFamily: 'Whitney',
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                      ),

                      new Padding(padding: EdgeInsets.only(top: 8.0)),

                      new Text(
                        "Increase your return\n potential. Not your risk.",
                        style: new TextStyle(
                            height: 1.2,
                            fontFamily: 'Whitney',
                            fontSize: 23.0,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),

                      new GridView.count(
                        padding: const EdgeInsets.only(top: 30, bottom: 10,left: 8,right: 8),
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        children: <Widget>[
                          new InkWell(
                            onTap: () {},
                            child: new Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              elevation: 4.0,
                              child: InkWell(
                                onTap: () {},
                                child: new Container(
                                  padding: const EdgeInsets.all(6),
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        'MLCICs',
                                        style: new TextStyle(
                                            fontFamily: 'Whitney-Semibld-Pro',
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
                          ),
                          new InkWell(
                            onTap: () {},
                            child: new Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              elevation: 4.0,
                              child: InkWell(
                                onTap: () {},
                                child: new Container(
                                  padding: const EdgeInsets.all(6),
                                  child: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Text(
                                        'PPNs',
                                        style: new TextStyle(
                                            fontFamily: 'Whitney-Semibld-Pro',
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
                          ),
                          new Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            elevation: 4.0,
                            child: InkWell(
                              onTap: () {},
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
                                          fontFamily: 'Whitney-Semibld-Pro',
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

                      new ImageSliderWidget(),
                      // below headng
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ImageSliderWidget extends StatefulWidget {
  const ImageSliderWidget({
    Key key,
  }) : super(key: key);

  @override
  _ImageSliderWidgetState createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int _current = 0;

  List imgList = [
    'https://notes.cibc.com/assets/images/noteworthy.jpg',
    'https://notes.cibc.com/assets/images/second.jpg',
    'https://notes.cibc.com/assets/images/find.jpg',
    'https://notes.cibc.com/assets/images/nutshell2.jpg',
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
            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(10.0),
                        color: Colors.grey,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(imgList, (index, url) {
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
