import 'package:Pasaporte_2020/model/carrousel.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarrouselWidget extends StatelessWidget {
  final List<Carrousel> list;

  const CarrouselWidget({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
      width: MediaQuery.of(context).size.width * 1 - 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Carousel(
            radius: Radius.circular(30),
            images: getImages(list),
            //animationCurve: Curves.easeInCirc,
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotIncreasedColor: Colors.white,
            dotColor: Colors.white.withOpacity(0.5),
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.black.withOpacity(0.1),
             boxFit: BoxFit.cover,
            borderRadius: false,
            dotHorizontalPadding: 10,
          ),
    );
  }

  List<Widget> getImages(List<Carrousel> lista) {
    List<Image> images = [];
    for (var i = 0; i < lista.length; i++) {
      images.add(getImageContent(url: lista[i].image,fit:BoxFit.fill));
    }
    return images;
  }

}
