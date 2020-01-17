import 'dart:convert';
import 'dart:io';

import 'package:Pasaporte_2020/data/data_store.dart';
import 'package:Pasaporte_2020/model/version.dart';

Future<Version> getLocalVersion() async {
  try {
  print('[DM] Verificando version de sistema');
  File file = await getVersionFile();
  if (file != null) {
        var dataFile=file.readAsStringSync(encoding: utf8);
      Version v=Version.fromJson(dataFile);
      return v;
  }
  } catch (ex) {
  print('[DM] Error al leer archivo de version local $ex');
  }
  return null;
}


Future<bool> saveVersion(Version version) async {
  try {
    await writeLocalVersion(version.toJson());
    print('[DM] Version guardada en archivo local : ${version.toString()}');
    return true;
  } catch (error) {
    print('[DM] Error al guardar version desde internet $error');
  }
  return false;
}
