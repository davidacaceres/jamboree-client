import 'dart:ui';

import 'package:Pasaporte/example_data/example_data.dart';
import 'package:Pasaporte/ui/home/widget/carrousel.dart';
import 'package:Pasaporte/ui/home/widget/content_root.dart';
import 'package:Pasaporte/ui/home/widget/search_bar.dart';
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
            data: ThemeData(brightness: Brightness.light),
            child: Scaffold(
              body: Flex(direction: Axis.vertical, children: <Widget>[
                Expanded(
                    child: TabBarView(children: [makeHome(context), makeMap()]))
              ]),
              bottomNavigationBar: Container(
                  height: 70,
                  padding: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: Colors.black12,
                            blurRadius: 6)
                      ]),
                  child: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.home, size: 30)),
                        Tab(icon: Icon(Icons.map, size: 30))
                      ],
                      unselectedLabelColor: Colors.black12,
                      labelColor: Colors.indigo,
                      indicatorColor: Colors.indigo,
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
