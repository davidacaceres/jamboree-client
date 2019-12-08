import 'package:Pasaporte_2020/config/config_definition.dart' as theme;
import 'package:Pasaporte_2020/model/location.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationsWidget extends StatefulWidget {
  final List<UbicacionModel> ubicaciones;
  final Function(UbicacionModel) fubicacion;
  const LocationsWidget({Key key,@required this.ubicaciones,@required this.fubicacion}) : super(key: key);

  @override
  _LocationsWidgetState createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  Widget drawer;


  @override
  void initState() {
    super.initState();
    if(drawer==null) {
      print('[LocationsWidget] init=> Creando panel con lista de ubicaciones');
      drawer = Drawer(
        elevation: 16.0,
        child: ListView(
          children: _listaItems(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return drawer;
  }

  List<Widget> _listaItems() {
    final List<Widget> opciones = [];
    opciones.add(Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Center(
        child: Text(
          'Ubicaciones',
          style: TextStyle(color: theme.ScMapTitleLocations.text, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
        color: theme.ScMapTitleLocations.background,
      ),
    ));

    if (widget.ubicaciones == null || widget.ubicaciones.isEmpty) {
      opciones.add(Container(
        padding: EdgeInsets.only(top: 100.0),
        child: Center(
          child: Text('No existen Ubicaciones'),
        ),
      ));

      return opciones;
    }

    widget.ubicaciones?.forEach((ubicacion) async {
      Widget widgetTemp = ListTile(
        key: Key(ubicacion.id.toString()),
        title: Text(ubicacion.nombre),
        leading:
        getIconGoogleMap(url: ubicacion.imagen, width: 40.0, height: 40.0),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          print('Mostrar ubicacion ${ubicacion.getLatLong()}');
          widget.fubicacion(ubicacion);
          // _irUbicacionNavegar(ubicacion);
           Navigator.pop(context);
        },
      );
      opciones..add(widgetTemp)..add(Divider());
    });

    return opciones;
  }


}
