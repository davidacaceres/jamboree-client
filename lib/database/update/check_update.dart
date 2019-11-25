import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Pasaporte_2020/config/config_definition.dart';
import 'package:Pasaporte_2020/database/update/info_update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class CheckUpdate{
  static final String lastUpdateKey="lastUpdate";

  InfoUpdate _iUpdateRemote;


  Future<bool> check() {
    print("Verificando si hay actualizacion");
    Future<bool> ischanged;
      try {
        ischanged=_haveChanges();
      } catch (ex) {
        print(
            "Error al verificar si existe actualizacion remota");
      }
      return ischanged;
    }


  Future<bool> _haveChanges() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    InfoUpdate iUpdateLocal;
    final String jUpdateLocal = prefs.getString(lastUpdateKey) ?? "";
    if (jUpdateLocal != "") {
      iUpdateLocal = InfoUpdate.fromMap(json.decode(jUpdateLocal));
      print("Ultima actualizacion almacenada [${iUpdateLocal.toString()}]");
    }
    _iUpdateRemote = await _getNewUpdateFile();
    if (_iUpdateRemote == null) {
      print("No se encontro archivo remoto valido para informacion de actualizacion");
      return false;
    } else {
      print("Archivo remoto con informacion de actualizacion [${_iUpdateRemote.toString()}]");
    }


    if ( iUpdateLocal != _iUpdateRemote) {
       if(_iUpdateRemote.urls==null || _iUpdateRemote.urls.length<=0) return false;
       return true;
    }
    return false;
  }

  Future<InfoUpdate> _getNewUpdateFile() async {
    try {
      bool connected=false;
      try {
        final result = await InternetAddress.lookup(getServerUpdateInfo());
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected to ${getServerUpdateInfo()}');
          connected=!connected;
        }
      } on SocketException catch (_) {
        print('not connected to ${getServerUpdateInfo()}');
      }
      if(connected) {
        final response = await http.get(
            'https://raw.githubusercontent.com/davidacaceres/scout_chile_data/master/json/lastUpdateContent.json');
        if (response.statusCode == 200) {
          print(
              "Se encontro archivo en github con informacion de actualizacion");
          print(response.body);
          return InfoUpdate.fromMap(json.decode(response.body));
        }
      }
    } catch (e) {
      print('Error al recibir archivo con informacion de actualizacion');
    }
    return null;
  }

}



