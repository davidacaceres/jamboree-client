import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SearchFieldWidget extends StatefulWidget {
  Function(String) callBackParentToSearch;
  String textSearch;

  SearchFieldWidget({this.textSearch}) ;

  @override
  SearchFieldWidgetState createState() => SearchFieldWidgetState();

  addCallBackParentToSearch(Function(String) call) =>
      callBackParentToSearch = call;
}

class SearchFieldWidgetState extends State<SearchFieldWidget> {
  final TextEditingController textController = TextEditingController();
  var _textField;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textController.text = widget.textSearch;
    textController.selection = TextSelection.collapsed(offset: (widget.textSearch==null?0:widget.textSearch.length));
    return Container(
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 16.0),
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
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _getBackButton(),
            Expanded(
              child: _getTextField(),
            ),
            _getResetButton()
          ],
        ));
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  TextField _getTextField() {
    if (_textField == null) {
      return TextField(
        textInputAction: TextInputAction.search,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: 'Buscar'),
        onChanged: _changedText,
        onSubmitted: notifySearch,
        controller: textController,
        autofocus: true,
      );
    } else {
      return _textField;
    }
  }

  IconButton _getBackButton() {
    return new IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
          print('Volviendo a la busqueda');
        });
  }

  Widget _getResetButton() {
    if (widget.textSearch!=null && widget.textSearch.isNotEmpty) {
      return new IconButton(
          icon: Icon(Icons.close, color: Colors.black), onPressed: _clearText);
    } else {
      return SizedBox.shrink();
    }
  }

  _changedText(String text) {
    if (text.length == 0) {
      _clearText();
    } else if (text.length > 0 ) {
      setState(() {
        widget.textSearch = text;
      });
    }
  }

  _clearText() {
    setState(() {
      widget.textSearch='';
      textController.clear();
      notifySearch(textController.text);
    });
  }

  void notifySearch(String text) {
    try {
      widget.callBackParentToSearch(text);
    } catch (ex) {
      print('Error al llamar al padre para realizar busqueda ${ex.toString()}');
    }
  }
}
