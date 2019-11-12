import 'package:flutter/material.dart';

class HistoryListWidget extends StatelessWidget {
  Function(String) callbackHistoryValue;

  final List<String> historia;

  HistoryListWidget({this.historia});

  void addCallBackHistoryValue(Function(String) call) =>
      callbackHistoryValue = call;

  @override
  Widget build(BuildContext context) {
    return ListView(children: _listItems(context));
  }

  List<Widget> _listItems(BuildContext context) {
    final List<Widget> items = [];
    historia.forEach((item) {
      final widTmp = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        title: Text(item),
        leading: Icon(
          Icons.history,
          size: 20,
        ),
        onTap: () {
          print(item);
          if (callbackHistoryValue != null) {
            try {
              print('valor desde lista historia:$item');
              callbackHistoryValue(item);
            } catch (ex) {
              print(
                  'Error al llamar al padre para realizar busqueda ${ex.toString()}');
            }
          }
        },
      );
      items.add(widTmp);
    });
    return items;
  }
}
