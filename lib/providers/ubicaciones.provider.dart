import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:Pasaporte_2020/model/location.dart';


class _UbicacionesProvider {
  Future<List<UbicacionModel>> obtenerListaUbicacionesLocal() async  {
//    final resp = await rootBundle.loadString('assets/json/locations_example.json');

//    return ubicacionFromJson(resp);
    return  getLocations();
  }
}

final ubicacionesProvider = new _UbicacionesProvider();