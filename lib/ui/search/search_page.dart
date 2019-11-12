import 'package:Pasaporte/example_data/example_data.dart';
import 'package:Pasaporte/model/Content.dart';
import 'package:Pasaporte/ui/search/widget/wsearch_field.dart';
import 'package:Pasaporte/ui/search/widget/wsearch_history.dart';
import 'package:Pasaporte/ui/search/widget/wsearch_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SearchPage extends StatefulWidget {
  String searchText;


  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Content> resultado=getExampleContent();
  SearchFieldWidget searchBar;
  final historyList = HistoryListWidget(historia: getExampleHistory());



  @override
  void initState() {
    super.initState();
    historyList.addCallBackHistoryValue(historySelect);

  }

  @override
  Widget build(BuildContext context) {
    searchBar= SearchFieldWidget(textSearch:widget.searchText);
    searchBar.addCallBackParentToSearch(search);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Expanded(child: searchBar),
          ]),
          Expanded(child: getList()),
        ],
      ),
    ));
  }

  Widget getList(){
    if(widget.searchText!=null && widget.searchText.isNotEmpty){
      print('Generando Listado de Resultado');
      return SearchResult(listado: resultado);
    }else{
      print('Generando Listado de Historia');
      return historyList;

    }
  }

  search(String text) {
    print("1:$text");
    setState(() {
      widget.searchText=text;
    });
  }

  historySelect(String text) {
    print("Parent Receive from Child :$text");

    setState(() {
      widget.searchText=text;
    });
  }
}
