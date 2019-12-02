import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:Pasaporte_2020/config/config_definition.dart' as sc_theme;
import 'package:Pasaporte_2020/database/update/check_update.dart';
import 'package:Pasaporte_2020/database/update/download_json.dart';
import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({ Key key }) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ui.Image image;
  bool isImageloaded = false;
  bool download=false;
  ProgressDialog pr;

  DownloadJson downloadProcess;
  Widget progress= CircularProgressIndicator();

  @override
  void initState() {
    super.initState();


    init();
  }



  @override
  Widget build(BuildContext context) {
    if(download)
      {
        print('Download is True');
        progress=SizedBox.shrink();
        /*
        pr = new ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: true);

        pr.style(
            message: 'Descargando datos...',
            borderRadius: 10.0,
            backgroundColor: Colors.white,
            progressWidget: CircularProgressIndicator(),
            elevation: 10.0,
            insetAnimCurve: Curves.easeInOut,
            progress: 0.0,
            maxProgress: 100.0,
            progressTextStyle: TextStyle(
                color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
            messageTextStyle: TextStyle(
                color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
        );
        downloadProcess=DownloadJson(dialog: pr);
         pr.show();
         */
        DownloadJson(dialog: pr,onInstalled: installed).startDownload();
      }else{
      print('Download is False');
    }


    return Scaffold(
        key: scaffoldKey,
        body: Container(
            child: CustomPaint(
                painter: CurvePainter(image: image),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                accentColor:
                                    sc_theme.ScSplashScreen.colorIconLoading),
                            child: progress,
                          )),
                    ),
                    Expanded(
                        child: Row(children: <Widget>[
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: new Container(
                              height: 30,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: sc_theme
                                    .ScSplashScreen.backgroundAsociacion,
                              ),
                              child: Image.asset(
                                'assets/img/agsch-headerr.png',
                                fit: BoxFit.fitHeight,
                              ))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                              padding: EdgeInsets.all(4),
                              child: AutoSizeText(
                                sc_theme.ScSplashScreen.text,
                                style: sc_theme.ScSplashScreen.styleText,
                              ))),
                      Padding(
                          padding: EdgeInsets.all(4),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                'assets/img/logo_jamboree_color.png',
                                height: 70,
                                fit: BoxFit.fitHeight,
                              )))
                    ]))
                  ],
                ))));
  }

  Future<Null> init() async {

    /*
    try {
      final result =
          await InternetAddress.lookup(sc_theme.getServerUpdateInfo());
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to ${sc_theme.getServerUpdateInfo()}');
        CheckUpdate().check().then(retrived);
      } else {
        setTimer();
      }
    } on SocketException catch (_) {
      print('not connected to ${sc_theme.getServerUpdateInfo()}');
      setTimer();
    }
*/
    //final ByteData data = await rootBundle.load('assets/img/fondo_inicial.png');
    final ByteData data = await rootBundle.load(sc_theme.ScSplashScreen.assetUrl);
    image = await loadImage(new Uint8List.view(data.buffer));

    loadContentUrl().then((result){
      print('finalizo la carga de archivo json, se direcciona al home');
      loadLocationsUrl().then((onResult){
        if(onResult){
          print('No se encontro archivo de ubicaciones');
        }else{
          print('Archivo de ubicaciones cargado');
        }
        Navigator.pushReplacementNamed(context, 'home');
      });

    });



  }

  // Direcciona donde ir cuando existe o no una actualizacion.
  retrived(bool changed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jUpdateLocal =
        prefs.getString(CheckUpdate.lastUpdateKey) ?? "";

    if (changed && jUpdateLocal != null && jUpdateLocal.isNotEmpty) {
      //Ha sido cargada data anteriormente
      print('Ha sido cargada data anteriormente');


    } else if (changed && jUpdateLocal == null || jUpdateLocal.isEmpty) {
      print('Instalacion nueva, se bajaran datos');
      openDownloadDialog();
      //Instalacion nueva, hay que bajar datos
    } else if (!changed && jUpdateLocal == null || jUpdateLocal.isEmpty) {
      print(
          'No se puede abrir, hay que bajar datos y no se encuentra conexion a internet o archivo de actualizacion');
      SystemNavigator.pop();
      //No se ha instalado nunca y no puede detectar cambios,
      // se debe cerrar la aplicacion y enviar un mensaje que indique
      // que no se pude descargar el contenido desde internet

    }
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  void setTimer() {
    print('set Timer');
    Timer(sc_theme.ScSplashScreen.duration,
        () => Navigator.pushNamed(context, 'home'));
  }

  void openDownloadDialog() {
   /* print('Camniando Estado ');
    setState(() {
      this.download=true;
    });
    print('Camniando Estado final');

    */


/*
    setState(() {
      visibleList = list[index];
    });

 */
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        download=true;
      });

    });

     */
  }



  installed(bool ) {
    print('Instalacion finalizada');
    Navigator.pushNamed(context, 'home');
  }
}

class CurvePainter extends CustomPainter {
  CurvePainter({
    this.image,
  });

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = sc_theme.ScSplashScreen.background;
    paint.style = PaintingStyle.fill;
    if (image != null) {
      final Size imageSize = Size(
          image.width.toDouble(), image.height.toDouble());
      final FittedSizes sizes = applyBoxFit(sc_theme.ScSplashScreen.fill, imageSize, size);
      final Rect inputSubrect = Alignment.center.inscribe(
          sizes.source, Offset.zero & imageSize);

      final Rect outputRect = Rect.fromLTRB(0, 0, size.width, size.height);
      final Rect outputSubrect = Alignment.center.inscribe(
          sizes.destination, outputRect);
      canvas.drawImageRect(image, inputSubrect, outputSubrect, paint);
      //canvas.drawImageNine(image, center, dst, paint)
      //canvas.drawImage(image, new Offset(0.0, 0.0), paint);

    //  canvas.drawImage(image, new Offset(0.0, 0.0), paint);

    }
    var path = Path();
    path.moveTo(0, size.height * 0.85);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.8, size.width, size.height * 0.85);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
