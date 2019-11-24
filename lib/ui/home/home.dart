import 'dart:ui';

import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:Pasaporte_2020/theme/theme_definition.dart' as theme;
import 'package:Pasaporte_2020/ui/home/widget/carrousel.dart';
import 'package:Pasaporte_2020/ui/home/widget/content_root.dart';
import 'package:Pasaporte_2020/ui/home/widget/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Theme(
            isMaterialAppTheme: true,
            data:theme.getThemeScout(),
        //data: ThemeData(brightness: Brightness.light),
            child: Scaffold(
             backgroundColor: theme.ScHomePage.background,
              body: Flex(direction: Axis.vertical, children: <Widget>[
                Expanded(
                    child: TabBarView(children: [makeHome(context), makeMap()]))
              ]),
              bottomNavigationBar: Container(
                  height: 60,
                  padding: EdgeInsets.only(bottom: 3),
                  decoration: BoxDecoration(
                      color: theme.ScBottomBar.background,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: theme.ScBottomBar.topBorder,
                            blurRadius: 6)
                      ]),
                  child: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.home, size: 30)),
                        Tab(icon: Icon(Icons.map, size: 30))
                      ],
                      unselectedLabelColor: theme.ScBottomBar.unSelect,
                      labelColor: theme.ScBottomBar.selected,//Colors.indigo,
                      indicatorColor: theme.ScBottomBar.indicatorColor,
                      indicatorWeight: 2)),
            )));
  }

  Widget makeHome(BuildContext context) {
    var size = window.physicalSize;

    var carrousel;
    if (size.height > 800) {
      carrousel = CarrouselWidget(
        list: getExampleCarrousel(),
      );
    } else {
      carrousel = SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: HomeSearchBar(),
        ),
        Flexible(
            child: ListView(
                shrinkWrap: true,
                controller: new ScrollController(keepScrollOffset: false),
                children: <Widget>[
              carrousel,
              ContentRootWidget(contentRoot: getExampleContent())
            ]))
      ],
    );
  }

  Widget makeMap() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('mapa'),
        ),
      ],
    );
  }
}
