import 'package:flutter/material.dart';

///Retorna el color rgb, en caso de no poder realizar la
///conversion obtiene el color del tema para el fondo
///y entrega este por defecto
Color getBackgroundColor(BuildContext context, List<int> rgb,
    [Color bgDefaultColor]) {
  Color color;
  try {
    color = Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1);
  } catch (ex) {
    print('Error al convertir color ${rgb.toString()}');
    if (bgDefaultColor == null)
      color = Colors.white;
    else
      color = bgDefaultColor;
  }
  return color;
}

///Retorna el color rgb, en caso de no poder realizar la
///conversion obtiene el color del para el texto tema y
///entrega este por defecto
Color getTextColor(BuildContext context, List<int> rgb, [Color defaultColor]) {
  Color color;
  try {
    color = Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1);
  } catch (ex) {
    print('Error al convertir color ${rgb.toString()}');
    if (defaultColor == null) {
      color = Colors.black87;
    } else {
      color = defaultColor;
    }
  }
  return color;
}
