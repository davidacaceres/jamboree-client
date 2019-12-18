
import 'package:Pasaporte_2020/providers/ubicaciones.provider.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';

class LocationsWidget extends StatefulWidget {
  final List<LocationView> ubicaciones;
  final Function(LocationView) fubicacion;

  const LocationsWidget(
      {Key key, @required this.ubicaciones, @required this.fubicacion})
      : super(key: key);

  @override
  _LocationsWidgetState createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  Widget drawer;

  @override
  void initState() {
    super.initState();
    if (drawer == null) {
      print('[LocationsWidget] init=> Creando panel con lista de ubicaciones');
      drawer = Drawer(
        elevation: 16.0,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(widget.ubicaciones[index], context, widget.fubicacion),
          itemCount: widget.ubicaciones.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return drawer;
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this.context, this.fubicacion);

  final Function(LocationView) fubicacion;

  final BuildContext context;
  final LocationView entry;

  Widget _buildTiles(LocationView root) {
    if (root.children == null || root.children.isEmpty)
      return ListTile(
        title: Container(child:Text(root.title,overflow: TextOverflow.visible,)),
        leading: (root.imagen == null || root.imagen.isEmpty
            ? Container()
            : getIconGoogleMap(url: root.imagen, width: 30.0, height: 30.0)),
      );
    return ExpansionTile(
      key: PageStorageKey<LocationView>(root),
      initiallyExpanded: root.expand,
      title: Container(child:Text(root.title,overflow: TextOverflow.visible,)),
      leading: (root.imagen == null || root.imagen.isEmpty
          ? SizedBox()
          : getIconGoogleMap(url: root.imagen, width: 30.0, height: 30.0)),
      children: _buildChilds(entry.children),
    );
  }

  List<Widget> _buildChilds(List<LocationView> list) {
    List<Widget> childs = [];
    list?.forEach((ubicacion) {
      childs.add(ListTile(
        key: Key(ubicacion.id.toString()),
        title: Text(ubicacion.title),
        leading:
            getIconGoogleMap(url: ubicacion.imagen, width: 30.0, height: 30.0),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14,
        ),
        onTap: () {
          print('Mostrar ubicacion');
          // _irUbicacionNavegar(ubicacion);
          fubicacion(ubicacion);
          Navigator.pop(context);
        },
      ));
    });
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
