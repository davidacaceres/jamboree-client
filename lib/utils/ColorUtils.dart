import 'package:flutter/material.dart';

///Retorna el color rgb, en caso de no poder realizar la
///conversion obtiene el color del tema para el fondo
///y entrega este por defecto
Color getBackgroundColor(BuildContext context, List<int> rgb) {
  Color color;
  try {
    color = Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1);
  } catch (ex) {
    print('Error al convertir color ${rgb.toString()}');
    color = Colors.white;
  }
  return color;
}

///Retorna el color rgb, en caso de no poder realizar la
///conversion obtiene el color del para el texto tema y
///entrega este por defecto
Color getTextColor(BuildContext context, List<int> rgb) {
  Color color;
  try {
    color = Color.fromRGBO(rgb[0], rgb[1], rgb[2],1);
  } catch (ex) {
    print('Error al convertir color ${rgb.toString()}');
    color = Colors.black87;
  }
  return color;
}
