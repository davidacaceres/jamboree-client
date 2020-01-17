import 'dart:io';
import 'package:Pasaporte_2020/data/data_store.dart';
import 'package:Pasaporte_2020/example_data/url_files.dart' as urls;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:Pasaporte_2020/model/content.dart';

Future<List<Content>> loadContentsFromUrl() async {
  List<Content> contents=[];

  print("[CONT] Iniciando carga de contenido");
  try {
    bool connected = false;
    try {
      final result = await InternetAddress.lookup(urls.url_server)
          .timeout(Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('[CONT] connected to ${urls.url_server}');
        connected = !connected;
      }
    } catch (ex) {
      print('[CONT] not connected to ${urls.url_server} $ex');
    }
    if (connected) {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptCharsetHeader: "utf-8" // or whatever
      };
      try {
        final response = await http
            .get(urls.url_content,
            headers: headers)
            .timeout(Duration(seconds: 15));
        if (response.statusCode == 200) {
          print(
              "[CONT] Se encontro archivo en ${urls.url_content} con informacion de actualizacion");
          // print(response.body);

          var jStringList = json.decode(utf8.decode(response.bodyBytes));
          contents.clear();

          for (int u = 0; u < jStringList.length; u++) {
            Content content = Content.fromMap(jStringList[u]);
            if(!contents.contains(content))
              contents.add(content);
          }
          print('[CONT] Finalizo la carga del contenido con ${contents.length} items');
        }
      } catch (ex1) {
        print('[CONT] Error al cargar contenido $ex1');
      }
    }
  } catch (e) {
    print('[CONT] Error al recibir archivo con informacion de actualizacion');
  }
  return contents.isEmpty?null:contents;
}

Future<List<Content>> loadContentsFromFile() async {
  print("[manager_cont] Iniciando carga de contenido desde archivo");

  List<Content> contents=[];
  File dataFile = await getDataFile();
  if (dataFile != null && await dataFile.exists()) {
    print("[manager_cont] Se encontro archivo de contenido");
    try {
      String dataString=  dataFile.readAsStringSync(encoding: utf8);
      var jStringList = json.decode(dataString);
      for (int u = 0; u < jStringList.length; u++) {
        Content content = Content.fromMap(jStringList[u]);
        contents.add(content);
      }
      print(
          '[manager_cont] Finalizo la carga de contenido con ${jStringList.length}');
    }catch(ex){
      print("[manager_cont] No se pudo transformar archivo de contenido");
    }
  } else {
    print('[manager_cont] No se encontro archivo de contenido');
  }
  return contents.isEmpty?null:contents;
}


Future<List<Content>> loadContentsFromAssets() async {
  print("[manager_cont] Iniciando carga de contenido desde assets");

  List<Content> contents=[];
  String dataString= await rootBundle.loadString(urls.assets_content);
  if (dataString != null && dataString.length>0) {
    print("[manager_cont] Se encontro archivo de contenido en assets");
    try {
      var jStringList = json.decode(dataString);
      for (int u = 0; u < jStringList.length; u++) {
        Content content = Content.fromMap(jStringList[u]);
        contents.add(content);
      }
      print(
          '[manager_cont] Finalizo la carga de contenido en assets con ${jStringList.length}');
    }catch(ex){
      print("[manager_cont] No se pudo transformar contenido desde assets");
    }
  } else {
    print('[manager_cont] No se encontro archivo de contenido');
  }
  return contents.isEmpty?null:contents;
}


Future<bool> saveContent(List<Content> contents) async {
  try {
    String result = jsonEncode(contents);
    await writeLocalData(result);
    return true;
  } catch (error) {
    return false;
  }
}

