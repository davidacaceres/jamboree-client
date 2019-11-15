import 'package:flutter/material.dart';

import 'package:Pasaporte/routes/routes.dart';
import 'package:Pasaporte/ui/home/home.dart';
import 'package:Pasaporte/ui/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),

      initialRoute: "/",
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings){
        print('La ruta llamada es y no encontrada ${settings.name}');
        return MaterialPageRoute(builder:(BuildContext context)=> HomePage());
      },
      //home: SplashScreenApp(),
    );
  }
}
