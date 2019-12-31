import 'dart:async';
import 'dart:io';

import 'package:Pasaporte_2020/config/config_definition.dart' as theme;
import 'package:Pasaporte_2020/providers/ubicaciones.provider.dart';
import 'package:Pasaporte_2020/ui/map/widget/w_list_locations.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final List<LocationView> listaUbicacion;

  MapWidget({Key key, @required this.listaUbicacion}) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final Duration timeOutGps = Duration(seconds: 5);
  StreamSubscription<Position> posStream;
  MapType _defaultMapType = MapType.normal;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LatLng position = LatLng(-33.959853, -70.628015);
  double zoom = 16;
  Widget drawer;
  Widget mapWidget;
  Set<Marker> _markers = Set();
  final Completer<GoogleMapController> _controller = Completer();
  LocationView selectedLocation;
  Image selectedImage;
  String selectedDistance;
  Geolocator geo = Geolocator();

  bool gpsEnabled;

  bool loading = false;

  Set<Polyline> _routeNavigator = Set();

  bool isNavigation = false;

  LocationView previewLocation;
  String previewDistance;
  Image previewImage;

  double lastHeading;

  @override
  void initState() {
    super.initState();
  //  checkGPS();
  }

  @override
  void dispose() {
    print('limpiando con dispose');

    posStream?.cancel();
    isNavigation = false;
    _routeNavigator.clear();
    selectedLocation = null;
    selectedDistance = null;
    selectedImage = null;
    super.dispose();
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
          polylines: _routeNavigator,
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
          margin: EdgeInsets.only(bottom: 80.0, right: 10.0),
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
                child: Image.asset('assets/img/locations/App_contenido.png'),
                backgroundColor: theme.ScMapButtons.background,
                elevation: 10.0,
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              FloatingActionButton(
                child: Image.asset('assets/img/locations/App_ubicacion.png'),
                backgroundColor: theme.ScMapButtons.background,
                elevation: 10.0,
                onPressed: () {
                  _setCurrentLocation();
                },
              ),
            ],
          ),
        ),
        (isNavigation != null && isNavigation
            ? _makeCardNavigation()
            : Container()),
        (previewLocation != null ? _showCardPreview() : Container()),
        getLoading(),
        Container(
          height: double.infinity,
          padding: EdgeInsets.only(left: 5.0),
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
      //icon: new Image.asset('images/icons/logout.png'),
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

  setPosition(LocationView location) async {
    await loadDataPreview(location);
    print('Posicion nueva de camara ${location.title}');
  }

  Future<Set<Marker>> getLocations() async {
    Set<Marker> markers = Set();
    if (widget.listaUbicacion == null || widget.listaUbicacion.length <= 0)
      return markers;

    for (var i = 0; i < widget.listaUbicacion.length; i++) {
      LocationView ub = widget.listaUbicacion[i];
      for (var j = 0; j < ub.children.length; j++) {
        LocationView f = ub.children[j];
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
            position: f.position,
            infoWindow: InfoWindow(title: '${f.title}'),
            onTap: () => loadDataPreview(f)));
      }
    }

    return markers;
  }

  void _onGeoChanged(CameraPosition cam) {
    //  print('Cambiando Posicion');

    setState(() {
      zoom = cam.zoom;
    });
  }

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
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
          .timeout(timeOutGps);
      print('Encontrada posicion ${current.toString()}');

      LatLng ll = LatLng(current.latitude, current.longitude);
      if (isNavigation) {
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: ll, tilt: 55.0, zoom: zoom, bearing: current.heading)));
      } else {
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: ll, tilt: 0.0, zoom: zoom, bearing: current.heading)));
      }
    } catch (ex) {
      print('Error al centrar posicion $ex');
    }
    setState(() {
      loading = false;
    });
  }

  Future<String> getDistance(LocationView m) async {
    gpsEnabled = await geo.isLocationServiceEnabled().timeout(timeOutGps);
    if (!gpsEnabled) {
      return '';
    }
    String distanciaFinal = '';

    print('Esperando posicion');
    try {
      Position current = await geo
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(timeOutGps);

      double distanciaMts = await geo.distanceBetween(current.latitude,
          current.longitude, m.position.latitude, m.position.longitude);

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
    Color circleColor = theme.LoadingCircle.circleColor;
    if (loading) {
      return Center(
          child: CircularProgressIndicator(
              strokeWidth: 5.0,
              semanticsLabel: 'Calculando distancia',
              valueColor: AlwaysStoppedAnimation<Color>(circleColor)));

      /*
        return new Container(
          color: Colors.grey[300],
          width: 70.0,
          height: 70.0,
          child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
        );

         */
    } else {
      return Container();
    }
  }

  Widget _showCardPreview() {
    // print('valor de loading $loading');
    if (previewLocation == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      alignment: Alignment.bottomCenter,
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 5.0),
          child: SizedBox(
              height: MediaQuery.of(context).size.height *
                  (gpsEnabled ? 0.30 : 0.15),
              width: MediaQuery.of(context).size.width * .50,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.clear),
                    ),
                    onTap: () {
                      closePreview();
                    },
                  ),
                  Column(
                    children: <Widget>[
                      previewImage,
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          child: Text(
                        previewLocation.title,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 5.0,
                      ),
                      (previewDistance != null && previewDistance.isNotEmpty
                          ? Text("$previewDistance")
                          : Container()),
                      SizedBox(
                        height: 10.0,
                      ),
                      (gpsEnabled
                          ? FloatingActionButton(
                              backgroundColor: theme.ScMapButtons.background,
                              child: Text(
                                'IR',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              elevation: 5.0,
                              onPressed: () => startNavigation(previewLocation),
                            )
                          : Container())
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _makeCardNavigation() {
    // print('valor de loading $loading');
    if (isNavigation == null || !isNavigation) {
      return Container();
    }
    return Container(
        alignment: Alignment.bottomCenter,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: Colors.black54),
            alignment: Alignment.bottomCenter,
            height: 75.0,
            child: Row(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    padding:
                        EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 2),
                    child:
                        (selectedImage == null ? SizedBox() : selectedImage)),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width * 0.70,
                          padding: EdgeInsets.only(top: 0.0),
                          child: Text(
                            selectedLocation.title,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "Arial",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          )),
                      (selectedDistance != null && selectedDistance.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                "$selectedDistance",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Arial",
                                    fontSize: 24),
                              ))
                          : Container()),
                    ]),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 40,
                        )),
                    onTap: () {
                      detenerNavegacion();
                    },
                  ),
                )
              ],
            )));
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
      var status =
          await geo.checkGeolocationPermissionStatus().timeout(timeOutGps);
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

  loadDataPreview(LocationView f) async {
    setState(() {
      loading = true;
    });
    if (posStream != null) posStream.pause();
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(f.position));
    Image image = getIconGoogleMap(url: f.imagen, width: 40, height: 40);

    String d = await getDistance(f);
    print('Cargando preview');
    setState(() {
      previewLocation = f;
      previewDistance = d;
      previewImage = image;
      loading = false;
    });
  }

  startNavigation(LocationView u) async {
    print('Iniciar Navegacion');

    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.best, distanceFilter: 10, timeInterval: 5);

    GoogleMapController controller = await _controller.future;
    if (posStream != null) {
      posStream.cancel();
    }
    setState(() {
      selectedLocation = previewLocation;
      selectedDistance = previewDistance;
      selectedImage = previewImage;
      previewLocation = null;
      previewImage = null;
      previewDistance = null;
    });
    posStream = geo.getPositionStream(locationOptions).listen((current) {
      List<LatLng> route = [];
      LatLng now = LatLng(current.latitude, current.longitude);
      route.add(now);
      route.add(u.position);

      setState(() {
        if (!isNavigation) {
          isNavigation = true;
        }
        if (lastHeading == null) {
          lastHeading = current.heading;
        }
        var diference = lastHeading - current.heading;
        if (diference.abs() > 5.0) {
          lastHeading = current.heading;
        }
        print("last Heading $lastHeading");
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: now, tilt: 55.0, zoom: zoom, bearing: lastHeading)));

        getDistanceNavigation(now, u.position).then((text) {
          selectedDistance = text;
        });

        _routeNavigator.clear();
        _routeNavigator.add(Polyline(
          polylineId: PolylineId('${u.id}'),
          visible: true,
          points: route,
          color: Colors.blue,
          width: 4,
        ));
      });
    });

    /*
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);

    posStream=
    geo.getPositionStream(locationOptions).listen((event){
      double lat=event.latitude;
      double lon=event.longitude;
      setNewPosition(lat,lon);
    });

     */
  }

  detenerNavegacion() {
    if (posStream != null) posStream.cancel();
    setState(() {
      isNavigation = false;
      selectedLocation = null;
      _routeNavigator.clear();
      selectedDistance = null;
      selectedImage = null;
    });
  }

  void setNewPosition(double lat, double lon) {
    //  double distanceInMeters = geo.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  }

  Future<String> getDistanceNavigation(LatLng init, LatLng end) async {
    double distanciaMts = await geo.distanceBetween(
        init.latitude, init.longitude, end.latitude, end.longitude);
    if (distanciaMts < 15 && posStream != null) {
      posStream.cancel();
    }
    if (distanciaMts >= 1000) {
      return 'a ' + (distanciaMts / 1000).toStringAsFixed(1) + ' kms';
    } else {
      return 'a ' + distanciaMts.toStringAsFixed(0) + ' mts';
    }
  }

  void closePreview() {
    setState(() {
      if (isNavigation && posStream != null && posStream.isPaused) {
        print('Reiniciando Navegacion');
        posStream.resume();
      }
      previewLocation = null;
      previewDistance = null;
      previewImage = null;
    });
  }
}
