import 'package:Pasaporte_2020/config/config_definition.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top:10),
        color: config.ScHomeSearch.background,
        child:Container(
        height: 45,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          //backgroundBlendMode: BlendMode.,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.0,
              offset: Offset(0.2, 0.2),
              color: Colors.grey[400],
            )
          ],
          color: Colors.white,
        ),
        child: getSearchField(context)
    ));
  }

  Widget getSearchField(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: TextField(
            enabled: true,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Buscador'),
            onTap: () {
              _loadSearchPage(context);
            },
            enableInteractiveSelection: false,
          ),
        ),
      ],
    );
  }

  void _loadSearchPage(BuildContext context) {
    print('Load Seaarch Page');
    //Navigator.push(context, PageTransition(type: PageTransitionType.scale, child: SearchPage()));
    Navigator.pushNamed(context,'search');
  }


}
