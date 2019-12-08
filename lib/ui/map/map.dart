import 'dart:async';
import 'dart:io';

import 'package:Pasaporte_2020/model/location.dart';
import 'package:Pasaporte_2020/ui/map/alert_util.dart' as alertUtil;
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:Pasaporte_2020/config/config_definition.dart' as theme;

class MapsWidget extends StatefulWidget {
  final List<UbicacionModel> listaUbicacion;
  MapsWidget({Key key, @required this.listaUbicacion}) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  Timer timerNavegar;
  final Completer<GoogleMapController> _controller = Completer();
  MapType _defaultMapType = MapType.normal;
  double _zoom = 16;
  double _bearing = 0.0;
  Set<Marker> _markers = Set();
  Set<Polyline> _polyline = Set();
  List<LatLng> latlngList = List();
  final Geolocator geolocator = Geolocator();
  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(-33.959853, -70.628015), zoom: 16);
  Drawer _drawer;

  bool _verCard = false;
  String _msgDistancia = '';
  String _msgNombre = '';
  Image _msgIcon;
  //String _msgDetalles = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _validaGPS();
    _drawer = _getDrawer();
    _posicionPropia();
  }

  _validaGPS() async {
    bool result = await geolocator.isLocationServiceEnabled();
    if (!result) {
      alertUtil.showAlertNotGps(
          context, 'Ubicación GPS no activada.', Icons.error);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

/* Metodo encargado de obtener la ubicacion actual del dispositivo para desplegar el mapa */
  _posicionPropia() async {
    Position userLocation = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: _zoom)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: _getBody(),
      drawer: _drawer,
    );
  }

