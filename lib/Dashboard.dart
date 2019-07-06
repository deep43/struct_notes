import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter_svg/svg.dart';
import 'package:structured_notes/util/Theme.dart';
import 'HomePage.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  final menu = new Menu(
    items: [
      new MenuItem(
        id: '1',
        title: 'Home',
      ),
      new MenuItem(
        id: '2',
        title: 'Current Offerings',
      ),
      new MenuItem(
        id: '3',
        title: 'Previously Issued',
      ),
      new MenuItem(
        id: '4',
        title: 'Education Center',
      ),
      new MenuItem(
        id: '5',
        title: 'Publications',
      ),
    ],
  );

  final _contentViews = [HomePage()];
  var selectedMenuItemId = '1';

  DrawerScaffoldController _controller;

  @override
  void initState() {
    _controller = DrawerScaffoldController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new DrawerScaffold(
      cornerRadius: 0,
      showAppBar: false,
      appBar: AppBarProps(
        elevation: 0,
        title: Container(
          child: Row(
            children: <Widget>[
              IconButton(
                  padding: const EdgeInsets.only(bottom: 4, right: 8, top: 4),
                  icon: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset('assets/images/side_menu.svg')),
                  onPressed: () {
                    _controller.menuController.toggle();
                  }),
              Expanded(child: Text('CIBC Structured Notes'))
            ],
          ),
        ),
        actions: [
          IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(Icons.search),
              onPressed: () {}),
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      controller: _controller,
      menuView: new MenuView(
        alignment: Alignment.topCenter,
        menu: menu,
        headerView: headerView(context),
        animation: false,
        color: Colors.white,
        selectedItemId: selectedMenuItemId,
        textStyle: TextStyle(
          fontSize: 20,
        ),
        selectorColor: accentColor,
        onMenuItemSelected: (String itemId) {
          selectedMenuItemId = itemId;
          if (itemId == 'restaurant') {
            //setState(() => _widget = Text("1"));
          } else {
            //  setState(() => _widget = Text("default"));
          }
        },
        footerView: footerView(),
      ),
      contentView: Screen(
        contentBuilder: (context) => Stack(
          children: <Widget>[
            _contentViews[0],
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    RawMaterialButton(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child:
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset('assets/images/side_menu.svg'),
                              )),
                      onPressed: () {
                        _controller.menuController.toggle();
                      },
                      shape: new CircleBorder(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Expanded(
                      child: Text(
                        'CIBS Structured Notes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    RawMaterialButton(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 26,
                        ),
                        shape: new CircleBorder(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {})
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerView(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 20, top: 100, right: 160, bottom: 40),
      width: MediaQuery.of(context).size.width * .5,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: accentColor, width: 1),
            gapPadding: 0,
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: accentColor, width: 1),
            borderRadius: BorderRadius.circular(50),
          ),
          hintText: 'Search',
        ),
      ),
    );
  }

  Widget footerView() {
    return Padding(
      padding: const EdgeInsets.only(right: 150, bottom: 100),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: accentColor,
            onPressed: () {},
            child: Text(
              'Log In',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
