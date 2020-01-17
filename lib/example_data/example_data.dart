import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:Pasaporte_2020/example_data/manage_locations.dart';
import 'package:Pasaporte_2020/example_data/manager_contents.dart';
import 'package:Pasaporte_2020/example_data/manager_version.dart';
import 'package:Pasaporte_2020/example_data/url_files.dart' as urls;
import 'package:Pasaporte_2020/model/carrousel.dart';
import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/model/ubicacion.dart';
import 'package:Pasaporte_2020/model/version.dart';
import 'package:http/http.dart' as http;

class _ExamplesProvider {
  final List<Content> _listContent = [];
  final List<Ubicacion> _listUbicaciones = [];

  final List<Carrousel> _listCarrousel = [
    new Carrousel(order: 1, image: "assets/img/carousel/imagen_1.jpg"),
    new Carrousel(order: 2, image: "assets/img/carousel/imagen_2.jpg"),
    new Carrousel(order: 3, image: "assets/img/carousel/imagen_3.jpg"),
    new Carrousel(order: 4, image: "assets/img/carousel/imagen_4.jpg"),
    new Carrousel(order: 5, image: "assets/img/carousel/imagen_5.jpg"),
    new Carrousel(order: 6, image: "assets/img/carousel/imagen_6.jpg")
  ];
  final ListQueue<String> _listHistory = new ListQueue(10);

  Version version;

  List<Content> getExampleContent() {
    return _listContent;
  }

  List<Content> getExampleRootContent() {
    List<Content> list =
        _listContent.where((i) => i.root != null && i.root == true).toList();
    print('[CONT] buscando contenido root se encontraron ${list.length}');
    return list;
  }

