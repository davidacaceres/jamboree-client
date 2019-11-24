import 'package:Pasaporte_2020/model/Content.dart';
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
        Expanded(child: buildList(listado)),
      ],
    );
  }

  Widget buildList(List<Content> contents) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listado.length,
      itemBuilder: (BuildContext context, int index) {
        return getListItem(listado[index], index);
      },
    );
  }

  Widget getListItem(Content content, index) {
    final makeListTile = ListTile(
        onTap: () {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => DetailPage2(lesson: content)));
        },
        //  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        leading: Container(
          child: getAvatar(
              urlImage: "https://picsum.photos/id/$index/200/300",
              radius: 18.0),
        ),
        title: Text(
          content.titleList,
          style:  TextStyle(color: Colors.black87,fontFamily: 'Arial',fontSize: 12),
        ),
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
