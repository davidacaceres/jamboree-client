import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:Pasaporte_2020/database/update/process_update.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:Pasaporte_2020/config/config_definition.dart' as sc_theme;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ui.Image image;
  bool isImageloaded = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            child: new CircularProgressIndicator(),
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

    try {
      final result = await InternetAddress.lookup(sc_theme.getServerUpdateInfo());
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to ${sc_theme.getServerUpdateInfo()}');
        CheckUpdate().check().then(retrived);
      }else{
        setTimer();
      }
    } on SocketException catch (_) {
      print('not connected to ${sc_theme.getServerUpdateInfo()}');
      setTimer();
    }

    final ByteData data = await rootBundle.load('assets/img/fondo_inicial.png');
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  // Direcciona donde ir cuando existe o no una actualizacion.
  retrived(bool changed) {
    if (changed) {
      Navigator.pushNamed(context, 'home');
    } else {
      Navigator.pushNamed(context, 'home');
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
    if (image != null) canvas.drawImage(image, new Offset(0.0, 0.0), paint);

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
