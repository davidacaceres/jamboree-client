import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:Pasaporte_2020/config/config_definition.dart' as theme;


class ContentRootWidget extends StatelessWidget {
  final List<Content> contentRoot;

  ContentRootWidget({@required this.contentRoot});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        childAspectRatio: 1,
        //   primary: true,
        //controller: new ScrollController(keepScrollOffset: false),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        cacheExtent: 5,
        shrinkWrap: true,
        crossAxisCount: 2,
        children: getList(context, contentRoot));
  }

  List<Widget> getList(BuildContext context, List<Content> contentRoot) {
    List<Widget> list = [];
    if (contentRoot != null && contentRoot.isNotEmpty) {
      for (var i = 0; i < contentRoot.length; i++) {
        list.add(makeCard(context, contentRoot[i], i));
      }
    }
    return list;
  }

  Widget makeCard(BuildContext context, Content content, int i) {
    return GestureDetector(
      onTap: () {
        print('Seleccionado: ${content.titleList} ');
        openDetailContent(context, content);
      },
      child: _subWidget(context, content, 200, 200),
    );
  }

  Widget _subWidget(
      BuildContext context, Content content, double hImage, double wImage) {

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: theme.ScHomePage.cardGradient,
                border: theme.ScHomePage.cardBorder,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(3, 3),
                      color: Colors.black12,
                      blurRadius: 10)
                ]),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: getImageContent(url:content.image))),
                  Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width*.40,
                      padding: EdgeInsets.all(5),
                      child:Text(
                        content.titleList,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        style: theme.ScHomePage.cardTextStyle,
                      ))
                ])));
  }

  void openDetailContent(BuildContext context, Content content) {
    Navigator.pushNamed(context, 'detail', arguments: content);
  }
}
