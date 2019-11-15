import 'package:flutter/cupertino.dart';

Alignment getAlignment(String alignment) {
  Alignment align;
  try {
    if ("left" == alignment) {
      align = Alignment.centerLeft;
    } else if ("right" == alignment) {
      align = Alignment.centerRight;
    } else {
      align = Alignment.center;
    }
  } catch (ex) {
    print(
        'error al obtener alineacion [$alignment] se obtiene por defecto center');
    align = Alignment.center;
  }
  return align;
}
