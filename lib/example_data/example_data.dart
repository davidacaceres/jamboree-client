import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:Pasaporte_2020/model/carrousel.dart';
import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/model/ubicacion.dart';
import 'package:http/http.dart' as http;

class _ExamplesProvider {



  final List<Content> _listContent = [];
  final List<Ubicacion> _listLocations = [];

  final List<Carrousel> _listCarrousel = [
    new Carrousel(order: 1, image: "assets/img/carousel/imagen_1.jpg"),
    new Carrousel(order: 2, image: "assets/img/carousel/imagen_2.jpg"),
    new Carrousel(order: 3, image: "assets/img/carousel/imagen_3.jpg"),
    new Carrousel(order: 4, image: "assets/img/carousel/imagen_4.jpg"),
    new Carrousel(order: 5, image: "assets/img/carousel/imagen_5.jpg"),
    new Carrousel(order: 6, image: "assets/img/carousel/imagen_6.jpg")
  ];
  final ListQueue<String> _listHistory = new ListQueue(10);

  List<Content> getExampleContent() {
    return _listContent;
  }

  List<Content> getExampleRootContent() {
    List<Content> list= _listContent.where((i) => i.root != null && i.root == true).toList();
    print('[CONT] buscando contenido root se encontraron ${list.length}');
    return list;
  }

  List<Content> getExampleSearchContent(String search) {
  if(search==null || search.isEmpty) return [];

    Set<Content> resultado = Set<Content>();
    List<String> palabras=search.split(" ");

    List<Set<Content>> resultados= [];

    for (int u = 0; u < palabras.length; u++) {
      print('[CONT] BUSCANDO PALABRA ${palabras[u]}');
      Set<Content> rPalabra = _listContent
          .where((i) =>
      i.search != null &&
          i.search.toLowerCase().contains(palabras[u].toLowerCase())).toSet();

      print('[CONT] ${rPalabra.length} COINCIDENCIAS ENCONTRADAS PARA PALABRA ${palabras[u]} ');
      if(rPalabra.length>0)
        {
          resultados.add(rPalabra);
        }
    }

    resultado.addAll(resultados[0]);
    resultados.forEach((element){
      resultado= resultado.intersection(element);

    });


    print('[CONT] RESULTADO BUSQUEDA DE $search total: ${resultado.length}');

    addExampleHistory(search);

    return resultado.toList();
  }

  List<Carrousel> getExampleCarrousel() {
    return _listCarrousel;
  }

  List<String> getExampleHistory() {
    print('[HIST] retornando lista de historia de busqueda');
    return _listHistory.toList();
  }

  addExampleHistory(String searchText) {
    print('[HIST] Agregando a historia de busqueda $searchText');
    if (_listHistory.length > 10) {
      _listHistory.removeFirst();
    }
    if (!_listHistory.contains(searchText)) _listHistory.add(searchText);
  }

  Content findExampleContent(String id) {
    print('[CONT] Buscando id $id');
    return _listContent.singleWhere((e) => e.id == id);
  }

  Future<int> loadContentUrl() async {

    print("[CONT] Iniciando carga de contenido");
    try {
      bool connected = false;
      try {
        final result = await InternetAddress.lookup("jamboree.cl")
            .timeout(Duration(seconds: 5));
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('[CONT] connected to parlamento.jamboree.cl');
          connected = !connected;
        }
      } catch (ex) {
        print('[CONT] not connected to parlamento.jamboree.cl $ex');
      }
      if (connected) {
        Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptCharsetHeader: "utf-8" // or whatever
        };
        try {
          final response = await http
              .get('http://pasaporte.jamboree.cl/data.json',
                  headers: headers)
              .timeout(Duration(seconds: 15));
          if (response.statusCode == 200) {
            print(
                "[CONT] Se encontro archivo en parlamento.jamboree.cl con informacion de actualizacion");
            // print(response.body);

            var jStringList = json.decode(utf8.decode(response.bodyBytes));
            _listContent.clear();

            for (int u = 0; u < jStringList.length; u++) {
              Content content = Content.fromMap(jStringList[u]);
              if(!_listContent.contains(content))
                _listContent.add(content);
            }
            print('[CONT] Finalizo la carga del contenido con ${_listContent.length} items');
          }
        } catch (ex1) {
          print('[CONT] Error al cargar contenido $ex1');
        }
      }
    } catch (e) {
      print('[CONT] Error al recibir archivo con informacion de actualizacion');
    }
    return 0;
  }

  Future<int> loadLocationsUrl() async {
    print('[LOC]Cargando Ubicaciones');
    try {
      bool connected = false;
      try {
        final result = await InternetAddress.lookup("jamboree.cl");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print(
              '[LOC] Connected to parlamento.jamboree.cl to download content');
          connected = !connected;
        }
      } on SocketException catch (_) {
        print('[LOC] Not connected to parlamento.jamboree.cl');
      }
      if (connected) {
        Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptCharsetHeader: "utf-8" // or whatever
        };
        print('[LOC] Llamando url internet para descargar ubicaciones');
        final response = await http.get(
            'http://pasaporte.jamboree.cl/locations.json',
            headers: headers);
        if (response.statusCode == 200) {
          print(
              "[LOC] Se encontro archivo de ubicaciones en parlamento.jamboree.cl");
          var jStringList = json.decode(utf8.decode(response.bodyBytes));
          try {_listLocations.clear();
            for (int u = 0; u < jStringList.length; u++) {
              try {
                Ubicacion ubica = Ubicacion.fromMap(jStringList[u]);
                if (!_listLocations.contains(ubica))
                  _listLocations.add(ubica);
              }catch(ex1){
                print('[LOC] error al procesar registro de ubicacion : ${jStringList[u]}   [ERROR: $ex1]');
              }
            }
          } catch (ex) {
            print('[LOC] Error al transformar ubicacion a json $ex');
          }
          print(
              '[LOC] Finalizo la carga de  ubicaciones con ${_listLocations.length} ubicaciones');
          return 2;
        } else {
          print(
              '[LOC] Server respondio ${response.statusCode}  sin archivo de ubicaciones');
          return 1;
        }
      }
    } catch (e) {
      print('[LOC] Error al recibir archivo con ubicaciones $e');
    }
    return 0;
  }

  List<Ubicacion> getLocationsMap() {
    return _listLocations;
  }

  Future<int> loadData() async {
    print('[LOAD DATA] +++++++ Cargando datos');
    int value1;
    int value2;
    /*
    if (!_loaded) {
      print('[LOAD DATA] ******* Marca de incio de carga realizada');
      _loaded = !_loaded;
    } else {
      print('[LOAD DATA] !!!!!! Ya se realizzo la carga, esperando a que termine');
      return -99;
    }*/
    print('[LOAD DATA] Cargando deatos para contenido y ubicaciones');
    bool result;
    try {
      value1= await loadLocationsUrl();
      print('[LOAD DATA] retorno loadLocationsUrl $result');
    } catch (ex) {
      print('[LOAD DATA] Error al cargar ubicaciones $ex');
    }
    try {
      value2=await loadContentUrl();
      print('[LOAD DATA] retorno loadContentUrl $result');
    }catch(ex){
      print('[LOAD DATA] Error al cargar Contenido $ex');

    }
    return value1+value2;
  }

}

final dataProvider = _ExamplesProvider();
