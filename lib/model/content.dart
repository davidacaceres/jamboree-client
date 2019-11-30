// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'dart:convert';

Content contentFromJson(String str) => Content.fromMap(json.decode(str));

String contentToJson(Content data) => json.encode(data.toMap());

class Content {
  String id;
  int order;
  String title;
  List<int> titleColor;
  String titleList;
  String image;
  bool root;
  List<int> backgroundPage;
  List<Display> display;
  String search;
  String font;
  double fontSize;
  List<int> tabPrimaryColor;
  List<int> tabSecondaryColor;
  List<int> tabTextColor;


  Content(
      {this.id,
      this.order,
      this.title,
      this.titleList,
      this.image,
      this.backgroundPage,
      this.display,
      this.root,
      this.search,
      this.titleColor,
      this.font,
      this.fontSize,
      this.tabPrimaryColor,
      this.tabSecondaryColor,
      this.tabTextColor});

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        id: json["id"],
        order: json["order"],
        title: json["title"],
        titleList: json["titleList"] == null ? null : json["titleList"],
        image: json["image"],
        root: json["root"] == null ? false : json["root"],
        backgroundPage: List<int>.from(json["background_page"].map((x) => x)),
        display:
            List<Display>.from(json["display"].map((x) => Display.fromMap(x))),
        search: json["search"] == null ? null : json["search"],
        titleColor: json["titleColor"] == null
            ? null
            : List<int>.from(json["titleColor"].map((x) => x)),
        font: json["font"],
        fontSize: json["fontSize"],
    tabPrimaryColor: json["tabPrimaryColor"] == null
        ? null
        : List<int>.from(json["tabPrimaryColor"].map((x) => x)),
    tabSecondaryColor: json["tabSecondaryColor"] == null
        ? null
        : List<int>.from(json["tabSecondaryColor"].map((x) => x)),
    tabTextColor: json["tabTextColor"] == null
        ? null
        : List<int>.from(json["tabTextColor"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order": order,
        "title": title,
        "titleList": titleList,
        "image": image,
        "background_page": List<dynamic>.from(backgroundPage.map((x) => x)),
        "display": List<dynamic>.from(display.map((x) => x.toMap())),
        "root": root,
        "search": search,
        "titleColor": titleColor == null
            ? null
            : List<dynamic>.from(titleColor.map((x) => x)),
        "font": font,
        "fontSize": fontSize,
        "tabPrimaryColor": tabPrimaryColor==null?null:List<dynamic>.from(tabPrimaryColor.map((x) => x)),
        "tabSecondaryColor": tabSecondaryColor==null?null:List<dynamic>.from(tabSecondaryColor.map((x) => x)),
        "tabTextColor": tabTextColor==null?null:List<dynamic>.from(tabTextColor.map((x) => x)),
  };
}

class Display {
  String shortTitle;
  List<ContentElement> content;
  List<Child> childs;

  Display({
    this.shortTitle,
    this.content,
    this.childs,
  });

  factory Display.fromMap(Map<String, dynamic> json) => Display(
        shortTitle: json["short_title"],
        content: List<ContentElement>.from(
            json["content"].map((x) => ContentElement.fromMap(x))),
        childs: json["childs"] == null
            ? null
            : List<Child>.from(json["childs"].map((x) => Child.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "short_title": shortTitle,
        "content": List<dynamic>.from(content.map((x) => x.toMap())),
        "childs": childs == null
            ? null
            : List<dynamic>.from(childs.map((x) => x.toMap())),
      };
}

class Child {
  String id;
  int order;
  String title;

  Child({
    this.id,
    this.order,
    this.title,
  });

  factory Child.fromMap(Map<String, dynamic> json) => Child(
        id: json["id"],
        order: json["order"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order": order,
        "title": title,
      };
}

class ContentElement {
  ParagraphConf paragraphConf;
  ImageConf imageConf;

  ContentElement({
    this.paragraphConf,
    this.imageConf,
  });

  factory ContentElement.fromMap(Map<String, dynamic> json) => ContentElement(
        paragraphConf: json["paragraph_conf"] == null
            ? null
            : ParagraphConf.fromMap(json["paragraph_conf"]),
        imageConf: json["image_conf"] == null
            ? null
            : ImageConf.fromMap(json["image_conf"]),
      );

  Map<String, dynamic> toMap() => {
        "paragraph_conf": paragraphConf == null ? null : paragraphConf.toMap(),
        "image_conf": imageConf == null ? null : imageConf.toMap(),
      };
}

class ImageConf {
  String source;
  String align;
  List<int> backgroundColor;

  ImageConf({
    this.source,
    this.align,
    this.backgroundColor,
  });

  factory ImageConf.fromMap(Map<String, dynamic> json) => ImageConf(
        source: json["source"],
        align: json["align"],
        backgroundColor: json["background_color"]==null?null:List<int>.from(json["background_color"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "source": source,
        "align": align,
        "background_color": List<dynamic>.from(backgroundColor.map((x) => x)),
      };
}

class ParagraphConf {
  List<int> textColor;
  List<int> backgroundColor;
  String data;
  double fontSize;
  String font;

  ParagraphConf({
    this.textColor,
    this.backgroundColor,
    this.data,
    this.font,
    this.fontSize
  });

  factory ParagraphConf.fromMap(Map<String, dynamic> json) => ParagraphConf(
        textColor: json["text_color"] == null
            ? null
            : List<int>.from(json["text_color"].map((x) => x)),
        backgroundColor: json["background_color"] == null
            ? null
            : List<int>.from(json["background_color"].map((x) => x)),
        data: json["data"],
        fontSize: json["fontSize"] ==null ?0:json["fontSize"],
        font: json["font"],
      );

  Map<String, dynamic> toMap() => {
        "text_color": textColor == null
            ? null
            : List<dynamic>.from(textColor.map((x) => x)),
        "background_color": backgroundColor == null
            ? null
            : List<dynamic>.from(backgroundColor.map((x) => x)),
        "data": data,
        "fontSize": fontSize,
        "font": font,
      };
}
