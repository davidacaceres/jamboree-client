import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Creando Zoom Component en scafolds');
    final Image image = ModalRoute.of(context).settings.arguments;
    return Container(
        child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.black),
            body: PhotoView(
          imageProvider: image.image,
        )
        ));
    //return Container();
  }
}
