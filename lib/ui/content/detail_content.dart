import 'package:Pasaporte_2020/model/Content.dart';
import 'package:Pasaporte_2020/ui/content/widget/wDisplay.dart';
import 'package:Pasaporte_2020/utils/ColorUtils.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Pasaporte_2020/config/config_definition.dart' as sc_theme;

class DetailContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Content content = ModalRoute.of(context).settings.arguments;

    Color bgColor;
    if (content.backgroundPage == null) {
      bgColor = sc_theme.ScContent.defaultColor;
    } else {
      bgColor = getBackgroundColor(context, content.backgroundPage);
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: sc_theme.ScContent.barTopColor,
        /*actions: <Widget>[IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            print('compartir');
          },
        )],*/
      ),
      body: Column(
        children: <Widget>[
          _logoContent(context, content, bgColor),
          getDisplayComponent(context, content, bgColor),
        ],
      ),
    );
  }

  Widget _logoContent(BuildContext context, Content content, Color color) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        child: getTitle(context, content));
  }

  Padding getTitle(BuildContext context, Content content) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: getImageContent(
                        url: content.image, fit: BoxFit.contain))),
            Expanded(
                flex: 5,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      content.title,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3,
                      style: sc_theme.ScContent.titleContent,
                    )))
          ],
        ));
  }

  Widget getDisplayComponent(
      BuildContext context, Content content, Color baseColor) {
    if (content.display == null ||
        content.display.isEmpty ||
        content.display.length <= 0) {
      return SizedBox(width: 5);
    } else if (content.display.length == 1) {
      return getOneDisplay(context, content);
    } else if (content.display.length > 1) {
      return getMultiDisplay(context, content, baseColor);
    }
    return SizedBox(width: 5);
  }

  Widget getOneDisplay(BuildContext context, Content content) {
    print('Mostrando solo un Display');
    Display display = content.display[0];
    return Expanded(
        child: DisplayWidget(display: display, parentId: content.id, index: 1));
  }

  Widget getMultiDisplay(
      BuildContext context, Content content, Color baseColor) {
    List<Display> displays = content.display;
    if (content.display == null ||
        content.display.isEmpty ||
        content.display.length <= 0) {
      return SizedBox(width: 5);
    }
    int countTabs = displays.length;
    BoxDecoration decoration = BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)));
/*
    if (sc_theme.ScContent.titleGradient && content.display.length>1) {

      Color colorEnd;
      try {
        List<int> colorChild =
            content.display[0].content[0].paragraphConf.backgroundColor;
        colorEnd = getBackgroundColor(context, colorChild);
      } catch (ex) {
        print('No se encontro contenido inicial');
        colorEnd = baseColor;
      }
      print('Color inicial: ${baseColor} color final ${colorEnd}');
      decoration= BoxDecoration(gradient:  LinearGradient(
              colors: [baseColor, colorEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 0.95],
              tileMode: TileMode.repeated));

    }*/

    return Expanded(
        flex: 5,
        child: Container(
          //decoration: decoration,
          height: 50,
          child: DefaultTabController(
              length: countTabs,
              child: Column(children: <Widget>[
                Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: sc_theme.ScContent.selectedColorBackgroundTab),
                      color: sc_theme.ScContent.unSelectedColorBackgroundTab,
                      //color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                        isScrollable: false,
                        unselectedLabelColor:
                            sc_theme.ScContent.unSelectedColorTextTab,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(3, 3),
                                  blurRadius: 6)
                            ],
                            color:
                                sc_theme.ScContent.selectedColorBackgroundTab,
                            borderRadius: BorderRadius.circular(6)),
                        tabs: getTabsTitle(displays))),
                Expanded(
                    child: Container(
                        decoration: decoration,
                        child: TabBarView(
                          children: getTabViews(content.id, displays),
                        )))
              ])),
        ));
  }

  List<Tab> getTabsTitle(List<Display> displays) {
    final List<Tab> tabs = [];

    for (var i = 0; i < displays.length; i++) {
      final Display dsp = displays[i];
      final tab = Tab(
          child:
              Align(alignment: Alignment.center, child: Text(dsp.shortTitle)));
      tabs.add(tab);
    }
    return tabs;
  }

  List<Widget> getTabViews(String parentId, List<Display> displays) {
    List<Widget> tabViews = [];

    for (var i = 0; i < displays.length; i++) {
      final Display display = displays[i];
      final dw = DisplayWidget(
        display: display,
        parentId: parentId,
        index: i,
      );
      tabViews.add(dw);
    }
    return tabViews;
  }
}
