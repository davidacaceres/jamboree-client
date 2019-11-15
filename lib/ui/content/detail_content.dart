import 'package:Pasaporte/model/Content.dart';
import 'package:Pasaporte/ui/content/widget/wDisplay.dart';
import 'package:Pasaporte/utils/ColorUtils.dart';
import 'package:Pasaporte/utils/ImageUtils.dart';
import 'package:flutter/material.dart';

class DetailContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Content content=ModalRoute.of(context).settings.arguments;

    Color bgColor;
    if(content.backgroundPage==null)
    {
        bgColor=Theme.of(context).bottomAppBarColor;
    }else{
        bgColor=getBackgroundColor(context, content.backgroundPage);
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: <Widget>[
              _logoContent(context, content),
          getDisplayComponent(context, content),
          //_tab(context, content),
        ],
      ),
    );
  }

  Widget _logoContent(BuildContext context, Content content) {
    return Container(
        height: MediaQuery.of(context).size.height*0.15,
        child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width*0.30,
                child:
            Padding(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    )))
          ],
        )));
  }

  Widget getDisplayComponent(BuildContext context, Content content) {
    if (content.display == null ||
        content.display.isEmpty ||
        content.display.length <= 0) {
      return SizedBox(width: 5);
    } else if (content.display.length == 1) {
      return getOneDisplay(context, content);
    } else if (content.display.length > 1) {
      return getMultiDisplay(context, content);
    }
    return SizedBox(width: 5);
  }

  Widget getOneDisplay(BuildContext context, Content content) {
    Display display = content.display[0];
    return SingleChildScrollView(
        child: Column(
            children:<Widget>[DisplayWidget(display: display, parentId: content.id)])
    );
  }

  Widget getMultiDisplay(BuildContext context, Content content) {
    List<Display> displays = content.display;
    if (content.display == null ||
        content.display.isEmpty ||
        content.display.length <= 0) {
      return SizedBox(width: 5);
    }
    int countTabs = displays.length;

    return Expanded(
        flex: 5,
        child: Container(
          height: 50,
          child: DefaultTabController(
              length: countTabs,
              child: Column(children: <Widget>[
                Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 16, right: 16,bottom: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurpleAccent),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                        isScrollable: false,
                        unselectedLabelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(3, 3),
                                  blurRadius: 6)
                            ],
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(6)),
                        tabs: getTabsTitle(displays))),
                Expanded(
                    child: TabBarView(
                  children: getTabViews(content.id, displays),
                ))
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
      final dw = DisplayWidget(display: display, parentId: parentId);
      tabViews.add(dw);
    }
    return tabViews;
  }
}
