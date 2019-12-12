import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:Pasaporte_2020/model/ubicacion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class _LocationsProvider {
  List<LocationView> _ubicacionesEntry;


  Future<List<LocationView>> getLocationsView() async {
    if (_ubicacionesEntry==null) {
      print('No se encuentran ubicaciones');
      List<Ubicacion> _ubicaciones = getLocationsMap();
      if(_ubicaciones==null || _ubicaciones.length<=0) return null;
      _ubicacionesEntry = [];
      for (int index = 0; index < _ubicaciones.length; index++) {
        Ubicacion ubE = _ubicaciones[index];
        LocationView cat = LocationView(ubE.categoria);
        cat.expand=ubE.expand;
        cat.imagen=ubE.imagen;
        List<LocationView> childs = [];
        for (int u = 0; u < ubE.locations.length; u++) {
          Location l = ubE.locations[u];
          LocationView child = LocationView(l.nombre);
          if (l.imagen != null && l.imagen.isNotEmpty) {
            child.imagen = l.imagen;
          }
          child.id = l.id;
          child.position = l.getLatLong();
          childs.add(child);
        }
        cat.children = childs;
        _ubicacionesEntry.add(cat);
      }
    }

    return _ubicacionesEntry;
  }
}

final locationProvider = new _LocationsProvider();

// One entry in the multilevel list displayed by this app.
class LocationView {
  LocationView(this.title, [this.children = const <LocationView>[]]);

  String id;
  final String title;
  LatLng position;
  String imagen;
  bool expand;
  List<LocationView> children;
}
