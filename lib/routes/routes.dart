import 'package:Pasaporte_2020/ui/content/detail_content.dart';
import 'package:Pasaporte_2020/ui/home/home.dart';
import 'package:Pasaporte_2020/ui/init_screen.dart';
import 'package:Pasaporte_2020/ui/search/search_page.dart';
import 'package:flutter/material.dart';

final _rutas = <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashScreen(),
  'home': (BuildContext context) => HomePage(),
  'search': (BuildContext context) =>SearchPage(),
  'detail': (BuildContext context) =>DetailContent(),
};

Map<String, WidgetBuilder> getApplicationRoutes() => _rutas;
