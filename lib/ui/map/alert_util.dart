import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';

void showAlertNotGps(BuildContext context, String mensaje, IconData icono) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Icon(
          icono != null ? icono : Icons.error_outline,
          color: Theme.of(context).primaryColor,
          size: 60.0,
        ),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Platform.isAndroid ? Text('Configuración') : Text('Cerrar'),
            onPressed: () {
              if (Platform.isAndroid) {
                final AndroidIntent intent = new AndroidIntent(
                  action: 'android.settings.LOCATION_SOURCE_SETTINGS',
                );
                intent.launch();
              }
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
