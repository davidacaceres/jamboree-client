import 'dart:io';
import 'package:Pasaporte_2020/data/data_store.dart';
import 'package:Pasaporte_2020/example_data/url_files.dart' as urls;
import 'package:Pasaporte_2020/model/ubicacion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


Future<List<Ubicacion>> loadUbicacionesFromUrl() async {
  List<Ubicacion> contents=[];

  print("[manager_ubic] Iniciando carga de contenido");
  try {
    bool connected = false;
    try {
      final result = await InternetAddress.lookup(urls.url_server)
          .timeout(Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('[manager_ubic] connected to ${urls.url_server}');
        connected = !connected;
      }
    } catch (ex) {
      print('[manager_ubic] not connected to ${urls.url_server} $ex');
    }
    if (connected) {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptCharsetHeader: "utf-8" // or whatever
      };
      try {
        final response = await http
            .get(urls.url_location,
            headers: headers)
            .timeout(Duration(seconds: 15));
        if (response.statusCode == 200) {
          print(
              "[manager_ubic] Se encontro archivo en ${urls.url_server} con ubicaciones");

          var jStringList = json.decode(utf8.decode(response.bodyBytes));
          contents.clear();

          for (int u = 0; u < jStringList.length; u++) {
            Ubicacion ubica = Ubicacion.fromMap(jStringList[u]);
            if(!contents.contains(ubica))
              contents.add(ubica);
          }
          print('[manager_ubic] Finalizo la carga de ubicaciones con ${contents.length} items');
        }
      } catch (ex1) {
        print('[manager_ubic] Error al cargar ubicaciones $ex1');
      }
    }
  } catch (e) {
    print('[manager_ubic] Error al recibir archivo con ubicaciones');
  }
  return contents.isEmpty?null:contents;
}

Future<List<Ubicacion>> loadUbicacionesFromFile() async {
  print("[manager_ubic] Iniciando carga de ubicaciones desde archivo");

  List<Ubicacion> locations=[];
  File locationFile = await getLocationsFile();
  if (locationFile != null && await locationFile.exists()) {
    print("[manager_ubic] Se encontro archivo de ubicaciones");
    try {
      String dataString=  locationFile.readAsStringSync(encoding: utf8);
      var jStringList = json.decode(dataString);
      for (int u = 0; u < jStringList.length; u++) {
        Ubicacion content = Ubicacion.fromJson(jStringList[u]);
        locations.add(content);
      }
      print(
          '[manager_ubic] Finalizo la carga de locations con ${jStringList.length}');
    }catch(ex){
      print("[manager_ubic] No se pudo transformar archivo de locations $ex");
    }
  } else {
    print('[manager_ubic] No se encontro archivo de locations');
  }
  return locations.isEmpty?null:locations;
}


Future<List<Ubicacion>> loadUbicacionesFromAssets() async {
  print("[manager_ubic] Iniciando carga de locations desde assets");

  List<Ubicacion> contents=[];
  String dataString= await rootBundle.loadString(urls.assets_location);
  if (dataString != null && dataString.length>0) {
    print("[manager_ubic] Se encontro archivo de locations en assets");
    try {
      var jStringList = json.decode(dataString);
      for (int u = 0; u < jStringList.length; u++) {
        Ubicacion content = Ubicacion.fromMap(jStringList[u]);
        contents.add(content);
      }
      print(
          '[manager_ubic] Finalizo la carga de locations en assets con ${jStringList.length}');
    }catch(ex){
      print("[manager_ubic] No se pudo transformar locations desde assets");
    }
  } else {
    print('[manager_ubic] No se encontro archivo de locations');
  }
  return contents.isEmpty?null:contents;
}


Future<bool> saveLocations(List<Ubicacion> contents) async {
  try {
    print('[manager_ubic] Guardando localmente el archivo de ubicaciones');

    String result = jsonEncode(contents);
    await writeLocalLocations(result);
    return true;
  } catch (error) {
    return false;
  }
}

