import 'package:Pasaporte_2020/config/config_definition.dart' as config;
import 'package:Pasaporte_2020/example_data/example_data.dart';
import 'package:Pasaporte_2020/model/content.dart';
import 'package:Pasaporte_2020/utils/AlignmentUtils.dart';
import 'package:Pasaporte_2020/utils/ColorUtils.dart';
import 'package:Pasaporte_2020/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tinycolor/tinycolor.dart';

class DisplayWidget extends StatelessWidget {
  final Display display;
  final String parentId;
  final int index;
  final Color bgColorParent;
  final Color txtColorParent;

  const DisplayWidget(
      {@required this.parentId,
      @required this.display,
      @required this.index,
      @required this.bgColorParent,
      @required this.txtColorParent});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _getContents(context, display),
    ));
  }

  List<Widget> _getContents(BuildContext context, Display display) {
    List<Widget> result = [];
    if (display.content == null ||
        display.content.length <= 0 ||
        display.content.isEmpty) return result;

    for (var i = 0; i < display.content.length; i++) {
      ContentElement c = display.content[i];
      bool initial = (i == 0 ? true : false);

      if (c.imageConf != null) {
        print("Es imagen");
        result.add(_getPicture(context, c.imageConf));
      } else if (c.paragraphConf != null) {
        print('es parrafo');
        result.add(_getParagraph(context, c.paragraphConf, initial));
      }
    }
    if (display.childs != null && display.childs.length > 0) {
      result.add(_getList(context, display.childs, null));
    }

    return result;
  }

  Widget _getPicture(BuildContext context, ImageConf conf) {
    Alignment align = getAlignment(conf.align);
    Color bgColor =
        getBackgroundColor(context, conf.backgroundColor, bgColorParent);
    print('Color foto: ${bgColor.toString()}');
    return Container(
        alignment: align,
        child: getImageContent(url: conf.source),
        color: bgColor);
  }

  Widget _getParagraph(
      BuildContext context, ParagraphConf paragraph, bool initial) {
    Color bgColor =
        getBackgroundColor(context, paragraph.backgroundColor, bgColorParent);
    Color txtColor = getTextColor(context, paragraph.textColor,
        config.ScContent.textColorparagrapfDefault);
    String fontFamily = paragraph.font == null || paragraph.font.isEmpty
        ? 'Arial'
        : paragraph.font;
    double fontSize = paragraph.fontSize == null || paragraph.fontSize <= 0
        ? 16.0
        : paragraph.fontSize;

    Html html = Html(
      data: paragraph.data,
      padding: EdgeInsets.all(8.0),
      backgroundColor: bgColor,
      defaultTextStyle: TextStyle(
          fontFamily: fontFamily, fontSize: fontSize, color: txtColor),
      linkStyle: const TextStyle(
        color: Colors.blueAccent,
      ),
      onLinkTap: (url) {
        // open url in a webview
      },
      onImageTap: (src) {
        // Display the image in large form.
      },
      renderNewlines: true,
      showImages: true,
      useRichText: true,
    );
    if (initial) {
      return Container(
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: html);
    } else {
      return html;
    }
  }

  Widget _getList(BuildContext context, List<Child> childs, Color colorCard) {
    return Column(children: _getChild(context, childs));
  }

  List<Widget> _getChild(BuildContext context, List<Child> list) {
    List<Widget> childs = [];
    for (var i = 0; i < list.length; i++) {
      Widget child = GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'detail',
              arguments: findExampleContent(list[i].id)),
          child: _makeChild2(context, list[i]));
      childs.add(child);
    }
    return childs;
  }

  Widget _makeChild(BuildContext context, Child child) {
    Color bgColor =
        getBackgroundColor(context, child.backgroundColor, bgColorParent);
    TextStyle stText = config.ScContent.childText;

    return Card(
        elevation: 10,
        margin: EdgeInsets.all(5),
        color: bgColor.withBlue(200),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Container(
                    width: MediaQuery.of(context).size.width * .80,
                    child: Text(
                      child.title,
                      overflow: TextOverflow.visible,
                      style: stText,
                    ))),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.black87),
          ],
        ));
  }

  Widget _makeChild2(BuildContext context, Child child) {
    Color bgColor =
        getBackgroundColor(context, child.backgroundColor, bgColorParent);
    Color txtColor = getTextColor(context, child.textColor, txtColorParent);

    //  TextStyle stText = config.ScContent.childText;
    if (txtColor.value == bgColor.value) {
      print('Es el mismo color');
      txtColor =
          TinyColor.fromRGB(r: bgColor.red, g: bgColor.green, b: bgColor.blue)
              .darken(100)
              .color;
    }


    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
            decoration: BoxDecoration(color: bgColor),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(width: 1.0, color: txtColor))),
                  child: getImageContent(url: child.image),
                ),
                title: Text(
                  child.title,
                  style:
                      TextStyle(color: txtColor, fontWeight: FontWeight.w700),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.keyboard_arrow_right,
                    color: txtColor, size: 30.0))));
  }
}
