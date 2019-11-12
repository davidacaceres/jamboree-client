import 'package:Pasaporte/model/Carrousel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class CarrouselWidget extends StatelessWidget {
  final List<Carrousel> list;

  const CarrouselWidget({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
          height: 200.0,
          width: MediaQuery.of(context).size.width * 1 - 32,
          child: Carousel(
            radius: Radius.circular(10),
            images: getImages(list),
            animationCurve: Curves.easeInCirc,
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotIncreasedColor: Colors.white,
            dotColor: Colors.white.withOpacity(0.5),
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.black.withOpacity(0.1),
            // boxFit: BoxFit.cover,
            borderRadius: true,
          )),
    );
  }

  List<Widget> getImages(List<Carrousel> lista) {
    List<CachedNetworkImage> images = [];
    for (var i = 0; i < lista.length; i++) {
      images.add(_loadImages(lista[i].image));
    }
    return images;
  }

  CachedNetworkImage _loadImages(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      useOldImageOnUrlChange: true,
      placeholder: (context, url) => Icon(Icons.cloud_download),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
