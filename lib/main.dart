import 'package:Pasaporte_2020/theme/theme_definition.dart' as sc_theme;
import 'package:flutter/material.dart';

import 'package:Pasaporte_2020/routes/routes.dart';
import 'package:Pasaporte_2020/ui/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: sc_theme.ScTextDefault.appTitle,
/*      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),*/

      initialRoute: "/",
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings){
        print('La ruta llamada es ${settings.name} y no fue encontrada, se deriva a home page');
        return MaterialPageRoute(builder:(BuildContext context)=> HomePage());
      },
      //home: SplashScreenApp(),
    );
  }
}
