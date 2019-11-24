import 'package:Pasaporte_2020/theme/theme_definition.dart' as sc_theme;
import 'package:Pasaporte_2020/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

//********************************************************
// class for screen flash screen for loading style
// you can add function run when launch app in initstate function
//********************************************************

class SplashScreenApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AfterSplashScreen();
}

class AfterSplashScreen extends State<SplashScreenApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(child:SplashScreen(
        seconds: 5,
        navigateAfterSeconds: HomePage(),
        title: Text(
          sc_theme.ScTextDefault.appTitle,
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w500,
            color: Colors.deepOrange,
            shadows: <Shadow>[
            Shadow(
            blurRadius: 5.0,
            color: Colors.green,
          )]
          ),
        ),
      //  backgroundColor: Colors.lightBlueAccent,
        imageBackground: AssetImage('assets/img/fondo_inicial.png'),
        photoSize: MediaQuery.of(context).size.width * 0.4,
        image: Image.asset('assets/img/agsch-headerr.png',alignment: Alignment.topCenter,),
        loaderColor: Colors.white,
      ));
}
