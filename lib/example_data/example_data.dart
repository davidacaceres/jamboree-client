import 'dart:convert';
import 'dart:io';

import 'package:Pasaporte_2020/model/carrousel.dart';
import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/model/ubicacion.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

final List<Content> _listContent =[];
final List<Ubicacion> _listLocations =[];

final List<Carrousel> _listCarrousel = [
  new Carrousel(
      order: 1,  image: "assets/img/carousel/imagen_1.jpg"),
  new Carrousel(
      order: 2,  image: "assets/img/carousel/imagen_2.jpg"),
  new Carrousel(
      order: 3,  image: "assets/img/carousel/imagen_3.jpg"),
  new Carrousel(
      order: 4,  image: "assets/img/carousel/imagen_4.jpg"),
  new Carrousel(
      order: 5,  image: "assets/img/carousel/imagen_5.jpg"),
  new Carrousel(
      order: 6,  image: "assets/img/carousel/imagen_6.jpg")];


final List<String> _listHistory = [
  "jamboree",
  "donde",
  "cuando",
  "porque",
  "que",
  "para",
  "quiero",
  "hacer",
  "lo",
  "haciendo",
  "fechas"
];

List<Content> getExampleContent() {
  return _listContent;
}

List<Content> getExampleRootContent() {
  return _listContent.where((i) => i.root!=null && i.root==true).toList();
}

List<Content> getExampleSearchContent(String search) {
  return _listContent.where((i) => i.search!=null && i.search.toLowerCase().contains(search.toLowerCase())).toList();
}


List<Carrousel> getExampleCarrousel() {
  return _listCarrousel;
}

List<String> getExampleHistory() {
  return _listHistory;
}

Content findExampleContent(String id){
  return _listContent.singleWhere((e)=> e.id==id);
}


Future<bool> loadContentAsset() async {
  try {
    print('cargando contenido desde archivo local');
    String jsondata = await rootBundle.loadString('assets/json/data_jme.json');

    var jStringList = json.decode(jsondata);
    for (int u = 0; u < jStringList.length; u++) {
      Content content = Content.fromMap(jStringList[u]);
      _listContent.add(content);
    }
    print('Finalizo la carga del contenido desde archivo local');
    return true;
  }catch(ex){
    print('Error al cargar ubicaciones desde json local $ex');
  }
  return false;
}

Future<bool> loadContentUrl() async {
//  await loadContentAsset();
//  return true;
  try {
    bool connected=false;
    try {
      final result = await InternetAddress.lookup("jamboree.cl");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to parlamento.jamboree.cl');
        connected=!connected;
      }
    } on SocketException catch (_) {
      print('not connected to parlamento.jamboree.cl');
    }
    if(connected) {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptCharsetHeader:"utf-8"// or whatever
      };
      final response = await http.get(
          'http://parlamento.jamboree.cl/data_jme.json',headers: headers);
      if (response.statusCode == 200) {
        print(
            "Se encontro archivo en parlamento.jamboree.cl con informacion de actualizacion");
       // print(response.body);

        var jStringList = json.decode(utf8.decode(response.bodyBytes));
        // print('lista con ${jStringList.length} items');
        for (int u =0; u < jStringList.length ; u++ ) {
          //  print('******* cargando: \n  ${jStringList[u]} \n');

          // print('iniciando decodificacion');
          //var decode = json.decode();
          //print ('******* decode: \n $decode');

          Content content=Content.fromMap(jStringList[u]);
          _listContent.add(content);

        }
        print('Finalizo la carga del contenido');
      }
    }
  } catch (e) {
    print('Error al recibir archivo con informacion de actualizacion');
  }
  return null;
}


Future<bool> loadLocationAsset() async {
  print('cargando ubicaciones desde archivo local');
  try {
    String jsondata = await rootBundle.loadString(
        'assets/json/locations_example.json');
    _listLocations.clear();
    var jStringList = json.decode(jsondata);
    for (int u = 0; u < jStringList.length; u++) {
      // print('cargando elemento $u \n ${jStringList[u]}');
      Ubicacion content = Ubicacion.fromMap(jStringList[u]);
      _listLocations.add(content);
    }
    print('Finalizo la carga del ubicaciones desde archivo local');
    return true;
  }catch(ex){
    print('error al cargar archivo de ubicaciones $ex');
    return false;
  }
}


Future<bool> loadLocationsUrl() async {
  return loadLocationAsset();
  /*
  try {
    bool connected=false;
    try {
      final result = await InternetAddress.lookup("jamboree.cl");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to parlamento.jamboree.cl to download content');
        connected=!connected;
      }
    } on SocketException catch (_) {
      print('not connected to parlamento.jamboree.cl');
    }
    if(connected) {
      print('get Locations from url');
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptCharsetHeader:"utf-8"// or whatever
      };
      final response = await http.get(
          'http://parlamento.jamboree.cl/locations_jme.json',headers: headers);
      if (response.statusCode == 200) {
        print(
            "Se encontro archivo de ubicaciones en parlamento.jamboree.cl");

        var jStringList = json.decode(utf8.decode(response.bodyBytes));
        for (int u =0; u < jStringList.length ; u++ ) {


          Ubicacion content=Ubicacion.fromJson(jStringList[u]);
          _listLocations.add(content);

        }
        print('Finalizo la carga de la ubicaciones con ${jStringList.length}');
        return true;
      }else{
        print('Server respondio ${response.statusCode}  sin archivo de ubicaciones');
        return false;
      }
    }
  } catch (e) {
    print('Error al recibir archivo con ubicaciones $e');
  }
  return false;

   */

}

List<Ubicacion> getLocationsMap() {
  return _listLocations;
}