import 'dart:convert';
import 'dart:io';

import 'package:Pasaporte_2020/model/carrousel.dart';
import 'package:Pasaporte_2020/model/content.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

final List<Content> _listContent =[];

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
  return _listContent.where((i) => i.search!=null && i.search.contains(search.toLowerCase())).toList();
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
  print('cargando contenido');
  String jsondata= await rootBundle.loadString('assets/json/data_test.json');

  var jStringList = json.decode(jsondata);
  for (int u =0; u < jStringList.length ; u++ ) {
    print('cargando elemento $u \n ${jStringList[u]}');
    Content content=Content.fromMap(jStringList[u]);
    _listContent.add(content);

  }
  print('Finalizo la carga del contenido');
  return true;
}

Future<bool> loadContentUrl() async {
  //loadContentAsset();
  //return true;
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
        print(response.body);

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

