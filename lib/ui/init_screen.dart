import 'dart:async';

import 'package:Pasaporte_2020/config/config_definition.dart' as sc_theme;

import 'package:Pasaporte_2020/example_data/example_data.dart';
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
              //  painter: CurvePainter(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Align(
                          alignment: Alignment.center,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                accentColor:
                                    sc_theme.ScSplashScreen.colorIconLoading),
                            child: progress,
                          )),
                    ),
                  ],
                ))));
  }

  Future<void> init() async {
    try {
      await dataProvider.loadData();
      Navigator.of(context).pushReplacementNamed("home");
   } catch (ex) {
      print('error al redireccionar al home $ex');
    }
  }
}
