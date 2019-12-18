import 'dart:async';

import 'package:Pasaporte_2020/config/config_definition.dart' as sc_theme;

import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:Pasaporte_2020/providers/locator.dart';
import 'package:Pasaporte_2020/routes/routes.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  //final NavigationService _navigationService = locator<NavigationService>();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  ProgressDialog pr;

  Widget progress = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: ExactAssetImage(sc_theme.ScSplashScreen.assetUrl), fit: BoxFit.cover)),
            child: CustomPaint(
                painter: CurvePainter(),
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

  Future<void> init() async {
    try {
      await dataProvider.loadData();
//      _navigationService.navigateTo("home");
      Navigator.of(context).pushReplacementNamed("home");

      /*
          .loadContentUrl()
          .then((value) => dataProvider.loadLocationsUrl().then((onValue) {
                Navigator.of(context).pushReplacementNamed("home");

              }));
*/
      /*.then((result) {
        if (result != -99) {
          Navigator.pushReplacementNamed(context, 'home');
          print(
              '[INIT] finalizo la carga de archivo json, se direcciona al home $result');
        }
      });*/
    } catch (ex) {
      print('error al redireccionar al home $ex');
    }
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = sc_theme.ScSplashScreen.background;
    paint.style = PaintingStyle.fill;
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
    return true;
  }
}
