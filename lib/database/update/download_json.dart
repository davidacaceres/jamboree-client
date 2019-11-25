


import 'dart:async';

import 'package:progress_dialog/progress_dialog.dart';

class DownloadJson{
  final ProgressDialog dialog;
  final Function(bool) onInstalled;

  DownloadJson({this.dialog,this.onInstalled});

  startDownload(){
    if(dialog!=null)
    dialog.update(message: 'Iniciando descarga');

     Timer(Duration(seconds: 10), (){
       if(dialog!=null)
       dialog.hide();
       print('deberia cerrar el dialogo');
       print('FIn timer installed ok');
       onInstalled(true);
     });
  }
}