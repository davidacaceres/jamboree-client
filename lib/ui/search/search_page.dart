import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:Pasaporte_2020/ui/search/widget/wsearch_field.dart';
import 'package:Pasaporte_2020/ui/search/widget/wsearch_history.dart';
import 'package:Pasaporte_2020/ui/search/widget/wsearch_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SearchPage extends StatefulWidget {


  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
 // final List<Content> resultado=getExampleContent();
  String searchText;
  final SearchFieldWidget searchBar= SearchFieldWidget();
  final historyList = HistoryListWidget(historia: dataProvider.getExampleHistory());



  @override
  void initState() {
    super.initState();
    historyList.addCallBackHistoryValue(historySelect);
    searchBar.addCallBackParentToSearch(search);

  }

  @override
  Widget build(BuildContext context) {

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
    if(searchText!=null && searchText.isNotEmpty){
      print('Generando Listado de Resultado');
      var result = dataProvider.getExampleSearchContent(searchText);
      print('Resultado de la busqueda: ${result.length}');
      return SearchResult(listado: result );
    }else{
      print('Generando Listado de Historia');
      return historyList;

    }
  }

  search(String text) {
    print("Buscando--->:$text");
    setState(() {
      searchText=text;
    });
  }

  historySelect(String text) {
    print("Parent Receive from Child :$text");

    setState(() {
      searchText=text;
    });
  }
}
