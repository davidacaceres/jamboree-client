import 'package:Pasaporte_2020/config/config_definition.dart' as sc_theme;
import 'package:Pasaporte_2020/providers/locator.dart';
import 'package:Pasaporte_2020/routes/routes.dart';
import 'package:Pasaporte_2020/ui/home/home.dart';
import 'package:flutter/material.dart';

void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: sc_theme.ScTextDefault.appTitle,
     // home:  SplashScreen(key:new GlobalKey<SplashScreenState>()),

      initialRoute: "initial",
      navigatorKey: locator<NavigationService>().navigatorKey,
      routes: getApplicationRoutes(),

      onGenerateRoute: (RouteSettings settings){
        print('[ROUTE] La ruta llamada es ${settings.name} y no fue encontrada, se deriva a home page');
        return MaterialPageRoute(builder:(BuildContext context)=> HomePage());
      },
      //home: SplashScreenApp(),
    );
  }
}
