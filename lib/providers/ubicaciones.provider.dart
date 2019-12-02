import 'package:Pasaporte_2020/model/location.dart';
import 'package:flutter/services.dart' show rootBundle;


class _UbicacionesProvider {
  Future<List<UbicacionModel>> obtenerListaUbicacionesLocal() async {
    final resp = await rootBundle.loadString('assets/json/locations_example.json');

    return ubicacionFromJson(resp);
  }
}

final ubicacionesProvider = new _UbicacionesProvider();