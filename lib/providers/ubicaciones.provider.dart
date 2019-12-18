import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:Pasaporte_2020/model/ubicacion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class _LocationsProvider {
  bool loaded=false;
  List<LocationView> _ubicacionesEntry;


  Future<List<LocationView>> getLocationsView() async {
    if (_ubicacionesEntry==null && !loaded) {
      print('No se encuentran ubicaciones para el widget, se intentara carcar nuevamente');
      List<Ubicacion> _ubicaciones = dataProvider.getLocationsMap();
      if(_ubicaciones==null || _ubicaciones.length<=0) return null;
      _ubicacionesEntry = [];
      for (int index = 0; index < _ubicaciones.length; index++) {
        Ubicacion ubE = _ubicaciones[index];
        LocationView cat = LocationView(ubE.category);
        cat.expand=ubE.expand;
        cat.imagen=ubE.image;
        List<LocationView> childs = [];
        for (int u = 0; u < ubE.locations.length; u++) {
          Location l = ubE.locations[u];
          LocationView child = LocationView(l.title);
          if (l.image != null && l.image.isNotEmpty) {
            child.imagen = l.image;
          }
          child.id = l.id;
          child.position = l.getLatLong();
          childs.add(child);
        }
        cat.children = childs;
        _ubicacionesEntry.add(cat);
      }
      loaded=true;
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
