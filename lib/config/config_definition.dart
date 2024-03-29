import 'package:flutter/material.dart';

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

  static final Color color_10= Color(4280724140);
  static final Color color_11= Color(4280622686);
  static final Color color_12= Color(4285966810);
  static final Color color_13= Color(4281483365);
}

class ScBottomBar {
  ///Color de fondo de la barra inferior
  static final Color background = Colors.color_10;

  ///Color de icono no seleccioando
  static final Color unSelect = Colors.color_9;

  ///Color de icono seleccionado
  static final Color selected = Colors.color_11;

  ///Color de linea que indica cual esta seleccioanado
  static final Color indicatorColor = Colors.color_11;

  ///Color para el borde Superior de la barra de tab inferior
  static final Color topBorder = Colors.color_11;
}

class ScHomePage {
  ///Color de fondo de la pagina principal
  static final Color background = Colors.color_12;

  ///Indica el Color a utilizar para el borde, si BorderStyle.none, no muestra borde
  static final Border cardBorder =
      Border.all(color: Colors.color_9, width: 0.9, style: BorderStyle.solid);

  ///Indica el gradiente a utilizar para mostrar el fondo del contenido
  static final Gradient cardGradient = LinearGradient(
      colors: [Colors.color_12, Colors.color_12],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.8, 0.7],
      tileMode: TileMode.repeated);

  static final TextStyle cardTextStyle = TextStyle(
      fontFamily: "Montserrat",
      //fontStyle: FontStyle.italic,
      color: Colors.color_9,
      fontWeight: FontWeight.w600,
      fontSize: 16);
}

class ScHomeSearch {
  static final Color background = Colors.color_10;
  static final Color iconsColor = Colors.color_7;
}

class ScHistorySearch {
  static final Color background = _base.backgroundColor;
  static final Color iconsColor = Colors.color_7;
}

class ScSplashScreen {
  static final Color backgroundAsociacion = Colors.color_7.withOpacity(0.0);
  static final Color background = Colors.color_13;
  static final Duration duration = Duration(seconds: 10);
  static final Color colorText = Colors.color_1;
  static final String text = 'Jamboree 2020';
  static final Color colorTextLoading = Colors.color_1;
  static final String textLoading = 'Inicializando Aplicación';
  static final Color colorIconLoading = Colors.color_1;

  static final styleText = TextStyle(
      color: colorText,
      fontFamily: "Gingerline DEMO Regular",
      fontWeight: FontWeight.w800,
      letterSpacing: 2,
      fontSize: 28.0,
      shadows: <Shadow>[Shadow(blurRadius: 20.0, color: Colors.color_5)]);

  static final String assetUrl = 'assets/img/inicial/start_image.jpg';
  static final BoxFit fill = BoxFit.fitHeight;
}

class ScContent {
  static final Color barTopColor = Colors.color_10;
  static final Color colorIconBack = Colors.color_7;
  static final Color defaultColor = Colors.color_9;
  static final Color tabPrimaryColor = Colors.color_3;
  static final Color tabSecondaryColor = Colors.color_4;
  static final Color tabTextColor = Colors.color_9;

  static final Color selectedColorTextTab = Colors.color_3;
  static final Color unSelectedColorTextTab = Colors.color_2;
  static final Color defaultTitleColor = Colors.color_7;

  static final Color textColorparagrapfDefault = Colors.color_2;
  static final TextStyle titleContent = TextStyle(
      fontFamily: "Gingerline DEMO Regular",
      fontWeight: FontWeight.w500,
      letterSpacing: 1,
      fontSize: 20);

  //Card con lista de childs
  static final Color bgCard = Colors.color_4;
  static final TextStyle childText = TextStyle(
      color: Colors.color_7,
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w400,
      letterSpacing: 1,
      fontSize: 18);
}

class ScTextDefault {
  static final String appTitle = 'Jamboree 2020';
}

class ScMapButtons{
  static final Color background=Colors.color_2;
}

class ScMapSelectedCheckbox{
  static final Color activeColor=Colors.color_9;
  static final Color checkColor=Colors.color_2;

}

class LoadingCircle{
  static final Color circleColor=Colors.color_2;
}


class ScMapTitleLocations{
  static final Color background=Colors.color_9;
  static final Color text=Colors.color_2;

}


ThemeData _base = ThemeData();

ThemeData getThemeScout() {
  return _base;
}

String getUrlUpdateInfo() {
  return 'https://raw.githubusercontent.com/davidacaceres/scout_chile_data/master/json/lastUpdateContent.json';
}

String getServerUpdateInfo() {
  return 'raw.githubusercontent.com';
}
