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
  String titleList;
  String image;
  bool root;
  List<int> backgroundPage;
  List<Display> display;

  Content({
    this.id,
    this.order,
    this.title,
    this.titleList,
    this.image,
    this.backgroundPage,
    this.display,
    this.root
  });

  factory Content.fromMap(Map<String, dynamic> json) => Content(
    id: json["id"],
    order: json["order"],
    title: json["title"],
    titleList: json["titleList"],
    image: json["image"],
    root:json["root"],
    backgroundPage: List<int>.from(json["background_page"].map((x) => x)),
    display: List<Display>.from(json["display"].map((x) => Display.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order": order,
    "title": title,
    "titleList": titleList,
    "image": image,
    "background_page": List<dynamic>.from(backgroundPage.map((x) => x)),
    "display": List<dynamic>.from(display.map((x) => x.toMap())),
    "root": root
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
    content: List<ContentElement>.from(json["content"].map((x) => ContentElement.fromMap(x))),
    childs: json["childs"] == null ? null : List<Child>.from(json["childs"].map((x) => Child.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "short_title": shortTitle,
    "content": List<dynamic>.from(content.map((x) => x.toMap())),
    "childs": childs == null ? null : List<dynamic>.from(childs.map((x) => x.toMap())),
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
    paragraphConf: json["paragraph_conf"] == null ? null : ParagraphConf.fromMap(json["paragraph_conf"]),
    imageConf: json["image_conf"] == null ? null : ImageConf.fromMap(json["image_conf"]),
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
    backgroundColor: List<int>.from(json["background_color"].map((x) => x)),
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

  ParagraphConf({
    this.textColor,
    this.backgroundColor,
    this.data,
  });

  factory ParagraphConf.fromMap(Map<String, dynamic> json) => ParagraphConf(
    textColor: json["text_color"] == null ? null : List<int>.from(json["text_color"].map((x) => x)),
    backgroundColor: json["background_color"]== null ? null : List<int>.from(json["background_color"].map((x) => x)),
    data: json["data"],
  );

  Map<String, dynamic> toMap() => {
    "text_color": textColor == null ? null : List<dynamic>.from(textColor.map((x) => x)),
    "background_color": backgroundColor== null ? null : List<dynamic>.from(backgroundColor.map((x) => x)),
    "data": data,
  };
}


