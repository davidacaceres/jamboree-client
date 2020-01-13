import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/model/content/display.dart';
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

    Color txtColor = getTextColor(context, content.titleColor,sc_theme.ScContent.defaultTitleColor);


    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: sc_theme.ScContent.barTopColor,
      ),
      body: Column(
        children: <Widget>[
          _logoContent(context, content, bgColor,txtColor),
          getDisplayComponent(context, content, bgColor,txtColor),
        ],
      ),
    );
  }

  Widget _logoContent(BuildContext context, Content content, Color color, Color txtColor) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        child: getTitle(context, content,txtColor));
  }

  Padding getTitle(BuildContext context, Content content,Color txtColor) {
    //Color titleColor = getTextColor(
    //    context, content.titleColor, sc_theme.ScContent.defaultTitleColor);

    TextStyle txtStyle =
        sc_theme.ScContent.titleContent.copyWith(color: txtColor);
    if (content.font != null && content.font.isNotEmpty) {
      txtStyle = txtStyle.copyWith(fontFamily: content.font);
    }
    if (content.fontSize != null && content.fontSize > 0) {
      txtStyle = txtStyle.copyWith(fontSize: content.fontSize,fontWeight: FontWeight.bold);
    }

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
                      style: txtStyle,

                    )))
          ],
        ));
  }

  Widget getDisplayComponent(
      BuildContext context, Content content, Color baseColor,Color txtColor) {
    if (content.display == null ||
        content.display.isEmpty ||
        content.display.length <= 0) {
      return SizedBox(width: 5);
    } else if (content.display.length == 1) {
      return getOneDisplay(context, content,txtColor);
    } else if (content.display.length > 1) {
      return getMultiDisplay(context, content, baseColor,txtColor);
    }
    return SizedBox(width: 5);
  }

  Widget getOneDisplay(BuildContext context, Content content, Color txtColor) {
    print('Mostrando solo un Display');
    Display display = content.display[0];
    return Expanded(
        child: DisplayWidget(
      display: display,
      parentId: content.id,
      index: 1,
      bgColorParent: getBackgroundColor(context, content.backgroundPage),
          txtColorParent: txtColor,
    ));
  }

  Widget getMultiDisplay(
      BuildContext context, Content content, Color baseColor,Color txtColor) {
    final  primaryColor= getBackgroundColor(context, content.tabPrimaryColor,getBackgroundColor(context,content.backgroundPage,sc_theme.ScContent.tabPrimaryColor));
    final  secondaryColor= getBackgroundColor(context, content.tabSecondaryColor,sc_theme.ScContent.tabSecondaryColor);
    final  textColor= getBackgroundColor(context, content.tabTextColor,txtColor);

    List<Display> displays = content.display;
    if (content.display == null ||
        content.display.isEmpty ||
        content.display.length <= 0) {
      return SizedBox(width: 5);
    }
    int countTabs = displays.length;
    BoxDecoration decoration = BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10))
    );

    return Expanded(
        flex: 5,
        child: Container(
          //decoration: decoration,
          height: 50,
          child: DefaultTabController(
              length: countTabs,
              child: Column(children: <Widget>[
                Container(
                    height: 50,
//                    margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    decoration: BoxDecoration(
//                      border: Border.all(
//                          color: primaryColor),
                      color: secondaryColor,
//                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TabBar(
                        isScrollable: false,
//                        unselectedLabelColor:
//                            secondaryColor.withAlpha(80),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                 // offset: Offset(3, 3),
                                  blurRadius: 20)
                            ],
                            color:primaryColor,
//                            borderRadius: BorderRadius.circular(10)
                        ),
                        tabs: getTabsTitle(context,displays,textColor))),
                Expanded(
                    child: Container(
                        decoration: decoration,
                        child: TabBarView(
                          children: getTabViews(content.id, displays,getBackgroundColor(context, content.backgroundPage),txtColor),
                        )))
              ])),
        ));
  }

  List<Tab> getTabsTitle(BuildContext context, List<Display> displays,Color textColor) {
    final List<Tab> tabs = [];

    for (var i = 0; i < displays.length; i++) {
      final Display dsp = displays[i];
      double fontSize = (dsp.fontSize == 0 ? 14.0 : dsp.fontSize);
      String fontFamily = (dsp.fontFamily == null || dsp.fontFamily.isEmpty
          ? "Arial"
          : dsp.fontFamily);

      final tab = Tab(
          child: Align(
              alignment: Alignment.center,
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                dsp.shortTitle,
                style: TextStyle(color:textColor,fontSize: fontSize,fontFamily: fontFamily,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                maxLines: 2,
              ))));
      tabs.add(tab);
    }
    return tabs;
  }

  List<Widget> getTabViews(String parentId, List<Display> displays,Color bgParent, Color txtParent) {
    List<Widget> tabViews = [];

    for (var i = 0; i < displays.length; i++) {
      final Display display = displays[i];
      final dw = DisplayWidget(
        display: display,
        parentId: parentId,
        index: i,
        bgColorParent: bgParent,
        txtColorParent: txtParent,

      );
      tabViews.add(dw);
    }
    return tabViews;
  }
}
