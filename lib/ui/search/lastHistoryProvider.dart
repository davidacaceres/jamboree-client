import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class _LastHistoryProvider {
   List<String> _historias=[];
  SharedPreferences _prefs;

  _LastHistoryProvider() {
    cargarHistoria();
  }

  Future<List<String>> cargarHistoria() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    _historias = _prefs.getStringList('search_history');
    return _historias;
  }

  void agregarHistoria(String historia) async {
    _historias.add(historia);
    _getSharedPreferencs().then((shp) {
      _prefs.setStringList('search_history',_historias);
    });
  }

  Future<SharedPreferences> _getSharedPreferencs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }
}

final lastHistoryProvider= _LastHistoryProvider();
