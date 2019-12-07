import 'package:Pasaporte_2020/model/content/image_conf.dart';
import 'package:Pasaporte_2020/utils/AlignmentUtils.dart';
import 'package:Pasaporte_2020/utils/ColorUtils.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageWidget extends StatelessWidget {
  final ImageConf conf;
  final Color bgColorParent;
  const ImageWidget({Key key, this.conf,this.bgColorParent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Alignment align = getAlignment(conf.align);
    Color bgColor =
    getBackgroundColor(context, conf.backgroundColor, bgColorParent);
    print('Color foto: ${bgColor.toString()}');
    final Image image=getImageContent(url: conf.source);
    if(conf.ownViewer)
    return Container(
        alignment: align,
        child: GestureDetector(child:image,onTap: () => Navigator.pushNamed(context, 'zoom',
            arguments: image)),
        color: bgColor);
    else
      return Container(
          alignment: align,
          child: image,
          color: bgColor);
  }
}
