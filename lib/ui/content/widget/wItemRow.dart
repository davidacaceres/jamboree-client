import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/utils/ColorUtils.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ItemRow extends StatelessWidget {

  final Item item;
  final TextStyle txtStyle;
  final Color bgDColor;
  final double height;
  ItemRow(this.item,this.bgDColor,this.txtStyle,this.height);

  @override
  Widget build(BuildContext context) {


    final bgColor= getBackgroundColor(context, item.backgroundColor,bgDColor);

    final subHeaderTextStyle = TextStyle(
        fontSize: item.subtitleFontSize??txtStyle.fontSize,
        fontFamily: item.subtitleFontFamiy??txtStyle.fontFamily,
        color: getTextColor(context,item.subtitleColor,txtStyle.color));

    final headerTextStyle = TextStyle(
        fontSize: item.titleFontSize??txtStyle.fontSize,
        fontFamily: item.titleFontFamiy??txtStyle.fontFamily,
        color: getTextColor(context,item.titleColor,txtStyle.color));







    return
      Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 1),
          decoration: BoxDecoration(color: bgColor,borderRadius: BorderRadius.circular(10)),
          child: ListTile(dense: true,
          //  contentPadding:
         //   EdgeInsets.symmetric(horizontal: 15.0),
              leading: item.image==null || item.image.isEmpty?null:Container(
             //   padding: EdgeInsets.only(right: 12.0),
                child: getImageContent(url: item.image),
              ),
              title: new Html(data:item.title,padding: EdgeInsets.all(0),backgroundColor:bgColor,defaultTextStyle: headerTextStyle,useRichText: true,),
              subtitle: (item.subtitle==null || item.subtitle.isEmpty?null:Html(data:item.subtitle,backgroundColor:bgColor,defaultTextStyle: subHeaderTextStyle,useRichText: true,))
      )
      );

     }
}