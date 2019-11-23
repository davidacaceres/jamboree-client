import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class Colors {
  static const Color color_1 = Color(0xFFFFFFFF);
  static const Color color_2 = Color(0xFFFBAE2D);
  static const Color color_3 = Color(0xFF24AAE2);
  static const Color color_4 = Color(0xFF36B449);
  static const Color color_5 = Color(0xFFF15A2A);
  static const Color color_6 = Color(0xFFEC008D);
  static const Color color_7 = Color(0xFF372967);
  static final Color iconsColor = Colors.color_2;
  static final Color color_9 = Color(0xfffafafa);
}

class ScBottomBar {
  ///Color de fondo de la barra inferior
  static final Color background = Colors.color_4;

  ///Color de icono no seleccioando
  static final Color unSelect = Colors.color_1;

  ///Color de icono seleccionado
  static final Color selected = Colors.color_7;

  ///Color de linea que indica cual esta seleccioanado
  static final Color indicatorColor = Colors.color_2;

  ///Color para el borde Superior de la barra de tab inferior
  static final Color topBorder = Colors.color_4;
}

class ScHomePage {
  ///Color de fondo de la pagina principal
  static final Color background = Colors.color_2;

  ///Indica el Color a utilizar para el borde, si BorderStyle.none, no muestra borde
  static final Border cardBorder =
      Border.all(color: Colors.color_7, width: 0.9, style: BorderStyle.solid);

  ///Indica el gradiente a utilizar para mostrar el fondo del contenido
  static final Gradient cardGradient = LinearGradient(
      colors: [Colors.color_4, Colors.color_9],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.8, 0.3],
      tileMode: TileMode.repeated);

  static final TextStyle cardTextStyle = TextStyle(
      fontFamily: "Montserrat",
      //fontStyle: FontStyle.italic,
      color: Colors.color_5,
      fontWeight: FontWeight.w600,
      fontSize: 18);
}

class ScHomeSearch {
  static final Color background = Colors.color_2;
  static final Color iconsColor = Colors.color_7;
}

class ScHistorySearch {
  static final Color background = _base.backgroundColor;
  static final Color iconsColor = Colors.color_7;
}

final ThemeData _jamboree = ThemeData(
//  primaryColor: Colors.color_5,
//  accentColor: Colors.color_6,
//  backgroundColor: Colors.color_5,
//  accentColorBrightness: Brightness.light,
//
//  scaffoldBackgroundColor:Colors.color_2,
//  bottomAppBarColor: Colors.color_7,
// Define the default brightness and colors.
//  brightness: Brightness.dark,
//  primaryColor: Colors.color_2,
//  accentColor: Colors.color_1,
//  backgroundColor: Colors.color_1,
//  bottomAppBarColor: Colors.color_2,

  fontFamily: 'Montserrat',

  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);

ThemeData _base = ThemeData();

ThemeData getThemeScout() {
  return _base;
}
