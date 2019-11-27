import 'package:Pasaporte_2020/model/carrousel.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarrouselWidget extends StatelessWidget {
  final List<Carrousel> list;

  const CarrouselWidget({this.list});

  @override
  Widget build(BuildContext context) {

    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 15),
       // borderOnForeground: true,
        //padding: EdgeInsets.symmetric(horizontal: 15),
        //decoration: BoxDecoration(),
        child:SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width*0.5,
        child: buildCarousel()));
  }

  Carousel buildCarousel() {
    return Carousel(

      radius: Radius.circular(5),
      images: getImages(list),
      animationDuration: Duration(milliseconds: 600),
      autoplayDuration: Duration(seconds: 30),
     // overlayShadow: true,

      //animationCurve: Curves.elasticIn,
      dotSize: 7.0,
      dotSpacing: 15.0,
      dotIncreasedColor: Colors.white,
      dotColor: Colors.white.withOpacity(0.5),
      indicatorBgPadding: 2.0,
      dotBgColor: Colors.black.withOpacity(0),
       boxFit: BoxFit.fill,
     borderRadius: true,
      dotHorizontalPadding: 20,

    );
  }

  List<ImageProvider> getImages(List<Carrousel> lista)  {
    /*
    return  [
      ExactAssetImage("assets/img/carousel/imagen_1.jpg"),
      ExactAssetImage("assets/img/carousel/imagen_2.jpg"),
      ExactAssetImage("assets/img/carousel/imagen_3.jpg"),
      ExactAssetImage("assets/img/carousel/imagen_4.jpg"),
      ExactAssetImage("assets/img/carousel/imagen_5.jpg"),
      ExactAssetImage("assets/img/carousel/imagen_6.jpg")];
*/

    List<ImageProvider> images=[];
    for (var i = 0; i < lista.length; i++) {
      images.add(getImageCarousel(url: lista[i].image));
    }
    return images;

  }
}
