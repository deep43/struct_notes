import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
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
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: CategoryWidget()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
  List<PublicationData> _list = new List();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      _list.add(PublicationData(
          imageAsset: 'assets/images/pub_img.png',
          title: 'The Wisdom Tree Siegel Strategic Value Index',
          description:
              'Access a distinct blend of preforming equities regardless of market conditions.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[400],width: .5),borderRadius: BorderRadius.circular(5),),
          elevation: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 120,
                width: 150,
                child: Image.asset(
                  _list[index].imageAsset,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        _list[index].title,
                        style: TextStyle(color: accentColor, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5,),
                      Text(_list[index].description,style: TextStyle(fontSize: 12),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),

            ],
          ),
        );
      },
      itemCount: _list.length,
    );
  }
}
