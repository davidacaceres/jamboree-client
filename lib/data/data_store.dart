import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Pasaporte_2020/model/version.dart';
import 'package:path_provider/path_provider.dart';


Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localDataFile async {
  print('[DS] Cargando archivo de contenido local');

  final path = await _localPath;
  return File('$path/local_data.json');
}


Future<File> get _localLocationFile async {
  print('[DS] ******** Cargando archivo de ubicaciones local');

  final path = await _localPath;
  return File('$path/local_locations.json');
}

Future<File> get _localVersionFile async {
  print('[DS] ******** Cargando archivo de Version local');

  final path = await _localPath;
  return File('$path/local_version.json');
}


Future<File> getVersionFile() async{
  return await _localVersionFile;
}

Future<File> getDataFile() async{
  return await _localDataFile;
}
Future<File> writeLocalData(String data) async {
  print('[DS] ******** Escribiendo archivo de contenido');
  final file = await _localDataFile;

  // Write the file
  return file.writeAsString(data,encoding: utf8);
}


Future<File> writeLocalLocations(String locationsJson) async {
  print('[DS] ******** Escribiendo archivo de ubicaciones');
  final file = await _localLocationFile;
  return file.writeAsString(locationsJson);
}


Future<File> writeLocalVersion(Version versionJson) async {
  print('[DS] ******** Escribiendo archivo de version');
  final file = await _localLocationFile;
  return file.writeAsString(versionJson.toString());
}
