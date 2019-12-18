import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';


class SearchResult extends StatelessWidget {
  final List<Content> listado;

  SearchResult({this.listado});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(top:10,left: 16),
                    child: Text('RESULTADOS (${listado.length})',softWrap: true,
                        style: TextStyle(color: Colors.black38,fontFamily: 'Arial',fontSize: 12),
                        )),
              )
            ]),
        Expanded(child: buildList(context,listado)),
      ],
    );
  }

  Widget buildList(BuildContext context,List<Content> contents) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listado.length,
      itemBuilder: (BuildContext context, int index) {
        return getListItem(context,listado[index], index);
      },
    );
  }

  Widget getListItem(BuildContext context,Content content, index) {
    final makeListTile = ListTile(
        onTap: () {
          Navigator.pushNamed(context, "detail",arguments: content);
        },
        leading: Container(
          child: Padding(padding: EdgeInsets.only(top:3.0, bottom: 3.0),child:getImageContent(url: content.image)),
        ),
        title: Container(child:Text((
          content.titleList==null?content.title:content.titleList),
          overflow: TextOverflow.visible,
          style:  TextStyle(color: Colors.black87,fontFamily: 'Arial',fontSize: 14),
        )),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 16.0));
    final contentCard = Card(
      elevation: 0.1,
      margin: new EdgeInsets.symmetric(horizontal: 10, vertical: 0.5),
      child: makeListTile,
    );

    return contentCard;
  }
}
