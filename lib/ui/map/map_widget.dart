import 'dart:async';
import 'dart:io';

import 'package:Pasaporte_2020/config/config_definition.dart' as theme;
import 'package:Pasaporte_2020/model/location.dart';
import 'package:Pasaporte_2020/ui/map/widget/w_list_locations.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final List<UbicacionModel> listaUbicacion;

  MapWidget({Key key, @required this.listaUbicacion}) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final Duration timeOutGps = Duration(seconds: 5);
  MapType _defaultMapType = MapType.normal;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LatLng position = LatLng(-33.959853, -70.628015);
  double zoom = 16;
  Widget drawer;
  Widget mapWidget;
  Set<Marker> _markers = Set();
  final Completer<GoogleMapController> _controller = Completer();
  UbicacionModel selected;
  String distance;
  Geolocator geo = Geolocator();

  bool gpsEnabled;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    checkGPS();
  }

  @override
  Widget build(BuildContext context) {
    return mapWidget = Scaffold(
      key: _scaffoldKey,
      body: _getBody(),
      drawer: drawer = LocationsWidget(
        ubicaciones: widget.listaUbicacion,
        fubicacion: setPosition,
      ),
    );
  }

  Widget _getBody() {
    return Stack(
      children: <Widget>[
        GoogleMap(
//          polylines: _polyline,
          markers: _markers,
          mapType: _defaultMapType,
          myLocationEnabled: true,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          trafficEnabled: false,
          tiltGesturesEnabled: true,
          onMapCreated: onMapCreate,
          initialCameraPosition: CameraPosition(target: position, zoom: zoom),
          onCameraMove: _onGeoChanged,
        ),
        Container(
          //height: double.infinity,
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
              SizedBox(
                height: 10.0,
              ),
              FloatingActionButton(
                child: Icon(Icons.filter_center_focus),
                backgroundColor: theme.ScMapButtons.background,
                elevation: 10.0,
                onPressed: () {
                  _setCurrentLocation();
                },
              ),
            ],
          ),
        ),
        _creaCardDistancia(),
        getLoading(),
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

  Widget _popUpLayer() {
    return PopupMenuButton<MapType>(
      icon: Icon(Icons.layers),
      onSelected: (MapType result) {
        setState(() {
          _defaultMapType = result;
        });
      },
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry<MapType>>[
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

  Widget _creaTextoBoton(MapType mapTipo, String texto) {
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

  setPosition(UbicacionModel location) async {
    await loadDataSelected(location);
    print('Posicion nueva de camara ${location.nombre}');
  }

  Future<Set<Marker>> getLocations() async {
    Set<Marker> markers = Set();
    if (widget.listaUbicacion == null || widget.listaUbicacion.length <= 0)
      return markers;

    for (var i = 0; i < widget.listaUbicacion.length; i++) {
      UbicacionModel f = widget.listaUbicacion[i];
      var image;
      if (Platform.isIOS) {
        image = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
              size: Size(20.0, 30.0), platform: TargetPlatform.iOS),
          f.imagen,
        );
      } else {
        image = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
            size: Size(40.0, 60.0),
          ),
          f.imagen,
        );
      }

      markers.add(Marker(
          markerId: MarkerId(f.id),
          icon: image,
          position: f.getLatLong(),
          infoWindow: InfoWindow(title: '${f.nombre}'),
          onTap: () => loadDataSelected(f)


      ));
    }

    return markers;
  }

  void _onGeoChanged(CameraPosition cam) {}

  void onMapCreate(GoogleMapController controller) async {
    _controller.complete(controller);
    var markers = await getLocations();
    setState(() {
      _markers = markers;
    });
  }

  void _setCurrentLocation() async {
    setState(() {
      loading = true;
    });
    print('Esperando posicion');
    try {
      GoogleMapController controller = await _controller.future;
      gpsEnabled = await geo.isLocationServiceEnabled().timeout(timeOutGps);
      if (!gpsEnabled) {
        setState(() {
          loading = false;
        });
        return;
      }

      Position current = await geo
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium).timeout(
          timeOutGps);
      print('Encontrada posicion ${current.toString()}');

      LatLng ll = LatLng(current.latitude, current.longitude);
      controller.animateCamera(CameraUpdate.newLatLng(ll));
    } catch (ex) {
      print('Error al centrar posicion $ex');
    }
    setState(() {
      loading = false;
    });
  }

  Future<String> getDistance(UbicacionModel m) async {
    gpsEnabled = await geo.isLocationServiceEnabled().timeout(timeOutGps);
    if (!gpsEnabled) {
      return '';
    }
    String distanciaFinal = '';

    print('Esperando posicion');
    try {
      Position current = await geo
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high).timeout(
          timeOutGps);

      double distanciaMts = await geo.distanceBetween(
          current.latitude,
          current.longitude,
          m
              .getLatLong()
              .latitude,
          m
              .getLatLong()
              .longitude);

      if (distanciaMts >= 1000) {
        distanciaFinal =
            'a ' + (distanciaMts / 1000).toStringAsFixed(1) + ' kms';
      } else {
        distanciaFinal = 'a ' + distanciaMts.toStringAsFixed(0) + ' mts';
      }
      print('distancia calculada $distanciaFinal');
    } catch (ex) {
      print('Error al calcular distancia $ex');
    }
    return distanciaFinal;
  }

  Widget getLoading() {
    Color circleColor=theme.LoadingCircle.circleColor;
    if (loading) {
      return Center(
          child:CircularProgressIndicator(
          strokeWidth: 5.0,
          semanticsLabel: 'Calculando distancia',
          valueColor:AlwaysStoppedAnimation<Color>(circleColor)));

    /*
        return new Container(
          color: Colors.grey[300],
          width: 70.0,
          height: 70.0,
          child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
        );

         */
    }
    else{
    return Container();
    }
  }

  Widget _creaCardDistancia() {
    print('valor de loading $loading');
    if (selected == null) {
      return Container();
    }
    return selected != null ?
    Container(
      padding: EdgeInsets.only(bottom: 10.0),
      alignment: Alignment.bottomCenter,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding: EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
          child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * (gpsEnabled?0.30:0.15),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .50,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.clear),
                    ), onTap: () {
                    setState(() {
                      selected = null;
                      distance = null;
                    });
                  },),
                  Column(
                    children: <Widget>[
                      getIconGoogleMap(
                          url: selected.imagen, width: 40, height: 40),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          child: Text(
                            selected.nombre,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 5.0,
                      ),
                      (distance != null && distance.isNotEmpty ? Text(
                          "${distance}") : Container()),
                      SizedBox(
                        height: 10.0,
                      ),
                      (gpsEnabled?FloatingActionButton(
                        backgroundColor: theme.ScMapButtons.background,
                        child: Text(
                          'IR',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        elevation: 5.0,
                        onPressed: () {
                          //_cancelaIrUbicacion();
                        },
                      ):Container())
                    ],
                  )
                ],
              )),
        ),
      ),
    ) : Container();
  }

  void _showDialogGps(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("GPS"),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkGPS() async {
    //status=await geo.isLocationServiceEnabled();
    try {
      var status = await geo.checkGeolocationPermissionStatus().timeout(
          timeOutGps);
      if (status == GeolocationStatus.denied)
        _showDialogGps("Acceso bloqueado a GPS, debe otorgar permisos");
      else if (status == GeolocationStatus.disabled)
        _showDialogGps("GPS deshabilitado");
      else if (status == GeolocationStatus.restricted)
        _showDialogGps("Gps restringido");
      else if (status == GeolocationStatus.unknown)
        _showDialogGps("Gps desconocido");
      else if (status == GeolocationStatus.granted) {
        setState(() {
          gpsEnabled = true;
        });
      }
    } catch (ex) {
      print('error al ejecutar checkGPS ex');
      setState(() {
        gpsEnabled = false;
      });
    }
  }

  loadDataSelected(UbicacionModel f) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(f.getLatLong()));
    setState(() {
      loading = true;
    });
    String d = await getDistance(f);

    setState(() {
      selected = f;
      distance = d;
      gpsEnabled=!(d==null||d.isEmpty);
      loading = false;
    });
  }
}
