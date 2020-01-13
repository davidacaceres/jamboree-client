import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/model/version.dart';
import 'package:Pasaporte_2020/providers/content.provider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

import 'package:Pasaporte_2020/data/data_store.dart';

const urlVersion = 'http://parlamento.jamboree.cl/version.json';
const urlContent = 'http://parlamento.jamboree.cl/locations_jme.json';
const urlLocation = 'http://parlamento.jamboree.cl/locations_jme.json';
const server = 'parlamento.jamboree.cl';

Version _version;
bool checkedVersion;

Future<List<Content>> loadData() async {
  bool download = false;
  if (_version == null) {
    download = await _checkVersion();
  }
  if (download) {
    print('[DM] Bajar archivos nuevos');
    await downloadFiles();
  } else {
    print('[DM] No se descargo nada de internet');
  }

  return await contentProvider.getRootContent();
}

Future<List<Content>> getContent() async {
  List<Content> contents=[];
  File dataFile = await getDataFile();
  if (dataFile != null && await dataFile.exists()) {
    print('[DM] Se encontro archivo de contenido');
    try {
      String dataString=  dataFile.readAsStringSync(encoding: utf8);
      var jStringList = json.decode(dataString);
      for (int u = 0; u < jStringList.length; u++) {
        Content content = Content.fromMap(jStringList[u]);
        contents.add(content);
      }
      print(
          'Finalizo la carga de contenido con ${jStringList.length}');
    }catch(ex){
      print("No se pudo transformar archivo de ubicaciones");
    }
  } else {
    print('[DM] No se encontro archivo de contenido');
  }
  return contents;
}

Future<bool> _checkVersion() async {
  print('[DM] Verificando version de sistema');
  File file = await getVersionFile();
  Version vInternet;
  if (file != null) {
    try {
      _version = Version.fromJson(file.readAsStringSync(encoding: utf8));
    } catch (ex) {
      print('[DM] Error al leer archivo de version local');
      return true;
    }
  } else
    return true;

  if (_version == null) return true;
  if (vInternet == null) {
    vInternet = await getVersionFileFromURL();
  }

  if (vInternet == null) {
    print('[DM] No se pudo recuperar desde internet el archivo de version');
    return false;
  }
  if (_version != vInternet) {
    print('[DM] diferencias en el archivo de version');
    return true;
  }
  checkedVersion = true;
  return false;
}

Future<bool> downloadFiles() async {
  print('[DM] Bajando archivos');
  return await downloadContentFile();



}


Future<bool> downloadContentFile( ) async {
  try {
    bool connected = false;
    try {
      final result = await InternetAddress.lookup("jamboree.cl");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('[DM] connected to parlamento.jamboree.cl');
        connected = !connected;
      }
    } on SocketException catch (_) {
      print( '[DM] No se pudo conectar a parlamento.jaboree.cl');
      return false;
    }
    if (connected) {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptCharsetHeader: "utf-8" // or whatever
      };
      final response = await http
          .get('http://parlamento.jamboree.cl/data_jme.json', headers: headers);
      if (response.statusCode == 200) {
        print(
            "[DM] Se encontro archivo en parlamento.jamboree.cl con informacion de actualizacion");
        writeLocalData(response.body);
        print('[DM] Finalizo la carga del contenido');
        return true;
      } else {
        print(
            '[DM] Codigo de respuesta ${response.statusCode} desde parlamento.jaboree.cl al recuperar archivo de contenido');
        return false;
      }
    } else {
      print('[DM] No se pudo obtener contenido desde parlamento.jaboree.cl');
      return false;
    }
  } catch (e) {
    print('[DM] Error al recibir archivo con informacion de actualizacion');
  }
  return false;
}

Future<Version> getVersionFileFromURL() async {
  try {
    bool connected = false;
    try {
      final result = await InternetAddress.lookup("parlamento.jamboree.cl")
          .timeout(Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('[DM] connected to parlamento.jamboree.cl to download version file');
        connected = !connected;
      }
    } catch (ex) {
      print(
          '[DM] not connected to parlamento.jamboree.cl to download version file [$ex]');
      return null;
    }
    if (connected) {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptCharsetHeader: "utf-8" // or whatever
      };
      final response = await http
          .get(urlVersion, headers: headers)
          .timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        print("[DM] Se encontro archivo de version en parlamento.jamboree.cl");
        try {
          var fileVersion = json.decode(utf8.decode(response.bodyBytes));
          Version content = Version.fromJson(fileVersion);
          writeLocalVersion(content);
          print('[DM] version guardada en archivo local');
          print('[DM] Finalizo la carga de la version con ${fileVersion}');
          return content;
        } catch (ex) {
          print("[DM] No se pudo transformar archivo de version");
          return null;
        }
      } else {
        print(
            '[DM] Server respondio ${response.statusCode}  sin archivo de version');
        return null;
      }
    }
  } catch (e) {
    print('[DM] Error al recibir archivo con version $e');
  }
  return null;
}