  List<Content> getExampleSearchContent(String search) {
    if (search == null || search.isEmpty) return [];

    Set<Content> resultado = Set<Content>();
    List<String> palabras = search.split(" ");

    List<Set<Content>> resultados = [];

    for (int u = 0; u < palabras.length; u++) {
      print('[CONT] BUSCANDO PALABRA ${palabras[u]}');
      Set<Content> rPalabra = _listContent
          .where((i) =>
              i.search != null &&
              i.search.toLowerCase().contains(palabras[u].toLowerCase()))
          .toSet();

      print(
          '[CONT] ${rPalabra.length} COINCIDENCIAS ENCONTRADAS PARA PALABRA ${palabras[u]} ');
      if (rPalabra.length > 0) {
        resultados.add(rPalabra);
      }
    }
    if (resultados.isNotEmpty) {
      resultado.addAll(resultados[0]);
      resultados.forEach((element) {
        resultado = resultado.intersection(element);
      });
      addExampleHistory(search);
    }

    print('[CONT] RESULTADO BUSQUEDA DE $search total: ${resultado.length}');

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

  Future<int> loadContents(Version rVersion, Version lVersion) async {
    if (lVersion == null && rVersion == null) {
      /// Cuando no hay conexion a internet y no hay version local
      List<Content> contentsFile = await loadContentsFromAssets();
      if (contentsFile != null && contentsFile.isNotEmpty) {
        _listContent.clear();
        _listContent.addAll(contentsFile);
        version = new Version(
            description: 'Version de Assets', content: 1.0, location: 1.0);
        return 1;
      }
    } else if (lVersion == null && rVersion != null) {
      /// Cuando no se ha bajado version y hay conexion a internet con verison.
      List<Content> contentsUrl = await loadContentsFromUrl();
      if (contentsUrl != null && contentsUrl.isNotEmpty) {
        _listContent.clear();
        _listContent.addAll(contentsUrl);
        await saveContent(contentsUrl);
        await saveVersion(rVersion);
        version = rVersion;
        return 2;
      }
    } else if (lVersion != null && rVersion == null) {
      /// Cuando se ha bajado la version, pero no hay conexion a internet
      List<Content> contentsFile = await loadContentsFromFile();
      if (contentsFile != null && contentsFile.isNotEmpty) {
        _listContent.clear();
        _listContent.addAll(contentsFile);
        version = lVersion;
        return 3;
      }
    } else if (lVersion != null && rVersion != null) {
      /// Hay conexion y existe una version local.
      if (lVersion.content != rVersion.content) {
        ///Existe diferencia en versiones
        List<Content> contentsUrl = await loadContentsFromUrl();
        if (contentsUrl != null && contentsUrl.isNotEmpty) {
          _listContent.clear();
          _listContent.addAll(contentsUrl);
          await saveContent(contentsUrl);
          await saveVersion(rVersion);
          version = rVersion;
          return 4;
        }
      } else {
        /// La version en internet es la misma que la local.
        List<Content> contentsFile = await loadContentsFromFile();
        if (contentsFile != null && contentsFile.isNotEmpty) {
          _listContent.clear();
          _listContent.addAll(contentsFile);
          version = rVersion;
          return 5;
        }
      }

      if (_listContent.length <= 0) {
        List<Content> contentsFile = await loadContentsFromAssets();
        if (contentsFile != null && contentsFile.isNotEmpty) {
          _listContent.clear();
          _listContent.addAll(contentsFile);
          version = new Version(
              description: 'Version de Assets', content: 1.0, location: 1.0);
          return 98;
        }
      }
    }
    return 99;
  }

  Future<Version> loadVersionUrl() async {
    try {
      bool connected = false;
      try {
        final result = await InternetAddress.lookup(urls.url_server)
            .timeout(Duration(seconds: 5));
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print(
              '[DM] connected to ${urls.url_server} to download version file');
          connected = !connected;
        }
      } catch (ex) {
        print(
            '[DM] not connected to ${urls.url_server} to download version file [$ex]');
        return null;
      }
      if (connected) {
        Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptCharsetHeader: "utf-8" // or whatever
        };
        final response = await http
            .get(urls.url_version, headers: headers)
            .timeout(Duration(seconds: 5));
        if (response.statusCode == 200) {
          print("[DM] Se encontro archivo de version en ${urls.url_version}");
          try {
            Version version = Version.fromJson(response.body);
            print('[DM] Finalizo la carga de la version con $version');
            return version;
          } catch (ex) {
            print("[DM] No se pudo transformar archivo de version $ex");
          }
        } else {
          print(
              '[DM] Server respondio ${response.statusCode}  sin archivo de version');
        }
      }
    } catch (e) {
      print('[DM] Error al recibir archivo con version $e');
    }
    return null;
  }

  Future<int> loadUbicaciones(Version rVersion, Version lVersion) async {
    if (lVersion == null && rVersion == null) {
      /// Cuando no hay conexion a internet y no hay version local
      List<Ubicacion> ubicacionesFile = await loadUbicacionesFromAssets();
      if (ubicacionesFile != null && ubicacionesFile.isNotEmpty) {
        _listUbicaciones.clear();
        _listUbicaciones.addAll(ubicacionesFile);
        return 1;
      }
    } else if (lVersion == null && rVersion != null) {
      /// Cuando no se ha bajado version y hay conexion a internet con verison.
      List<Ubicacion> ubicacionesUrl = await loadUbicacionesFromUrl();
      if (ubicacionesUrl != null && ubicacionesUrl.isNotEmpty) {
        _listUbicaciones.clear();
        _listUbicaciones.addAll(ubicacionesUrl);
        await saveLocations(ubicacionesUrl);
        return 2;
      }
    } else if (lVersion != null && rVersion == null) {
      /// Cuando se ha bajado la version, pero no hay conexion a internet
      List<Ubicacion> ubicacionesFile = await loadUbicacionesFromFile();
      if (ubicacionesFile != null && ubicacionesFile.isNotEmpty) {
        _listUbicaciones.clear();
        _listUbicaciones.addAll(ubicacionesFile);
        return 3;
      }
    } else if (lVersion != null && rVersion != null) {
      /// Hay conexion y existe una version local.
      if (lVersion.location != rVersion.location) {
        ///Existe diferencia en versiones
        List<Ubicacion> ubicacionesUrl = await loadUbicacionesFromUrl();
        if (ubicacionesUrl != null && ubicacionesUrl.isNotEmpty) {
          _listUbicaciones.clear();
          _listUbicaciones.addAll(ubicacionesUrl);
          await saveLocations(ubicacionesUrl);
          return 4;
        }
      } else {
        /// La version en internet es la misma que la local.
        List<Ubicacion> ubicacionesFile = await loadUbicacionesFromFile();
        if (ubicacionesFile != null && ubicacionesFile.isNotEmpty) {
          _listUbicaciones.clear();
          _listUbicaciones.addAll(ubicacionesFile);
          return 5;
        }
      }
    }
    return 99;
  }

  Future<int> loadLocationsOld(Version rVersion) async {
    print('[LOC]Cargando Ubicaciones');
    try {
      bool connected = false;
      try {
        final result = await InternetAddress.lookup(urls.url_server);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('[LOC] Connected to ${urls.url_server} to download locations');
          connected = !connected;
        }
      } on SocketException catch (_) {
        print('[LOC] Not connected to ${urls.url_server}');
      }
      if (connected) {
        Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptCharsetHeader: "utf-8" // or whatever
        };
        print('[LOC] Llamando url internet para descargar ubicaciones');
        final response = await http.get(urls.url_location, headers: headers);
        if (response.statusCode == 200) {
          print(
              "[LOC] Se encontro archivo de ubicaciones en ${urls.url_location}");
          var jStringList = json.decode(utf8.decode(response.bodyBytes));
          try {
            _listUbicaciones.clear();
            for (int u = 0; u < jStringList.length; u++) {
              try {
                Ubicacion ubica = Ubicacion.fromMap(jStringList[u]);
                if (!_listUbicaciones.contains(ubica))
                  _listUbicaciones.add(ubica);
              } catch (ex1) {
                print(
                    '[LOC] error al procesar registro de ubicacion : ${jStringList[u]}   [ERROR: $ex1]');
              }
            }
          } catch (ex) {
            print('[LOC] Error al transformar ubicacion a json $ex');
          }
          print(
              '[LOC] Finalizo la carga de  ubicaciones con ${_listUbicaciones.length} ubicaciones');
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
    return _listUbicaciones;
  }

  Future<int> loadData() async {
    print('[LOAD DATA] +++++++ Cargando datos');
    Version rversion = await loadVersionUrl();
    Version lVersion = await getLocalVersion();

    print('VERSION    INTERNET: $rversion');
    print('VERSION    LOCAL   : $lVersion');
    int value1;
    int value2;
    print('[LOAD DATA] Cargando deatos para contenido y ubicaciones');
    try {
      value2 = await loadContents(rversion, lVersion);
    } catch (ex) {
      print('[LOAD DATA] Error al cargar Contenido $ex');
    }
    try {
      value1 = await loadUbicaciones(rversion, lVersion);
    } catch (ex) {
      print('[LOAD DATA] Error al cargar ubicaciones $ex');
    }
    return value1 + value2;
  }
}

final dataProvider = _ExamplesProvider();
