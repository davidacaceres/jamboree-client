import 'package:Pasaporte_2020/ui/content/detail_content.dart';
import 'package:Pasaporte_2020/ui/content/widget/wImageZoom.dart';
import 'package:Pasaporte_2020/ui/home/home.dart';
import 'package:Pasaporte_2020/ui/init_screen.dart';
import 'package:Pasaporte_2020/ui/search/search_page.dart';
import 'package:flutter/material.dart';

final _rutas = <String, WidgetBuilder>{
  'initial': (BuildContext context) => SplashScreen(),
  'home': (BuildContext context) => HomePage(),
  'search': (BuildContext context) => SearchPage(),
  'detail': (BuildContext context) => DetailContent(),
  'zoom': (BuildContext context) => ImageZoomWidget(),
};

Map<String, WidgetBuilder> getApplicationRoutes() => _rutas;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  bool goBack() {
    return navigatorKey.currentState.pop();
  }
}
