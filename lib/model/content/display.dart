import 'package:Pasaporte_2020/model/content/content_element.dart';

class Display {
  String shortTitle;
  List<ContentElement> content;
  List<Child> childs;
  final double fontSize;
  final String fontFamily;

  Display({
    this.shortTitle,
    this.content,
    this.childs,
    this.fontSize,
    this.fontFamily
  });

  factory Display.fromMap(Map<String, dynamic> json) => Display(
    shortTitle: json["short_title"],
    content: List<ContentElement>.from(
        json["content"].map((x) => ContentElement.fromMap(x))),
    childs: json["childs"] == null
        ? null
        : List<Child>.from(json["childs"].map((x) => Child.fromMap(x))),
    fontSize: json["fontSize"],
    fontFamily: json["fontFamily"],

  );

  Map<String, dynamic> toMap() => {
    "short_title": shortTitle,
    "content": List<dynamic>.from(content.map((x) => x.toMap())),
    "childs": childs == null
        ? null
        : List<dynamic>.from(childs.map((x) => x.toMap())),
    "fontSize": fontSize,
    "fontFamily": fontFamily,

  };
}

class Child {
  String id;
  int order;
  String title;
  List<int> backgroundColor;
  List<int> textColor;
  List<int> lineColor;
  String image;
  double fontSize;
  String fontFamily;

  Child(
      {this.id, this.order, this.title, this.backgroundColor, this.textColor,this.image,this.lineColor,this.fontSize,this.fontFamily});

  factory Child.fromMap(Map<String, dynamic> json) => Child(
    id: json["id"],
    order: json["order"],
    title: json["title"],
    backgroundColor: json["backgroundColor"] == null
        ? null
        : List<int>.from(json["backgroundColor"].map((x) => x)),
    textColor: json["textColor"] == null
        ? null
        : List<int>.from(json["textColor"].map((x) => x)),
    image: json["image"],
    lineColor: json["lineColor"] == null
        ? null
        : List<int>.from(json["lineColor"].map((x) => x)),
    fontSize: json["fontSize"],
    fontFamily: json["fontFamily"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order": order,
    "title": title,
    "backgroundColor": backgroundColor == null
        ? null
        : List<dynamic>.from(backgroundColor.map((x) => x)),
    "textColor": textColor == null
        ? null
        : List<dynamic>.from(textColor.map((x) => x)),
    "image": image,
    "lineColor": lineColor == null
        ? null
        : List<dynamic>.from(textColor.map((x) => x)),
    "fontSize": fontSize,
    "fontFamily": fontFamily,

  };
}