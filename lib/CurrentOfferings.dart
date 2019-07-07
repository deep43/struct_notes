import 'package:flutter/material.dart';
import 'package:structured_notes/util/Theme.dart';

class CurrentOfferings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                )
              ],
            ),
          ),
        ),
      ],
    );
    ;
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
                        fontFamily: 'Whitney-Semibld-Pro',
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
                        fontFamily: 'Whitney-Semibld-Pro',
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
                        fontFamily: 'Whitney-Semibld-Pro',
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
