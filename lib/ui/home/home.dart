import 'dart:io';
import 'dart:ui';

import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:Pasaporte_2020/config/config_definition.dart' as theme;
import 'package:Pasaporte_2020/providers/ubicaciones.provider.dart';
import 'package:Pasaporte_2020/ui/home/widget/carrousel.dart';
import 'package:Pasaporte_2020/ui/home/widget/content_root.dart';
import 'package:Pasaporte_2020/ui/home/widget/search_bar.dart';
import 'package:Pasaporte_2020/ui/map/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<MapWidgetState> mapKey = new GlobalKey<MapWidgetState>();

  Widget maps;
  Widget carrusel;
  Widget home;

  @override
  void initState() {
    super.initState();


    if(carrusel==null)
      {
        print('[HOME] initState => creando carrusel');
        carrusel=_getCarrusel();

      }else print("[HOME] carrusel ya existe");

    if(home==null){
      print('[HOME] initState => creando home');
      home=_getHome(context);
    }else print("[HOME] home ya existe");
  }

  @override
  Widget build(BuildContext context) {
    if(maps==null) {
      print('[HOME] initState => creando mapa');
      maps = makeMap();
    }
    return WillPopScope(
      child: DefaultTabController(
          length: 2,
          child: Theme(
              isMaterialAppTheme: true,
              data: theme.getThemeScout(),
              //data: ThemeData(brightness: Brightness.light),
              child: Scaffold(
                backgroundColor: theme.ScHomePage.background,
                body: Flex(direction: Axis.vertical, children: <Widget>[
                  Expanded(
                      child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [home, maps]))
                ]),
                bottomNavigationBar: Container(
                    height: 60,
                    padding: EdgeInsets.only(bottom: 3),
                    decoration: BoxDecoration(
                        color: theme.ScBottomBar.background,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: theme.ScBottomBar.topBorder, blurRadius: 6)
                        ]),
                    child: TabBar(
                        tabs: [
                          Tab(icon:Icon(Icons.home, size: 30)),//icon: Image.asset('assets/img/locations/App_capas.png')),//Icon(Icons.home, size: 30)),
                          Tab(icon: Icon(Icons.map, size: 30))
                        ],
                        unselectedLabelColor: theme.ScBottomBar.unSelect,
                        labelColor: theme.ScBottomBar.selected,
                        indicatorColor: theme.ScBottomBar.indicatorColor,
                        indicatorWeight: 2)),
              ))),
      onWillPop: () {
        if (Platform.isAndroid) {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return  AlertDialog(
                    contentPadding: EdgeInsets.all(35),
                    elevation: 30,
                    content: Container(
                        child: Text(
                      '¿Quieres cerrar el pasaporte?',
                      overflow: TextOverflow.visible,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Montserrat"),
                    )),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Salir'),
                        onPressed: () {
                          //Navigator.of(context).pop();
                          SystemNavigator.pop();
                        },
                      ),
                    ],
                  );
            },
          );
        }
        return new Future(() => false);
      },
    );
  }

  Widget _getHome(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        HomeSearchBar(),
        Flexible(
            child: ListView(
                shrinkWrap: true,
                controller: new ScrollController(keepScrollOffset: false),
                children: <Widget>[
              carrusel,
              ContentRootWidget(contentRoot: dataProvider.getExampleRootContent())
            ]))
      ],
    );
  }

  Widget _getCarrusel() {
    var size = window.physicalSize;
    if (size.height > 800 && size.height > size.width) {
      print('con carrusel');
      return CarrouselWidget(
        list: dataProvider.getExampleCarrousel(),
      );
    } else {
      print('sin carrusel');
      return SizedBox.shrink();
    }
  }

  Widget makeMap() {
    return FutureBuilder(
      future: locationProvider.getLocationsView(),
      builder:
          (BuildContext context, AsyncSnapshot<List<LocationView>> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            home: MapWidget(key: mapKey,
              listaUbicacion: snapshot.data,
            ), /* LLamada al Widget de mapa se le debe entregar lista de ubicaciones */
          );
        } else {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
