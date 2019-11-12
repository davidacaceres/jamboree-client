import 'package:Pasaporte/ui/search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
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
    );
  }

  Widget getSearchField(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: TextField(
            //    enabled: false,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Buscar'),
            onTap: () {
              _loadSearchPage(context);
            },
          ),
        ),
      ],
    );
  }

  void _loadSearchPage(BuildContext context) {
    print('Load Seaarch Page');
    //return MaterialPageRoute(builder: (context)=>SearchPage());
//    return CupertinoPageRoute(builder: (context) => SearchPage());
    //Navigator.push(context, PageTransition(type: PageTransitionType.scale, child: SearchPage()));
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SearchPage()));

  }


}