/* Metodo encargado de crear el body con el mapa */
  Widget _getBody() {
    return Stack(
      children: <Widget>[
        GoogleMap(
          polylines: _polyline,
          markers: _markers,
          mapType: _defaultMapType,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: _initialPosition,
          onCameraMove: _onGeoChanged,
        ),
        Container(
          height: double.infinity,
          margin: EdgeInsets.only(
              bottom: Platform.isIOS ? 80.0 : 10.0, right: 10.0),
          alignment: Alignment.centerRight,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SizedBox(),
              ),
              FloatingActionButton(
                backgroundColor: theme.ScMapButtons.background,
                elevation: 10.0,
                child: _popUpLayer(),
                onPressed: () {},
              ),
              SizedBox(
                height: 10.0,
              ),
              FloatingActionButton(
                child: Icon(Icons.list),
                backgroundColor: theme.ScMapButtons.background,
                elevation: 10.0,
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
            ],
          ),
        ),
        _creaCardDistancia(),
        Container(
          height: double.infinity,
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  /*Metodo encargado de crear el card que entrega la distancia a la ubicacion */
  Widget _creaCardDistancia() {
    return _verCard
        ? Container(
            padding: EdgeInsets.only(bottom: 10.0),
            alignment: Alignment.bottomCenter,
            child: Card(
              color: Colors.white70,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
                child: SizedBox(
                  height: 160.0,
                  child: Column(
                    children: <Widget>[
                      _msgIcon != null ? _msgIcon : Container(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        _msgNombre,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(_msgDistancia),
                      SizedBox(
                        height: 10.0,
                      ),
                      FloatingActionButton(
                        child: Text(
                          'Detener',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        elevation: 5.0,
                        onPressed: () {
                          _cancelaIrUbicacion();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

/* Metodo encargado de eschucar el cambio de zoom y bearing */
  void _onGeoChanged(CameraPosition position) {
    setState(() {
      _zoom = position.zoom;
      _bearing = position.bearing;
    });
  }

/* Metodo encargado de Crear el Drawer lateral */
  Widget _getDrawer() {
    return Drawer(
      elevation: 16.0,
      child: ListView(
        children: _listaItems(widget.listaUbicacion),
      ),
    );
  }

/* Metodo encargado de crear los items del Drawer */
  List<Widget> _listaItems(List<UbicacionModel> data) {
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

    if (data == null || data.isEmpty) {
      opciones.add(Container(
        padding: EdgeInsets.only(top: 100.0),
        child: Center(
          child: Text('No existen Ubicaciones'),
        ),
      ));

      return opciones;
    }

    data?.forEach((ubicacion) async {
      Widget widgetTemp = ListTile(
        key: Key(ubicacion.id.toString()),
        title: Text(ubicacion.nombre),
        leading:
            getIconGoogleMap(url: ubicacion.imagen, width: 40.0, height: 40.0),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          _irUbicacionNavegar(ubicacion);
          Navigator.pop(context);
        },
      );
      opciones..add(widgetTemp)..add(Divider());
    });

    return opciones;
  }

/* Metodo encargado de crear el mapa desde el controller */
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

/* Metodo encargado de navegar mi ubicacion hacia la ubicación */
  _irUbicacionNavegar(UbicacionModel ubicacion) {
    // _cancelaIrUbicacion();

    if (timerNavegar != null && timerNavegar.isActive) {
      timerNavegar.cancel();
      setState(() {
        _verCard = false;
        _msgDistancia = '';
        _msgNombre = '';
        _markers.clear();
        _markers = Set();
        _polyline.clear();
        _polyline = Set();
        latlngList.clear();
      });
    } else {
      timerNavegar = Timer.periodic(Duration(seconds: 2), (timer) async {
        Position userLocation = await geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);

        if (userLocation != null) {
          if (timerNavegar != null && timerNavegar.isActive) {
            print(ubicacion.nombre);
            _irUbicacion(ubicacion, userLocation);
          } else {
            _cancelaIrUbicacion();
          }
        }
      });
    }
  }

/* Metodo encargado de demarcar linea de distancia entre puntos. */
  Future<void> _irUbicacion(
      UbicacionModel ubicacion, Position userLocation) async {
    GoogleMapController controller = await _controller.future;

    setState(() {
      // _msgDetalles = 'speed: ${userLocation.speed} - speedCurrent: ${userLocation.speedAccuracy} - bearing: ${userLocation.heading}';
      if (userLocation.speed > 1) {
        _bearing = userLocation.heading;
      }
    });

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: _zoom,
        bearing: _bearing,
        tilt: 55.0)));

    double distanciaMts = await Geolocator().distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        ubicacion.getLatLong().latitude,
        ubicacion.getLatLong().longitude);

    String distanciaFinal = '';
    if (distanciaMts >= 1000) {
      distanciaFinal = (distanciaMts / 1000).toStringAsFixed(1) + ' kms';
    } else {
      distanciaFinal = distanciaMts.toStringAsFixed(0) + ' mts';
    }

    setState(() {
      _markers.clear();
      _markers = Set();
      _polyline.clear();
      _polyline = Set();
      latlngList.clear();
    });

    setState(() {
      latlngList.add(LatLng(userLocation.latitude, userLocation.longitude));
      latlngList.add(LatLng(
          ubicacion.getLatLong().latitude, ubicacion.getLatLong().longitude));

      _polyline.add(Polyline(
        polylineId: PolylineId('${ubicacion.id}-linea'),
        visible: true,
        points: latlngList,
        color: Colors.blue,
        width: 4,
      ));

      _markers.add(Marker(
        markerId: MarkerId('${ubicacion.id}'),
        position: ubicacion.getLatLong(),
        // icon: BitmapDescriptor.fromBytes(
        //     Uri.parse(ubicacion.imagen).data.contentAsBytes()),
        infoWindow: InfoWindow(
            title: '${ubicacion.nombre}',
            snippet: 'A $distanciaFinal desde mi ubicación.'),
      ));
      _msgDistancia = 'A $distanciaFinal desde mi ubicación.';
      _msgIcon =
          getIconGoogleMap(url: ubicacion.imagen, width: 40.0, height: 40.0);
      _msgNombre = ubicacion.nombre;
      _verCard = true;
    });
  }

  void _cancelaIrUbicacion() async {
    GoogleMapController controller = await _controller.future;
    Position userLocation = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    if (timerNavegar != null && timerNavegar.isActive) {
      timerNavegar.cancel();
      setState(() {
        _verCard = false;
        _msgDistancia = '';
        _msgNombre = '';
        _markers.clear();
        _markers = Set();
        _polyline.clear();
        _polyline = Set();
        latlngList.clear();
      });
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: _zoom,
        bearing: _bearing,
        tilt: 0.0)));
    setState(() {
      _verCard = false;
      _msgDistancia = '';
      _msgNombre = '';
      _markers.clear();
      _markers = Set();
      _polyline.clear();
      _polyline = Set();
      latlngList.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timerNavegar != null && timerNavegar.isActive) {
      timerNavegar.cancel();
    }
  }

/* Metodo encargado de cambiar el tipo de mapa */
  Widget _popUpLayer() {
    return PopupMenuButton<MapType>(
      icon: Icon(Icons.layers),
      onSelected: (MapType result) {
        setState(() {
          _defaultMapType = result;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
        PopupMenuItem<MapType>(
          value: MapType.normal,
          child: _creaTextoBoton(MapType.normal, 'Normal'),
        ),
        PopupMenuDivider(),
        PopupMenuItem<MapType>(
          value: MapType.satellite,
          child: _creaTextoBoton(MapType.satellite, 'Satélite'),
        ),
        PopupMenuDivider(),
        PopupMenuItem<MapType>(
          value: MapType.terrain,
          child: _creaTextoBoton(MapType.terrain, 'Terreno'),
        ),
      ],
    );
  }

  _creaTextoBoton(MapType mapTipo, String texto) {
    return Row(
      children: <Widget>[
        Checkbox(
          checkColor: theme.ScMapSelectedCheckbox.checkColor,
          activeColor: theme.ScMapSelectedCheckbox.activeColor,
          value: mapTipo == _defaultMapType,
          onChanged: (valor) {
            if (valor) {
              setState(() {
                _defaultMapType = mapTipo;
                Navigator.pop(context);
              });
            }
          },
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          texto,
        ),
      ],
    );
  }
}
