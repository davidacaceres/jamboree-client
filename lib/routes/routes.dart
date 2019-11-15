import 'package:Pasaporte/ui/content/detail_content.dart';
import 'package:Pasaporte/ui/home/home.dart';
import 'package:Pasaporte/ui/search/search_page.dart';
import 'package:Pasaporte/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

final _rutas = <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashScreenApp(),
  '/home': (BuildContext context) => HomePage(),
  'search': (BuildContext context) =>SearchPage(),
  'detail': (BuildContext context) =>DetailContent(),
};

Map<String, WidgetBuilder> getApplicationRoutes() => _rutas;
